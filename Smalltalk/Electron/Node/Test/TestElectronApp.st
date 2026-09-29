CLASS TestElectronApp EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

test
	| electronApp name userAgent |

	electronApp := ElectronApp new.

	self assert: [ electronApp isReady class = Boolean ].
	self assert: [ electronApp getVersion isEmpty not ].
	self assert: [ electronApp getAppPath isEmpty not ].
	self assert: [ ( electronApp getPath: 'temp' ) isEmpty not ].
	self assert: [ electronApp getLocale class = String ].
	self assert: [ electronApp getPreferredSystemLanguages class = Array ].
	self assert: [ electronApp isHardwareAccelerationEnabled class = Boolean ].
	self assert: [ electronApp hasSingleInstanceLock class = Boolean ].

	name := electronApp getName.
	self assert: [ name isEmpty not ].
	self assert: [ electronApp name = name ].
	electronApp name: 'TestName'.
	self assert: [ electronApp getName = 'TestName' ].
	electronApp setName: name.
	self assert: [ electronApp name = name ].

	userAgent := electronApp userAgentFallback.
	electronApp userAgentFallback: 'TestAgent'.
	self assert: [ electronApp userAgentFallback = 'TestAgent' ].
	electronApp userAgentFallback: userAgent.
	self assert: [ electronApp userAgentFallback = userAgent ].
!
