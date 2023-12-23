CLASS TestBrowserApp EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| app |

	app := BrowserApp new.

	self assert: [ app testMode | true ].
	self assert: [ app url startsWith: 'http' ].

	"These methods are to destructive to test here:
		navigateTo: url
		stop"
!
