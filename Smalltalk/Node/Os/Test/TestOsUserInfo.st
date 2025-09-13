CLASS TestOsUserInfo EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

test
	| info |
	info := Os userInfo.

	self assert: [ info class = OsUserInfo ].
	self assert: [ info username length > 0 ].
	self assert: [ info homedir length > 0 ].

	Os isWindows
		ifTrue: [ self checkInfoWindows: info ]
		ifFalse: [ self checkInfoUnix: info ].
!
checkInfoWindows: info
	self assert: [ info uid = -1 ].
	self assert: [ info gid = -1 ].
	self assert: [ info shell isNil ].
!
checkInfoUnix: info
	self assert: [ info uid >= 0 ].
	self assert: [ info gid >= 0 ].
	self assert: [ info shell length > 0 ].
!
