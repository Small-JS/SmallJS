CLASS AiClientApp EXTENDS BrowserApp MODULE AiClientApp CLASSVARS ''
	VARS 'aiProviders providerSelect modelSelect
		conversationTable conversationQuestionTemplate conversationAnswerTemplate conversationClearButton
		questionTextArea questionAskButton errorSpan'

METHODS

start
	self bindElements.
	self loadData.

	self testMode ifTrue: [
		TestAiClientApp new test: self ].
!
bindElements
	providerSelect := Document getElementById: 'providerSelect' class: HtmlSelectElement.
	providerSelect addEventListener: 'change' then: [ self onOnProviderChange ].
	modelSelect := Document getElementById: 'modelSelect' class: HtmlSelectElement.

	conversationTable := Document getElementById: 'conversationTable' class: HtmlTableElement.
	conversationQuestionTemplate := Document getElementById: 'conversationQuestionTemplate' class: HtmlTemplateElement.
	conversationAnswerTemplate := Document getElementById: 'conversationAnswerTemplate' class: HtmlTemplateElement.
	conversationClearButton := Document getElementById: 'conversationClearButton' class: HtmlButtonElement.
	conversationClearButton onClick: [ :event | self clearConversation ].

	questionTextArea := Document getElementById: 'questionTextArea' class: HtmlTextAreaElement.
	questionTextArea value: 'Say this is a test'.
	questionAskButton := Document getElementById: 'questionAskButton' class: HtmlButtonElement.
	questionAskButton onClick: [ :event | self askQuestion ].

	errorSpan := Document getElementById: 'errorSpan' class: HtmlSpanElement.
!
loadData
	providerSelect length: 0.

	Fetch
		object: self url, '/api/providers'
		then: [ :object | self onProvidersResponse: object ]
		catch: [ :error | self onError: error ] .
!
onProvidersResponse: object
	| providers option |

	aiProviders := AiProviders fromObject: object.
	providers := aiProviders providers.
	providers length > 0 ifFalse: [
		errorSpan textContent: 'No AI providers available. Check .env file on server.'.
		^ nil ].

	providers do: [ :provider |
		option := Document default createElement: 'option'.
		option text: provider.
		option value: provider.
		providerSelect add: option ].

	self onOnProviderChange.
!
onOnProviderChange
	"Set models for selected provider"
	|  provider |

	provider := providerSelect value.
	provider ifNotNil: [
		self setModelsFor: provider ].
!
setModelsFor: provider
	| models option |

	modelSelect length: 0.

	models := aiProviders modelsFor: provider.
	models do: [ :model |
		option := Document default createElement: 'option'.
		option value: model.
		option text: model.
		modelSelect add: option ].
!
clearConversation
	conversationTable removeChildren.
!
askQuestion
	| request url |

	request := AiChatRequest new
		provider: providerSelect value;
		model: modelSelect value;
		text: questionTextArea value.

	url := self url, '/api/chat', request toUrlQuery.
	Fetch
		object: url
		then: [ :object | self onAskResponse: object ]
		catch: [ :error | self onError: error ] .
!
onAskResponse: object
	| response |

	response := AiChatResponse fromObject: object.
	response success
		ifTrue: [ self displayResponse: response ]
		ifFalse: [ errorSpan textContent: response text ].
!
displayResponse: response
	|  questionRow questionSpan answerRow answerSpan |

	questionRow := conversationQuestionTemplate cloneContent firstElementChild.
	questionSpan := questionRow cells first firstElementChild.
	questionSpan textContent: questionTextArea value.
	conversationTable appendChild: questionRow.

	answerRow := conversationAnswerTemplate cloneContent firstElementChild.
	answerSpan := answerRow cells first lastElementChild.
	answerSpan textContent: response text.
	conversationTable appendChild: answerRow.
!
onError: error
	errorSpan textContent: 'Error: ', error message.
!

"Accessing (used by tests)"

providerSelect
	^ providerSelect.
!
modelSelect
	^ modelSelect.
!
conversationTable
	^ conversationTable.
!
conversationClearButton
	^ conversationClearButton.
!
questionTextArea
	^ questionTextArea.
!
questionAskButton
	^ questionAskButton.
!
errorSpan
	^ errorSpan.
!
