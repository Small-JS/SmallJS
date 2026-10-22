CLASS TestBrowserApp EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| app |

	app := BrowserApp new.

	"Tests always run with '?test' in the URL."
	self assert: [ app testMode ].
	self assert: [ app url startsWith: 'http' ].

	"These methods are to destructive to test here:
		navigateTo: url
		stop
	 They are tested in the examples."
!
