#!/usr/bin/env tclsh8.6
#
## Advent of Code 2018 - Day 1
#

source "../common.tcl"

namespace eval ::dayOne {
	variable lines [::common::input]
	variable foundFreqs; array set ::dayOne::foundFreqs [list]
}

proc ::dayOne::total {str total} {
	set num [string trimleft $str {+-}]
	if {[string match [string index $str 0] {+}]} {
		return [expr {$total + $num}]
	}
	return [expr {$total - $num}]
}

proc ::dayOne::partOne {} {
	variable total 0
	foreach line $::dayOne::lines {
		set total [::dayOne::total $line $total]
	}
	::common::log "PartOne: $total"
}

proc ::dayOne::partTwo {{total 0} {loop 0}} {
	foreach line $::dayOne::lines {
		set total [::dayOne::total $line $total]
		if {[info exists ::dayOne::foundFreqs($total)]} {
			::common::log "PartTwo: dupe $total after $loop loops/[array size ::dayOne::foundFreqs] freqs"
			return
		}
		set ::dayOne::foundFreqs($total) {}
	}
	tailcall ::dayOne::partTwo $total [incr loop]
}

::dayOne::partOne
::dayOne::partTwo
