CLASS TestOsNetworkInterfaceInfo EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

test
	Os networkInterfaces values do: [ :infos |
		 infos do: [ :info |
		 	self checkInfo: info  ] ].
!
checkInfo: info
	self assert: [ info class = OsNetworkInterfaceInfo ].

	info family = 'IPv4'
		ifTrue: [ self checkInfoIpv4: info ]
		ifFalse: [
			info family = 'IPv6'
				ifTrue: [ self checkInfoIpv6: info ]
				ifFalse: [ self assert: [ false ] ] ].
!
checkInfoIpv4: info
	self assert: [ ( info address search: '[0-9]+\\.' ) = 0 ].
	self assert: [ ( info netmask search: '[0-9]+\\.' ) = 0 ].
	"Cidr is nil if the netmask is invalid."
	self assert: [ info cidr isNil or: [ ( info cidr search: '[0-9]+\\.' ) = 0 ] ].
	self assert: [ ( info mac search: '[0-9a-z][0-9a-z]:' ) = 0 ].
	self assert: [ info internal class = Boolean ].
!
checkInfoIpv6: info
	self assert: [ ( info address search: '[0-9a-z]*:' ) = 0 ].
	self assert: [ info scopeid >= 0 ].
	self assert: [ ( info netmask search: '[0-9a-z]*:' ) = 0 ].
	self assert: [ info cidr isNil or: [ ( info cidr search: '[0-9a-z]*:' ) = 0 ] ].
	self assert: [ ( info mac search: '[0-9a-z][0-9a-z]:' ) = 0 ].
	self assert: [ info internal class = Boolean ].
!
