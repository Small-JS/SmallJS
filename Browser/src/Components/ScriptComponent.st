CLASS ScriptComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'script runButton countSpan'

htmlPath
	^ 'Components/ScriptComponent.html'.
!
start
	self loadScript.
	self bindElements.
!
bindElements
	script := Document getElementById: 'script' class: HtmlScriptElement.
	runButton := Document getElementById: 'scriptRunButton' class: HtmlButtonElement.
	countSpan := Document getElementById: 'scriptCountSpan' class: HtmlSpanElement.

	runButton onClick: [ INLINE 'ScriptFunction()' ].
!

loadScript
	"Script must be loaded as a serarate node.
	 It will not execute when loaded as part of the component HTML, per HTML design."

	| document script |
	document := Document default.
	( document getElementById: 'script' ) notNil ifTrue: [ ^ self ].

	script := document createElement: 'script'.
	script id: 'script'.
	script src: 'Components/ScriptFunction.js'.

	document head appendChild: script.
!

"Accessing"

script
	^ script.
!
runButton
	^ runButton.
!
countSpan
	^ countSpan.
!
