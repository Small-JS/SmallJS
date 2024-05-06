CLASS PlaygroundApp EXTENDS BrowserApp MODULE Playground CLASSVARS ''
	VARS 'expressionTextArea evaluateButton resultTextArea'

start
	self bindElements.

	expressionTextArea value: '10 factorial'.

	self testMode ifTrue: [
		TestPlaygroundApp new test: self ].
!
bindElements
	"Bind HTML elements to vars, set defaults, set event listeners."

	expressionTextArea := Document getElementById: 'expressionTextArea' class: HtmlTextAreaElement.

	evaluateButton := Document getElementById: 'evaluateButton' class: HtmlButtonElement.
	evaluateButton onClick: [ self evaluate ].

	resultTextArea := Document getElementById: 'resultTextArea' class: HtmlTextAreaElement.
!
evaluate
	Playground new
		evaluate: expressionTextArea value
		onResult: [ :result | self onEvaluate: result ]
		onError: [ :error | self onError: error ].
!
onEvaluate: result
	resultTextArea value: result toString.
!
onError: error
	resultTextArea value: error toString.
!

"Accessing (used by tests)"

expressionTextArea
	^ expressionTextArea.
!
evaluateButton
	^ evaluateButton.
!
resultTextArea
	^ resultTextArea.
!
