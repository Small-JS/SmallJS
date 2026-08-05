-- Activate Postgres vector extension.
-- See Setup.md in how to install it.

CREATE EXTENSION IF NOT EXISTS vector;

-- Ceate documents table with text content and embedding vector per document

CREATE TABLE documents (
	id SERIAL PRIMARY KEY,
	content TEXT NOT NULL,
	embedding VECTOR( 768 )
);
