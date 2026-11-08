CLASS TestIntlSegmenter EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

"Tests use explicit locales and the UTC time zone, so the results do not depend on the system settings."

METHODS

test
	| segmenter segments |
	segmenter := IntlSegmenter locales: 'en-US'.
	self assert: [ segmenter class = IntlSegmenter ].
	segments := segmenter segment: 'abc'.
	self assert: [ segments length = 3 ].
	self assert: [ segments first class = IntlSegment ].
	self assert: [ segments first segment = 'a' ].
	self assert: [ segments first isWordLike isNil ].
!
testWords
	| options segmenter segments segment |
	options := JsObject newEmpty atJsProperty: 'granularity' put: 'word'.
	segmenter := IntlSegmenter locales: 'en-US' options: options.
	segments := segmenter segment: 'Hello world'.
	self assert: [ ( segments map: [ :each | each segment ] ) = #( 'Hello' ' ' 'world' ) ].
	self assert: [ segments first isWordLike ].
	self assert: [ ( segments at: 1 ) isWordLike not ].
	self assert: [ ( segments at: 2 ) index = 6 ].
	self assert: [ ( segments at: 2 ) input = 'Hello world' ].

	segment := segmenter segment: 'Hello world' containing: 8.
	self assert: [ segment segment = 'world' ].
	self assert: [ ( segmenter segment: 'Hello world' containing: 20 ) isNil ].
!
