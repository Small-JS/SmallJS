CLASS AiClientApp EXTENDS BrowserApp MODULE AiClientApp CLASSVARS ''
	VARS 'aiProviders providerSelect modelSelect
		conversationMessages conversationTable conversationQuestionTemplate conversationAnswerTemplate conversationClearButton
		questionTextArea questionAskButton errorSpan'

"Note:
	The variable 'conversationMessages' is a String array that holds the user questions and AI answers,
	alternating and starting with a question.
	It is resent to the AI with every new question, to give the AI the context of the conversation."

METHODS

constructor
	conversationMessages := #().
!
async start
	self bindElements.
	await self loadData.
!
bindElements
	providerSelect := Document getElementById: 'providerSelect' class: HtmlSelectElement.
	providerSelect addEventListener: 'change' then: [ self onProviderChange ].
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
	"Enabled only when providers are loaded."
	questionAskButton disabled: true.

	object := await async [ await Fetch object: self url, '/api/providers' ]
		tryAwaitCatch: [ :error | self onError: error. nil ].
	object ifNil: [ ^ nil ].

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

	self onProviderChange.
	questionAskButton disabled: false.
!
onProviderChange
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
	conversationMessages := #().
	conversationTable removeChildren.
	errorSpan textContent: ''.
!
async askQuestion
	"The question and answer are only added to the conversation if the AI answered successfully.
	 The Ask button is disabled while waiting for the answer, to prevent overlapping requests.
	 If the conversation is cleared while waiting, the answer is discarded."
	| question startMessages messages request object response |

	question := questionTextArea value.
	question trim isEmpty ifTrue: [
		^ errorSpan textContent: 'Please enter a question.' ].
	errorSpan textContent: ''.

	startMessages := conversationMessages.
	messages := startMessages copy.
	messages add: question.
	request := AiChatRequest new
		provider: providerSelect value;
		model: modelSelect value;
		messages: messages.

	questionAskButton disabled: true.
	object := await async [ await self fetchChat: request ]
		tryAwaitCatch: [ :error | self onError: error. nil ].
	questionAskButton disabled: false.
	object ifNil: [ ^ nil ].

	conversationMessages == startMessages ifFalse: [ ^ nil ].
	response := AiChatResponse fromObject: object.
	response success ifFalse: [
		^ errorSpan textContent: response text ].

	messages add: response text.
	conversationMessages := messages.
	self displayQuestion: question answer: response text.
!
async fetchChat: request
	"Answer the response object of a POST request with the request as JSON body."
	| options |
	options := RequestInit new
		method: 'POST';
		headers: ( Headers new set: 'content-type' value: 'application/json' );
		body: request toObject toJson.
	^ await Fetch object: self url, '/api/chat' options: options.
!
displayQuestion: question answer: answer
	|  questionRow questionSpan answerRow answerSpan |

	questionRow := conversationQuestionTemplate cloneContent firstElementChild.
	questionSpan := questionRow cells first firstElementChild.
	questionSpan textContent: question.
	conversationTable appendChild: questionRow.

	answerRow := conversationAnswerTemplate cloneContent firstElementChild.
	answerSpan := answerRow cells first lastElementChild.
	answerSpan textContent: answer.
	conversationTable appendChild: answerRow.
!
onError: error
	errorSpan textContent: 'Error: ', error message.
!

"Accessing (used by tests)"

conversationMessages
	^ conversationMessages.
!
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
