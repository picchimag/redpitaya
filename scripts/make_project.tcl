# Regenerate a Vivado project from its committed recipe (projects/<name>/bd.tcl).
#
#   vivado -mode batch -source scripts/make_project.tcl -tclargs <project_name>
#
# The project is (re)created under projects/<name>/build/ from scratch. That
# directory is disposable and gitignored; the only tracked inputs are rtl/,
# cores/, constr/ and the per-project bd.tcl.

set part "xc7z010clg400-1"

set proj [lindex $argv 0]
if {$proj eq ""} {
    puts "ERROR: usage: make_project.tcl -tclargs <project_name>"
    exit 1
}

set root      [file normalize [file join [file dirname [info script]] ..]]
set proj_dir  [file join $root projects $proj]
set build_dir [file join $proj_dir build]
set bd_recipe [file join $proj_dir bd.tcl]

if {![file exists $bd_recipe]} {
    puts "ERROR: no recipe at $bd_recipe -- export it first with export_bd.tcl"
    exit 1
}

file delete -force $build_dir
create_project $proj $build_dir -part $part -force

# HDL sources: add the whole rtl/ and cores/ trees. Vivado only elaborates
# modules reachable from the top, so unused blocks are harmless. Empty files are
# skipped defensively -- the real top is the block-design wrapper generated below.
foreach f [glob -nocomplain [file join $root rtl *.v] [file join $root cores *.v]] {
    if {[file size $f] > 0} {
        add_files -norecurse $f
    }
}

# Constraints.
add_files -fileset constrs_1 -norecurse [glob -nocomplain [file join $root constr *.xdc]]
set relax [file join $root constr filter_timing_relax.xdc]
if {[file exists $relax]} {
    set_property PROCESSING_ORDER LATE [get_files [file tail $relax]]
}

# Rebuild the block design from the recipe, then generate + import its wrapper
# and mark it top.
source $bd_recipe

set bd [lindex [get_bd_designs] 0]
validate_bd_design
save_bd_design
set bd_file [get_files ${bd}.bd]
generate_target all $bd_file
make_wrapper -files $bd_file -top -import
set_property top ${bd}_wrapper [current_fileset]
update_compile_order -fileset sources_1

puts "OK: regenerated project '$proj' (bd '$bd', top '${bd}_wrapper') in $build_dir"
