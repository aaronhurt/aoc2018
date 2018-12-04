#!/usr/bin/env tclsh
#
## Advent of Code 2018 - Day 1
#

source "../common.tcl"

namespace eval ::dayOne {
	variable ::dayOne::foundFreqs; array set ::dayOne::foundFreqs [list]
}

proc ::dayOne::partOne {} {
	variable total 0
	foreach line [::common::input] {
		set total [expr $total $line]
	}
	::common::log "PartOne: $total"
}

proc ::dayOne::partTwo {{total 0} {loop 0}} {
	foreach line [::common::input] {
		set total [expr $total $line]
		if {[info exists ::dayOne::foundFreqs($total)]} {
			::common::log "PartTwo: dupe $total after $loop loops/[array size ::dayOne::foundFreqs] freqs"
			return
		}
		set ::dayOne::foundFreqs($total) {}
	}
	set loop [expr $loop + 1]
	::dayOne::partTwo $total $loop
}

::dayOne::partOne
::dayOne::partTwo