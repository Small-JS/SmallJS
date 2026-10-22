CLASS ScriptComponent EXTENDS Component MODULE MyBrowserApp CLASSVARS ''
	VARS 'script runButton countSpan'

htmlPath
	^ 'Components/ScriptComponent.html'.
!
async start
	await self loadScript.
	self bindElements.
!
bindElements
	script := Document getElementById: 'script' class: HtmlScriptElement.
	runButton := Document getElementById: 'scriptRunButton' class: HtmlButtonElement.
	countSpan := Document getElementById: 'scriptCountSpan' class: HtmlSpanElement.

	runButton onClick: [ INLINE 'ScriptFunction()' ].
!

async loadScript
	"Script must be loaded as a serarate node.
	 It will not execute when loaded as part of the component HTML, per HTML design.
	 Wait until the script has loaded, so ScriptFunction can be called."

	| document scriptElement loaded |
	document := Document default.
	( document getElementById: 'script' ) notNil ifTrue: [ ^ self ].

	scriptElement := document createElement: 'script'.
	scriptElement id: 'script'.
	scriptElement src: 'Components/ScriptFunction.js'.

	loaded := Promise new: [ :resolve :reject |
		scriptElement addEventListener: 'load' then: [ resolve value: nil ].
		scriptElement addEventListener: 'error' then: [
			reject value: ( Error new: 'Failed to load script: ', scriptElement src ) ] ].
	document head appendChild: scriptElement.
	INLINE 'await loaded.js'.
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
