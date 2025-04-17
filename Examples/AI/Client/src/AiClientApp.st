CLASS AiClientApp EXTENDS BrowserApp MODULE AiClientApp CLASSVARS ''
	VARS 'aiProviders providerSelect modelSelect questionTextArea askButton answerTextArea errorSpan'

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

	questionTextArea := Document getElementById: 'questionTextArea' class: HtmlTextAreaElement.
	questionTextArea value: 'Say this is a test'.

	askButton := Document getElementById: 'askButton' class: HtmlButtonElement.
	askButton onClick: [ :event | self onAsk ].

	answerTextArea := Document getElementById: 'answerTextArea' class: HtmlTextAreaElement.

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
		providerSelect add: option ].

	self onOnProviderChange.
!
onOnProviderChange
	"Set models for selected provider"
	|  provider |

	provider := providerSelect selectedText.
	provider ifNotNil: [
		self setModelsFor: provider ].
!
setModelsFor: provider
	| models option |

	modelSelect length: 0.

	models := aiProviders modelsFor: provider.
	models do: [ :model |
		option := Document default createElement: 'option'.
		option text: model.
		modelSelect add: option ].
!
onAsk
	| request url |

	answerTextArea value: ''.

	request := AiChatRequest new
		provider: providerSelect selectedText;
		model: modelSelect selectedText;
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
		ifTrue: [ answerTextArea value: response text  ]
		ifFalse: [ errorSpan textContent: response text ].
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
questionTextArea
	^ questionTextArea.
!
askButton
	^ askButton.
!
answerTextArea
	^ answerTextArea.
!
errorSpan
	^ errorSpan.
!
