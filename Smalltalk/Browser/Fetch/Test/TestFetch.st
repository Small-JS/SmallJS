CLASS TestFetch EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	Fetch file: 'Test/MyObject.json'
		then: [ :string | self onFetchFile: string ]
		catch: [ :error | error throw ].

	Fetch object: 'Test/MyObject.json'
		then: [ :object | self onFetchObject: object ]
		catch: [ :error | error throw ].

!
onFetchFile: string
	self assert: [ string includes: 'John' ].
!
onFetchObject: object
	self assert: [ ( object atProperty: 'name' ) = 'John' ].
	self assert: [ ( object atProperty: 'age' ) = 33 ].
!
