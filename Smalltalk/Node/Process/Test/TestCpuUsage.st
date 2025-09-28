CLASS TestCpuUsage EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

test
	| cpuUsage |

	cpuUsage := Process cpuUsage.
	self assert: [ cpuUsage user >= 0 ].
	self assert: [ cpuUsage system >= 0 ].

	cpuUsage := Process threadCpuUsage.
	self assert: [ cpuUsage user >= 0 ].
	self assert: [ cpuUsage system >= 0 ].
!
