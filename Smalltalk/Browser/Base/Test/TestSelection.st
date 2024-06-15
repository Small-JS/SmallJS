CLASS TestSelection EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| document selection range selectionInput selectionResultLabel text |

	"Limited testing here.
	Selections need an active window to be tested fully.
	This is done by TestSelectionComponent in the Browser project."

	selection := Selection new.

	self assert: [ selection anchorNode isNil ].
	self assert: [ selection anchorOffset = 0 ].
	self assert: [ selection focusNode isNil ].
	self assert: [ selection focusOffset = 0 ].
	self assert: [ selection isCollapsed ].
	self assert: [ selection rangeCount = 0 ].
	self assert: [ selection type = 'None' ].
!