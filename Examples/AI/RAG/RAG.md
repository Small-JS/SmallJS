# AI RAG example app

This is an educational app implementing AI RAG.

RAG stands for Retrieval Augmented Generation.\
It is used for querying a LLM within a specific context of documents,\
when those documents are is to too large to be passed as a prompt.

This app will first index some documents into a vector store.\
Then then a user query is executed strictly within the context of these documents.\
The best matching documents are retrieved from the vector store,\
and are then attached to the query to a normal LLM,\
producing a human readable result.

Ollama is used for the document embedding and the querying.\
Postgres is used to store the embedding vectors using the extension pgvector.\
So everyting runs locally, independent of cloud AI providers.

Note:\
For simplicity, this example app is self contained and has no server and client components.\
To see how to do that, check out the `Server` and `Client` projects in the parent folder.

## Setup

First install all the prerequisites be using [Setup.md](doc/Setup.md).

## Running

Then run the code in indexing and then query mode.\
It's described in [Running.md](doc/Running.md).

## Code

When everying ran, check out the code how it works.\
It's described here: [Code.md](doc/Code.md).

## Have fun!

