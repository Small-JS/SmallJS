CLASS RagApp EXTENDS Object MODULE RagApp CLASSVARS ''
	VARS 'rag'

async start
	await self createRag.

	await ( Process argv includes: '-index' )
		ifTrueAwait: async [ await self indexDocuments ]
		ifFalseAwait: async [ await self queryRag: 'What is RAG?' ].

	self end.
!
async createRag
	| connectionString store |
	connectionString := self getEnv: 'SMALLJS_POSTGRES'.
	store := await PostgresRagStore new connect: connectionString.
	rag := OllamaRag store: store.
!

getEnv: variable
	"Return environment variable value or throw error if not found."
	| value |
	( value := Environment at: variable ) ifNil: [
		Error throw: 'Environment variable not set: ', variable ].
	^ value.
!

async indexDocuments
	| json documents |

	Console log: 'Indexing documents.'.

	await rag deleteDocuments.
	json := ( Fs readFileSync: 'documents.json' ) toString.
	documents := Object fromJson: json.
	await documents doAwait: async [ :document |
		await rag insertDocument: document ].

	Console log: 'Completed.'.
!
async queryRag: question
	| answer |
	Console log: 'Question: ', question.
	answer := await rag ask: question.
	Console log: 'Answer: ', answer.

	^ answer.
!

async end
	await rag end.
!

"Accessing - used in tests"

rag
	^ rag.
!
