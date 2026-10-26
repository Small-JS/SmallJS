CLASS TestOsCpuInfo EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

test
	Os cpus do: [ :cpuInfo |
		self checkCpuInfo: cpuInfo ].
!
checkCpuInfo: cpuInfo
	self assert: [ cpuInfo class = OsCpuInfo ].

	self assert: [ cpuInfo model length > 0 ].
	"Speed is 0 on some ARM machines and VMs.
	 Times can be 0 for a core that has hardly run, but not all of them."
	self assert: [ cpuInfo speed >= 0 ].

	self assert: [ cpuInfo user >= 0 ].
	self assert: [ cpuInfo sys >= 0 ].
	self assert: [ cpuInfo idle >= 0 ].
	self assert: [ cpuInfo user + cpuInfo sys + cpuInfo idle > 0 ].

	self assert: [ cpuInfo irq >= 0 ].
	self assert: [ cpuInfo nice >= 0 ].
!
