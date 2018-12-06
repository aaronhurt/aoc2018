#!/usr/bin/env tclsh8.6
#
## Advent of Code 2018 - Day 2
#

source "../common.tcl"

namespace eval ::dayTwo {
	variable lines [::common::input]
}

proc ::dayTwo::findDoubleTripple {string} {
	array set ret [list 2 0 3 0]
	set splitString [split $string ""]
	set charList [lsort -unique [split $string ""]]

	if {[llength $splitString] == [llength $charList]} {
		return [array get ret]
	}

	foreach c $charList {
		if {[set count [llength [lsearch -all -inline -exact $splitString $c]]]} {
			if {$count == 2 || $count == 3} {
				set ret($count) 1
			}
		}
	}

	return [array get ret]
}

proc ::dayTwo::partOne {} {
	array set counts [list 2 0 3 0]

	foreach line $::dayTwo::lines {
		array set lc [::dayTwo::findDoubleTripple $line]
		set counts(2) [expr {$counts(2) + $lc(2)}]
		set counts(3) [expr {$counts(3) + $lc(3)}]
	}
	::common::log "PartOne: [expr {$counts(2) * $counts(3)}]"
}

proc ::dayTwo::partTwo {} {
	array set sims [list]

	foreach aLine $::dayTwo::lines {
		set aSplit [split $aLine ""]
		foreach bLine $::dayTwo::lines {
			set dc 0
			set idx 0
			array set sims [list $aLine [list]]
			foreach aChar $aSplit bChar [split $bLine ""] {
				if {[string match $aChar $bChar] == 0} {
					incr dc
				} else {
					array set sims [list $aLine [linsert $sims($aLine) $idx $aChar]]
				}
				incr idx
			}
			if {$dc == 1} {
				::common::log "PartTwo: [join $sims($aLine) ""]"
				return
			}
		}
	}
}

::dayTwo::partOne
::dayTwo::partTwo
