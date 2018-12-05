#!/usr/bin/env tclsh
#
## Advent of Code 2018 - Day 1
#

source "../common.tcl"

namespace eval ::dayOne {
	variable lines [::common::input]
	variable foundFreqs; array set ::dayOne::foundFreqs [list]
}

proc ::dayOne::partOne {} {
	variable total 0
	foreach line $::dayOne::lines {
		set total [expr $total $line]; ## we know the input
	}
	::common::log "PartOne: $total"
}

proc ::dayOne::partTwo {{total 0} {loop 0}} {
	foreach line $::dayOne::lines {
		set total [expr $total $line]; ## we know the input
		if {[info exists ::dayOne::foundFreqs($total)]} {
			::common::log "PartTwo: dupe $total after $loop loops/[array size ::dayOne::foundFreqs] freqs"
			return
		}
		set ::dayOne::foundFreqs($total) [list]
	}
	incr loop
	::dayOne::partTwo $total $loop
}

::dayOne::partOne
::dayOne::partTwo
