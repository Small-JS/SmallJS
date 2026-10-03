CLASS TestElectronLoadFileOptions EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

testUnset
	| options |

	options := ElectronLoadFileOptions new.
	self assert: [ ( options queryAt: 'a' ) isNil ].
	self assert: [ options search isNil ].
	self assert: [ options hash isNil ].
!
testQuery
	| options |

	options := ElectronLoadFileOptions new.
	options queryKey: 'a' value: '1'.
	options queryKey: 'b' value: '2'.
	self assert: [ ( options queryAt: 'a' ) = '1' ].
	self assert: [ ( options queryAt: 'b' ) = '2' ].
	self assert: [ ( options queryAt: 'c' ) isNil ].

	"The query must be a plain JS object with string values, as expected by url.format()."
	self assert: [ ( String fromJs: ( INLINE 'JSON.stringify( options.js.query )' ) ) = '{"a":"1","b":"2"}' ].

	options queryKey: 'a' value: '3'.
	self assert: [ ( options queryAt: 'a' ) = '3' ].
!
testSearch
	| options |

	options := ElectronLoadFileOptions new.
	options search: '?a=1&b=2'.
	self assert: [ options search = '?a=1&b=2' ].
!
testHash
	| options |

	options := ElectronLoadFileOptions new.
	options hash: '#section'.
	self assert: [ options hash = '#section' ].
!
