#!/usr/bin/env tclsh
#
## Advent of Code 2018 - Common functions
#

namespace eval ::common {}

proc ::common::log {text} {
	puts stdout "[clock format [clock seconds] -format {[%H:%M:%S]}] $text"
}

proc ::common::input {} {
	if {[catch {set data [read [set fid [open "./input" r]]]} oError] != 0} {
		catch {close $fid}; ::common::log "Could not read input file :: $oError"; return
	}; catch {close $fid}
	return [split $data "\n"]
}
