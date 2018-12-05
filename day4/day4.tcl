#!/usr/bin/env tclsh
#
## Advent of Code 2018 - Day 4
#

source "../common.tcl"

namespace eval ::dayFour {
	variable lines [::common::input]
	variable minutes
	for {set x 0} {$x < 60} {incr x} {
		lappend minutes [format {%02d} $x]
	}
	variable counts [list]
}

proc ::dayFour::partOne {} {
	foreach line $::dayFour::lines {
		if {[scan [string tolower $line] {[%d-%d-%d %d:%d] %s %s} year month day hour minute w1 w2] != 7} {
			::common::log "PartOne: error parsing '$line'"
			return
		}
		set seconds [clock scan "$year-$month-$day $hour:$minute" -format {%Y-%m-%d %H:%M}]
		lappend events [list $seconds $w2]
	}

	set asleep 0; set gid 0; set sleepminute 0; array set sleepers [list]
	foreach event [lsort -integer -increasing -index 0 $events] {
		set eminute [scan [clock format [lindex $event 0] -format {%M}] {%d}]
		set etype [lindex $event 1]
		switch -glob -- $etype {
			{#*} {
				set gid [string trimleft $etype {#}]
				set asleep 0
			}
			{asleep} {
				set asleep 1
				set sleepminute $eminute
			}
			{up} {
				if {$asleep == 1} {
					for {set x $sleepminute} {$x < $eminute} {incr x} {
						lappend sleepers($gid) [format {%02d} [scan $x {%d}]]
					}
				}
				set asleep 0
			}
		}
	}

	foreach gid [array names sleepers] {
		set sleepers($gid) [lsort -increasing sleepers($gid)]
		set total [llength $sleepers($gid)]
		foreach min $dayFour::minutes {
			set mc [llength [lsearch -all -exact $sleepers($gid) $min]]
			lappend ::dayFour::counts [list $gid $min $mc $total]
		}
	}

	set temps [lsort -decreasing -integer -index 3 $::dayFour::counts]
	set gid [lindex $temps 0 0]
	set slept [lindex $temps 0 3]

	::common::log "PartOne: picked $gid asleep $slept minutes"

	set temps [lsort -decreasing -integer -index 2 [lrange $temps 0 59]]
	set sleepiest [lindex $temps 0 1]

	::common::log "PartOne: sleepiest minute $sleepiest"
	::common::log "PartOne: $gid * $sleepiest = [expr {$gid * $sleepiest}]"
}

proc ::dayFour::partTwo {} {
	set temps [lsort -decreasing -integer -index 2 $::dayFour::counts]

	foreach {gid min mc total} [lindex $temps 0] {}; ## shortcut assignment

	::common::log "PartTwo: guard $gid slept $mc times on minute $min"
	::common::log "PartTwo: $gid * $min = [expr {$gid * $min}]"
}

::dayFour::partOne
::dayFour::partTwo