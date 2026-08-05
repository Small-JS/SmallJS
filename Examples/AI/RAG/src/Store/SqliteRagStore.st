CLASS SqliteRagStore EXTENDS RagStore MODULE RagApp CLASSVARS '' VARS ''

INLINE 'import * as sqliteVec$ from "sqlite-vec";'

async connect: connectionString
	| options |
	options := SqliteDatabaseOptions new
		allowExtension: true.
	database := await SqliteDatabase new
		connect: connectionString options: options.
	"Enable the vector extension for the database."
	INLINE 'sqliteVec$.load( this.database.js )'.
!
async insertDocument: content embedding: embedding
	await database
		query: 'INSERT INTO documents ( content, embedding ) VALUES ( ?, ? )'
		with: #( content ( embedding toJson ) ).
!
async search: embedding limit: limit
	| result |
	"'match' calculates the vector cosine distances with the vec0 extension."
	result := await database
		query:
			'SELECT * FROM documents\n',
			'\tWHERE embedding match ?\n',
			'\tORDER BY distance LIMIT ?'
		with: #( ( embedding toJson ) limit ).

	^ result.
!
