CLASS TestProcess EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

test
	self assert: [ ( Process envAt: 'USERNAME' ) length > 0 ].

	self assert: [ ( Process envAt: 'SMALLJS_DATABASE' ) notNil ].
	self assert: [ ( Process envAt: 'SMALLJS_DATABASE' ) includes: 'postgres' ].

	self assert: [ ( Process envAt: 'SMALLJS_TEMP' ) isNil ].
	Process envAt: 'SMALLJS_TEMP' put: 'EnvData'.
	self assert: [ ( Process envAt: 'SMALLJS_TEMP' ) = 'EnvData' ].
	Process envDeleteAt: 'SMALLJS_TEMP'.
	self assert: [ ( Process envAt: 'SMALLJS_TEMP' ) isNil ].
!
