#!/usr/bin/env tclsh
#
## Advent of Code 2018 - Day 3
#

source "../common.tcl"

namespace eval ::dayThree {
	variable lines [::common::input]
	variable blank;		## blank list
	variable fabric;	## all cuts

	for {set idx 0} {$idx < 1000} {incr idx} {
		lappend blank [list 0]
	}

	for {set idx 0} {$idx < 1000} {incr idx} {
		lappend fabric $blank
	}
}

proc ::dayThree::partOne {} {
	set oops 0
	foreach line $::dayThree::lines {
		if {[scan $line "#%d @ %d,%d: %dx%d" id x1 y1 x2 y2] != 5} {
			::common::log "PartOne: error parsing '$line'"
			return
		}
		for {set x $x1} {$x < [expr {$x1 + $x2}]} {incr x} {
			for {set y $y1} {$y < [expr {$y1 + $y2}]} {incr y} {
				set val [lindex $::dayThree::fabric $x $y]
				lset ::dayThree::fabric $x $y [expr {$val + 1}]
				if {[lindex $::dayThree::fabric $x $y] == 2} {
					incr oops
				}
			}
		}
	}
	::common::log "PartOne: $oops"
}

proc ::dayThree::partTwo {} {
	foreach line $::dayThree::lines {
		if {[scan $line "#%d @ %d,%d: %dx%d" id x1 y1 x2 y2] != 5} {
			::common::log "PartOne: error parsing '$line'"
			return
		}
		set yas 1
		for {set x $x1} {$x < [expr {$x1 + $x2}]} {incr x} {
			for {set y $y1} {$y < [expr {$y1 + $y2}]} {incr y} {
				set val [lindex $::dayThree::fabric $x $y]
				if {$val > 1} {
					set yas 0
					continue
				}
			}
		}
		if {$yas == 1} {
			::common::log "PartTwo: $id"
		}
	}
}

::dayThree::partOne
::dayThree::partTwo