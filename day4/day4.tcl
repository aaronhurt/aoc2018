#!/usr/bin/env tclsh
#
## Advent of Code 2018 - Day 4
#

source "../common.tcl"

namespace eval ::dayFour {
	variable state
	variable minutes
	for {set x 0} {$x < 60} {incr x} {
		lappend minutes [format {%02d} $x]
	}
	variable sleeping; array set sleeping [list]
}

proc ::dayFour::partOne {} {
	foreach line [::common::input] {
		if {[scan [string tolower $line] {[%d-%d-%d %d:%d] %s %s} year month day hour minute w1 w2] != 7} {
			::common::log "PartOne: error parsing '$line'"
			return
		}
		set seconds [clock scan "$year-$month-$day $hour:$minute" -format {%Y-%m-%d %H:%M}]
		lappend ::dayFour::state [list $seconds $w2]
	}
	set asleep 0; set gid 0; set sleepminute 0
	foreach event [lsort -integer -increasing -index 0 $::dayFour::state] {
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
						lappend ::dayFour::sleeping($gid) [format {%02d} [scan $x {%d}]]
					}
				}
				set asleep 0
			}
		}
	}
	set picked 0
	foreach gid [array names ::dayFour::sleeping] {
		set ::dayFour::sleeping($gid) [lsort -increasing $::dayFour::sleeping($gid)]
		if {$picked == 0} {
			set picked $gid; continue
		}
		if {[llength $::dayFour::sleeping($gid)] > [llength $::dayFour::sleeping($picked)]} {
			set picked $gid
		}
	}
##	parray sleeping
	::common::log "PartOne: picked $picked asleep [llength $::dayFour::sleeping($picked)] minutes"
	set counts [list]
	foreach m $dayFour::minutes {
		lappend counts [list [llength [lsearch -all -exact $::dayFour::sleeping($picked) $m]] $m]
	}
	set sleepiest [lindex [lsort -decreasing -integer -index 0 $counts] 0 1]
	::common::log "PartOne: sleepiest minute $sleepiest"
	::common::log "PartOne: $picked * $sleepiest = [expr {$picked * $sleepiest}]"
}

proc ::dayFour::partTwo {} {
	set sleepers [list]; set sleepiest [list 0 0 0]
	foreach gid [array names ::dayFour::sleeping] {
		set counts [list]
		foreach m $dayFour::minutes {
			lappend counts [list [llength [lsearch -all -exact $::dayFour::sleeping($gid) $m]] $m $gid]
		}
		set counts [lsort -decreasing -integer -index 0 $counts]
		if {[lindex $counts 0 0] > [lindex $sleepiest 0]} {
			set sleepiest [lindex $counts 0]
		}
	}
	foreach {t m g} $sleepiest {}
	::common::log "PartTwo: guard $g slept $t times on minute $m"
	::common::log "PartTwo: $g * $m = [expr {$g * $m}]"
}

::dayFour::partOne
::dayFour::partTwo