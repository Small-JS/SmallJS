CLASS TestElectronApp EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

test
	| electronApp name userAgent |

	electronApp := ElectronApp new.

	self assert: [ electronApp ready class = Boolean ].
	self assert: [ electronApp version isEmpty not ].
	self assert: [ electronApp appPath isEmpty not ].
	self assert: [ ( electronApp path: 'temp' ) isEmpty not ].
	self assert: [ electronApp locale class = String ].
	self assert: [ electronApp preferredSystemLanguages class = Array ].
	self assert: [ electronApp hardwareAccelerationEnabled class = Boolean ].
	self assert: [ electronApp hasSingleInstanceLock class = Boolean ].

	name := electronApp name.
	self assert: [ name isEmpty not ].
	self assert: [ electronApp name = name ].
	electronApp name: 'TestName'.
	self assert: [ electronApp name = 'TestName' ].
	electronApp name: name.
	self assert: [ electronApp name = name ].

	userAgent := electronApp userAgentFallback.
	electronApp userAgentFallback: 'TestAgent'.
	self assert: [ electronApp userAgentFallback = 'TestAgent' ].
	electronApp userAgentFallback: userAgent.
	self assert: [ electronApp userAgentFallback = userAgent ].
!
