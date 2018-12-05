#!/usr/bin/env tclsh
#
## Advent of Code 2018 - Day 5
#

interp recursionlimit {} 10000
source "../common.tcl"

namespace eval ::dayFive {
	variable lines [::common::input]
	variable lcs [list a b c d e f g h i j k l m n o p q r s t u v w x y z]
	variable hcs [list A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]
	variable rm
	foreach lc $lcs hc $hcs {
		lappend rm $lc$hc {} $hc$lc {}
	}
}

proc ::dayFive::reactor {string} {
	set s2 [string map $::dayFive::rm $string]
	if {[string length $string] == [string length $s2]} {
		return [list $s2 [string length $s2]]
	}
	::dayFive::reactor $s2
}

proc ::dayFive::partOne {} {
	set r [::dayFive::reactor [lindex $::dayFive::lines 0]]
	::common::log "PartOne: [lindex $r 1]"
}

proc ::dayFive::partTwo {} {
	set line [lindex $::dayFive::lines 0]
	set len [string length $line]; set str ""
	foreach lc $::dayFive::lcs hc $::dayFive::hcs {
		::common::log "PartTwo: removing all $lc/$hc"
		set mapped [string map [list $lc {} $hc {}] $line]
		::common::log "PartTwo: pre-reactor length [string length $mapped]"
		set r [::dayFive::reactor $mapped]
		if {[lindex $r 1] < $len} {
			set len [lindex $r 1]
			set str [lindex $r 0]
			::common::log "PartTwo: new shortest $len"
		}
	}
	::common::log "PartTwo: $len"
}

::dayFive::partOne
::dayFive::partTwo