CLASS RagStore EXTENDS Object MODULE RagApp CLASSVARS ''
	VARS 'database'

"Abstract base class for RAG vector store implementations."

async connect: connectionString
	Error throw: 'Subclass responsibility'.
!
async disconnect
	database end.
!
async deleteDocuments
	await database query: 'DELETE FROM documents'.
!
async insertDocument: content embedding: embedding
	Error throw: 'Subclass responsibility'.
!
async search: embedding limit: limit
	Error throw: 'Subclass responsibility'.
!
