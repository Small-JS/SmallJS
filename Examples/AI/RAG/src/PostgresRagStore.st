CLASS PostgresRagStore EXTENDS Object MODULE RagApp CLASSVARS ''
	VARS 'database'

async connect: connectionString
	database := await PostgresDatabase new connect: connectionString.
!
async disconnect
	database end.
!
async deleteDocuments
	await database query: 'DELETE FROM documents'.
!
async insertDocument: content embedding: embedding
	await database
		query: 'INSERT INTO documents ( content, embedding ) VALUES ( $1, $2 )'
		with: #( content ( embedding toJson ) ).
!
async search: embedding limit: limit
	| result |
	"<=> calculates vector cosine distance with pgvector."
	result := await database
		query:
			'SELECT id, content, embedding <=> $1::vector AS distance\n',
			'\tFROM documents ORDER BY embedding <=> $1::vector LIMIT $2'
		with: #( ( embedding toJson ) limit ).

	^ result rows.
!

