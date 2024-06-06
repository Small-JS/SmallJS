CLASS TestHtmlDataListElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| document dataList option options |

	document := Document new.

	dataList := document createElement: 'datalist'.
	self assert: [ dataList class = HtmlDataListElement ].

	#( 'First' 'Second' ) do: [ :optionString |
		option := document createElement: 'option'.
		self assert: [ option class = HtmlOptionElement ].
		option value: optionString.
		dataList appendChild: option ].

	options := dataList options.
	self assert: [ options length = 2 ].
	self assert: [ options first value = 'First' ].
	self assert: [ ( dataList indexOf: 'Second' ) = 1 ].
	self assert: [ ( dataList indexOf: 'Missing' ) = -1 ].
!
