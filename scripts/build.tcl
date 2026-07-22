# Build the bitstream for an already-regenerated project and stage the .bit.
#
#   vivado -mode batch -source scripts/build.tcl -tclargs <project_name>
#
# Run make_project.tcl first. The resulting bitstream is copied to
# projects/<name>/<name>.bit; from there copy it into the redpitaya_control
# repo's bitfiles/ directory (the .bit itself is gitignored here).

set proj [lindex $argv 0]
if {$proj eq ""} {
    puts "ERROR: usage: build.tcl -tclargs <project_name>"
    exit 1
}

set root  [file normalize [file join [file dirname [info script]] ..]]
set xpr   [file join $root projects $proj build $proj.xpr]

if {![file exists $xpr]} {
    puts "ERROR: no project at $xpr -- run make_project.tcl first"
    exit 1
}

open_project $xpr
reset_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1

if {[get_property PROGRESS [get_runs impl_1]] ne "100%"} {
    puts "ERROR: impl_1 did not finish -- see the run log"
    exit 1
}

set bit [lindex [glob -nocomplain [file join $root projects $proj build $proj.runs impl_1 *.bit]] 0]
if {$bit eq ""} {
    puts "ERROR: no .bit produced"
    exit 1
}
set out [file join $root projects $proj $proj.bit]
file copy -force $bit $out
puts "OK: bitstream staged at $out"
