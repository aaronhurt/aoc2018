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
		return [list [string length $s2] $s2]
	}
	::dayFive::reactor $s2
}

proc ::dayFive::partOne {} {
	foreach {sl ss} [::dayFive::reactor [lindex $::dayFive::lines 0]] {}
	::common::log "PartOne: $sl"
	return $ss
}

proc ::dayFive::partTwo {string} {
	set len [string length $string]
	foreach lc $::dayFive::lcs hc $::dayFive::hcs {
##		::common::log "PartTwo: removing all $lc/$hc"
		set mapped [string map [list $lc {} $hc {}] $string]
		::common::log "PartTwo: pre-reactor length without $lc/$hc [string length $mapped]"
		foreach {sl ss} [::dayFive::reactor $mapped] {}
		if {$sl < $len} {
			set len $sl
			::common::log "PartTwo: new shortest $sl"
		}
	}
	::common::log "PartTwo: $len"
}

::dayFive::partTwo [::dayFive::partOne]
