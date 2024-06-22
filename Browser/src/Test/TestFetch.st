CLASS TestFetch EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	Fetch text: 'MyObject.json'
		then: [ :string | self onFetchFile: string ]
		catch: [ :error | error throw ].

	Fetch object: 'MyObject.json'
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
