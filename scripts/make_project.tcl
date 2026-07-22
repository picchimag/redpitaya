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

# Take the design name from the recipe itself. Do NOT infer it from
# get_bd_designs: IP such as smartconnect creates nested sub-designs, which that
# command also returns (and may return first), silently yielding the wrong top.
if {![info exists design_name]} {
    puts "ERROR: recipe $bd_recipe did not define design_name"
    exit 1
}
set bd $design_name
current_bd_design [get_bd_designs $bd]
validate_bd_design
save_bd_design
set bd_file [get_files ${bd}.bd]
# No explicit generate_target here: designs containing smartconnect hold nested
# sub-designs that Vivado refuses to generate directly (error 12-3563). Output
# products are built by their parent when synthesis runs, so leave it to the
# build step.
make_wrapper -files $bd_file -top -import
set_property top ${bd}_wrapper [current_fileset]
update_compile_order -fileset sources_1

puts "OK: regenerated project '$proj' (bd '$bd', top '${bd}_wrapper') in $build_dir"
