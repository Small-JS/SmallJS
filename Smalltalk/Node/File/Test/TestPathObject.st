CLASS TestPathObject EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

test
	| pathObject |
	pathObject := PathObject new.
	self assert: [ pathObject class = PathObject ].

	pathObject dir: '/dir'.
	self assert: [ pathObject dir = '/dir' ].

	pathObject root: '/'.
	self assert: [ pathObject root = '/' ].

	pathObject base: 'file.txt'.
	self assert: [ pathObject base = 'file.txt' ].

	pathObject name: 'file'.
	self assert: [ pathObject name = 'file' ].

	pathObject ext: '.txt'.
	self assert: [ pathObject ext = '.txt' ].
!
