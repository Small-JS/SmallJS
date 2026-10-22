CLASS TestComponent EXTENDS Test MODULE TestBrowser CLASSVARS 'component' VARS ''

test
	| app parent |

	component := Component new.
	app := BrowserApp new.
	parent := Component new.

	component app: app.
	self assert: [ component app = app ].

	component parent: parent.
	self assert: [ component parent = parent ].

	"Subclasses must implement htmlPath."
	self assert: [ ( [ component htmlPath ] tryCatch: [ :error | error ] ) message
		= 'Method should be implemented by subclass.' ].

	"Note: Loading a component is tested in the Browser project."
!
