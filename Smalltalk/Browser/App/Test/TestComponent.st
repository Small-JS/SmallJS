CLASS TestComponent EXTENDS Test MODULE TestDom CLASSVARS 'component' VARS ''

test
	| app parent |

	component := MyComponent new.
	app := BrowserApp new.
	parent := MyComponent new.

	component app: app.
	self assert: [ component app = app ].

	component parent: parent.
	self assert: [ component parent = parent ].

	"Note: The compontent start method is called automatically"
	component loadIntoElement: 'component' then: [ self onTest ].
!
onTest
	| style |

	self assert: [ component class = MyComponent ].
	self assert: [ component label class = HtmlLabelElement ].
	self assert: [ component label textContent startsWith: 'My component' ].
	self assert: [ component button class = HtmlButtonElement ].
!
