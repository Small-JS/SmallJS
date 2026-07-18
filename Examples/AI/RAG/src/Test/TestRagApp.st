CLASS TestRagApp EXTENDS Object MODULE TestRagApp CLASSVARS ''
	VARS 'ragApp'

"AiServer unit and API tests.
This class is not a subclass of Test so is not called automatically with Test all."

async start
	| answer |

	ragApp := RagApp new.
	await ragApp createRag.

	await ragApp indexDocuments.
	answer := await ragApp queryRag: 'What is RAG?'.
	self assert: [ answer toLowerCase includes: 'rag'].

	ragApp end.
!
