CLASS TestFindComponent EXTENDS Test MODULE TestMyBrowserApp CLASSVARS '' VARS ''

"Test finding the loaded components of MyBrowserApp."

METHODS

test
	| error |
	self assert: [ ( MyBrowserApp default findComponent: CssComponent ) class = CssComponent ].

	"A class that is not a loaded component raises an error with its name."
	error := [ MyBrowserApp default findComponent: Object ] tryCatch: [ :anError | anError ].
	self assert: [ error class = Error ].
	self assert: [ error message = 'Component class not found: Object' ].
!
