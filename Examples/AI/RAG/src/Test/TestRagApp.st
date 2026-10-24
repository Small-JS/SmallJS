CLASS TestRagApp EXTENDS Object MODULE TestRagApp CLASSVARS ''
	VARS 'ragApp'

"RagApp test: indexes the documents, then queries the RAG and checks the answer.
This class is not a subclass of Test so is not called automatically with Test all."

async start
	| error |

	ragApp := RagApp new.
	await ragApp createRag.

	"Always end the RAG to disconnect the store, also on errors, which are then rethrown."
	error := await async [
		| answer |
		await ragApp indexDocuments.
		answer := await ragApp queryRag: 'What is RAG?'.
		self assert: [ answer toLowerCase includes: 'rag' ].
		nil ]
		tryAwaitCatch: [ :caught | caught ].

	await ragApp end.
	error ifNotNil: [ error throw ].
	Console log: 'TestRagApp passed.'.
!
