CLASS AiClientApp EXTENDS BrowserApp MODULE AiClientApp CLASSVARS ''
	VARS 'aiProviders providerSelect modelSelect
		conversationQuestions conversationTable conversationQuestionTemplate conversationAnswerTemplate conversationClearButton
		questionTextArea questionAskButton errorSpan'

"Note:
	The variable 'conversationQuestions' is an string array that holds the user questions.
	It's is needed to resend it to an AI with every question, to allow the AI to have the conversation context."

METHODS

async start
	self bindElements.
	await self loadData.
!
bindElements
	providerSelect := Document getElementById: 'providerSelect' class: HtmlSelectElement.
	providerSelect addEventListener: 'change' then: [ self onOnProviderChange ].
	modelSelect := Document getElementById: 'modelSelect' class: HtmlSelectElement.
	modelSelect addEventListener: 'change' then: [ self onModelChange ].

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
async loadData
	| object providers option |
	providerSelect length: 0.

	object := await Fetch object: self url, '/api/providers'.
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

	self onModelChange.
!
onModelChange
	self clearConversation.
!
clearConversation
	conversationQuestions := #().
	conversationTable removeChildren.
!
async askQuestion
	| request url object response |

	conversationQuestions add: questionTextArea value.

	request := AiChatRequest new
		provider: providerSelect value;
		model: modelSelect value;
		messages: conversationQuestions.

	url := self url, '/api/chat', request toUrlQuery.
	object := await Fetch object: url.

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
