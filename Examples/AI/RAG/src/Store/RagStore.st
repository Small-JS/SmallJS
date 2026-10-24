CLASS RagStore EXTENDS Object MODULE RagApp CLASSVARS ''
	VARS 'database'

"Abstract base class for RAG vector store implementations."

async connect: connectionString
	self subclassResponsibility.
!
async disconnect
	await database end.
!
async deleteDocuments
	await database query: 'DELETE FROM documents'.
!
async insertDocument: content embedding: embedding
	self subclassResponsibility.
!
async search: embedding limit: limit
	self subclassResponsibility.
!
