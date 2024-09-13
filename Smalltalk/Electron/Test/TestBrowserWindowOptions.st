CLASS TestBrowserWindowOptions EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

test
	| options webPreferences |

	options := BrowserWindowOptions new.

	options width: 1000.
	self assert: [ options width = 1000 ].
	options height: 800.
	self assert: [ options height = 800 ].

	webPreferences := WebPreferences new.
	options webPreferences: webPreferences.
	self assert: [ options webPreferences = webPreferences ].
!
