CLASS OllamaRag EXTENDS Object MODULE RagApp CLASSVARS ''
	VARS 'ollama store'

CLASSMETHODS

store: store
	^ self new
		store: store.
!

METHODS

constructor
	ollama := Ollama new.
!
async deleteDocuments
	await store deleteDocuments.
!
async insertDocument: content
	| embedding |
	embedding := await self embed: content.
	await store insertDocument: content embedding: embedding.
!
async embed: content
	| request response |
	request := OllamaEmbedRequest new
		model: ollama embeddingModel;
		input: content.
	response := await ollama embed: request.

	^ response embedding.
!
async ask: question
	| documentRows documents context prompt response |
	documentRows := await self search: question limit: 1.
	documents := documentRows map: [ :documentRow | documentRow atProperty: 'content' ].
	context := documents join: '\n\n'.

	prompt := 'You are a helpful assistant.\n\n',
		'Context:\n', context, '\n\n',
		'Question:\n', question, '\n\n',
		'Answer using only the provided context.\n'.

	^ await ollama chat: #( prompt ).
!
async search: query limit: limit
	| queryEmbedding |
	queryEmbedding := await self embed: query.
	^ await store search: queryEmbedding limit: limit.
!
async end
	await store disconnect.
!

"Acccessing"

store
	^ store.
!
store: aStore
	store := aStore.
!
