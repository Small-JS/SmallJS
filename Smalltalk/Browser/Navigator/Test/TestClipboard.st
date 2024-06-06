CLASS TestClipboard EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Note reading and writing the clipboard may require user authorisation,
 so there are not automated unit tests possible for them.
 Functionality is tested in MyBrowserApp."

test
	| clipboard |

	clipboard := Window default navigator clipboard.
	self assert: [ clipboard class = Clipboard ].
!
