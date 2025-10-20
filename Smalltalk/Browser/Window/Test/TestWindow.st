CLASS TestWindow EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testPlatforms
	self assert: [ Window isFirefox | true ].
	self assert: [ Window isChromium | true ].
	self assert: [ Window isMacos | true ].
!
testProperties
	| window |
	window := Window default.

	self assert:[ window class = Window ].
	self assert:[ window closed not ].
	self assert:[ window console = Console ].
	self assert:[ window customElements class = CustomElementRegistry ].
	self assert:[ window devicePixelRatio > 0.0 ].
	self assert:[ window document = Document default ].
	self assert:[ window frameElement isNil ].
	self assert:[ window frames class = Window ].
	self assert:[ window history class = History ].
	self assert:[ window innerHeight > 0 ].
	self assert:[ window innerWidth > 0 ].
	self assert:[ window length >= 0 ].
	self assert:[ window localStorage class = Storage ].
	self assert:[ window location class = Location ].
	self assert:[ window locationBarVisible ].
	self assert:[ window menuBarVisible ].
	self assert:[ window navigator class = Navigator ].
	self assert:[ window opener isNil ].
	self assert:[ window outerHeight > 0 ].
	self assert:[ window outerWidth > 0 ].
	self assert:[ window pageXOffset >= 0 ].
	self assert:[ window pageYOffset >= 0 ].
	self assert:[ window parent = window ].
	self assert:[ window personalBarVisible ].
	self assert:[ window screen class = Screen ].
	self assert:[ window scrollBarsVisible | true ].
	self assert:[ window scrollX >= 0 ].
	self assert:[ window scrollY >= 0 ].
	self assert:[ window self class = Window ].
	self assert:[ window sessionStorage class = Storage ].
	self assert:[ window speechSynthesis class = SpeechSynthesis ].
	self assert:[ window statusBarVisible | true ].
	self assert:[ window toolBarVisible | true ].
	self assert:[ window top = window ].
	self assert:[ window visualViewport class = VisualViewport ].
	self assert:[ window window = window ].
!
