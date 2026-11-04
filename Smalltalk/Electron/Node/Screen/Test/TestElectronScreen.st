CLASS TestElectronScreen EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

"The screen can only be used after the app is ready,
 so these tests are skipped if the app is not ready yet."

test
	| screen primary workAreas matching |

	( ElectronApp new ready ) ifFalse: [ ^ self ].
	screen := ElectronScreen new.
	self assert: [ screen class = ElectronScreen ].

	self assert: [ screen displayCount >= 1 ].
	primary := screen primaryWorkArea.
	self assert: [ primary class = Rect ].
	self assert: [ primary extent x > 0 & ( primary extent y > 0 ) ].
	self assert: [ screen primaryBounds class = Rect ].

	workAreas := screen workAreas.
	self assert: [ workAreas length = screen displayCount ].
	self assert: [ workAreas includes: primary ].

	"A rect inside the primary work area matches it, a rect far away matches the nearest display."
	matching := screen workAreaMatching: ( Rect origin: primary origin + ( 10 @ 10 ) extent: 100 @ 100 ).
	self assert: [ matching = primary ].
	matching := screen workAreaMatching: ( Rect origin: 100000 @ 100000 extent: 100 @ 100 ).
	self assert: [ workAreas includes: matching ].

	self assert: [ screen cursorPoint class = Point ].
!
