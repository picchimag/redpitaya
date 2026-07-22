# Export a legacy Vivado project's block design to a committable recipe.
#
#   vivado -mode batch -source scripts/export_bd.tcl -tclargs <project_name>
#
# Opens the existing project at projects/<name>/<name>.xpr and writes
# projects/<name>/bd.tcl. Run this once per legacy project to capture it into
# git; afterwards the project regenerates from that recipe via make_project.tcl.
#
# The round-trip is only validated once you regenerate and diff -- do that for
# at least the tricky designs (CDMA / BRAM streaming, the z_control_v* family).

set proj [lindex $argv 0]
if {$proj eq ""} {
    puts "ERROR: usage: export_bd.tcl -tclargs <project_name>"
    exit 1
}

set root [file normalize [file join [file dirname [info script]] ..]]
set xpr  [file join $root projects $proj $proj.xpr]

if {![file exists $xpr]} {
    puts "ERROR: no legacy project at $xpr"
    exit 1
}

open_project $xpr
set bd_file [lindex [get_files -filter {FILE_TYPE == "Block Designs"}] 0]
if {$bd_file eq ""} {
    puts "ERROR: no block design found in $proj"
    exit 1
}
open_bd_design $bd_file
write_bd_tcl -force -include_layout [file join $root projects $proj bd.tcl]
close_project
puts "OK: wrote projects/$proj/bd.tcl"
