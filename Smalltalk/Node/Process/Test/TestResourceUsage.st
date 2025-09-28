CLASS TestResourceUsage EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

test
	| resourceUsage |
	resourceUsage := Process resourceUsage.
	self assert: [ resourceUsage class = ResourceUsage ].

	self assert: [ resourceUsage userCpuTime > 0 ].
	self assert: [ resourceUsage systemCpuTime > 0 ].
	self assert: [ resourceUsage maxRss > 0 ].

	self assert: [ resourceUsage minorPageFault >= 0 ].
	self assert: [ resourceUsage majorPageFault >= 0 ].
	self assert: [ resourceUsage swappedOut >= 0 ].

	self assert: [ resourceUsage fsRead >= 0 ].
	self assert: [ resourceUsage fsWrite >= 0 ].

	self assert: [ resourceUsage ipcSent >= 0 ].
	self assert: [ resourceUsage ipcReceived >= 0 ].
	self assert: [ resourceUsage signalsCount >= 0 ].

	self assert: [ resourceUsage voluntaryContextSwitches >= 0 ].
	self assert: [ resourceUsage involuntaryContextSwitches >= 0 ].
!
