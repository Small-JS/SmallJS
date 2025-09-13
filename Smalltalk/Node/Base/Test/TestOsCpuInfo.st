CLASS TestOsCpuInfo EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

test
	Os cpus do: [ :cpuInfo |
		self checkCpuInfo: cpuInfo ].
!
checkCpuInfo: cpuInfo
	self assert: [ cpuInfo class = OsCpuInfo ].

	self assert: [ cpuInfo model length > 0 ].
	self assert: [ cpuInfo speed > 0 ].

	self assert: [ cpuInfo user > 0 ].
	self assert: [ cpuInfo sys > 0 ].
	self assert: [ cpuInfo idle > 0 ].

	self assert: [ cpuInfo irq > 0 ].
	self assert: [ cpuInfo nice >= 0 ].
!
