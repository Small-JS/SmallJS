CLASS PlaygroundApp EXTENDS BrowserApp MODULE PlaygroundApp CLASSVARS ''
	VARS 'expressionTextArea evaluateButton resultTextArea'

start
	self bindElements.

	expressionTextArea value: '10 factorial'.
!
bindElements
	"Bind HTML elements to vars, set defaults, set event listeners."

	expressionTextArea := Document getElementById: 'expressionTextArea' class: HtmlTextAreaElement.
	expressionTextArea addEventListener: 'input'
		then: [ self oldResult ].

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
	self newResult.
	resultTextArea value: result toString.
!
onError: error
	self newResult.
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
oldResult
	"Result text to grey when expression has changed."
	resultTextArea classList add: 'oldResult'.
!
newResult
	"Result text to black on new result."
	resultTextArea classList remove: 'oldResult'.
!
