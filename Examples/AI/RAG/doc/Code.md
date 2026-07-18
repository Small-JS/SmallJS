# Code

## RagApp

This is the main app class. When started with the argument `-index`,\
it indexes the documents contained in `documents.json`\
into the Postgres table `documents`, which is emptied first.

When the app started in query mode (without arguments)\
it creates an `OllamaRag` instance, calls the method `ask:` with a question\
and then logs the repsponse on the console.

## PostgresRagStore

Class `PostgresRagStore` encapsulates access to the vector store in Postgres.\
It has methods to connect to the database, delete old documents,\
insert (embed) new documents with vectors and query similar documents\
with a vectorized question.

## OllamaRag

Class `OllamaRag` encapsulates access to 2 AI LLMs in Ollama:\
- An embedding model, e.g. `nomic-embed-text`, to store and query documents.\
- A simple query model, e.g. `llama3.2:1b`, for human readable responses\
  where the best matching embedded documents are given as context.

## Finished

What was all, hope you had fun. Or go back to [RAG.md](../RAG.md)

