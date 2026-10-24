This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folder: ../../../Examples.
The SmallJS standard library is located in the folder: ../../../Smalltalk.

This is the AI RAG example app: an educational, self-contained Node.js console app
implementing Retrieval Augmented Generation.
It first indexes documents (`documents.json`) as embedding vectors into a vector store,
then answers a question with an LLM, using the best matching documents as context.
Everything runs locally: Ollama for embedding and chat,
SQLite (with the sqlite-vec extension) or Postgres (with pgvector) as vector store.
User documentation is in: RAG.md, with details in doc/Setup.md, doc/Running.md and doc/Code.md.

The app uses these SmallJS library folders:
- ../../../Smalltalk/Core: core classes.
- ../../../Smalltalk/Node: Node.js API wrappers, e.g. Environment, Fs, Process,
  and Database/Sqlite (SqliteDatabase, SqliteDatabaseOptions) and Database/Postgres (PostgresDatabase).
- ../../../Smalltalk/AI/Shared: classes shared by AI server and client.
- ../../../Smalltalk/AI/Node: server-side AI classes; this app uses the Ollama subfolder
  (Ollama, OllamaEmbedRequest).

Related projects: ../Server (AI Server), ../Client (AI Client, browser app).

## Source code

- All source code of this app is in the folder: ./src
- `main.ts`: entry point. With argument `-test` it starts `TestRagApp`, otherwise `RagApp`.
- `RagApp.st`: connects the vector store selected by `STORE_CONFIG` and creates an `OllamaRag`.
  With argument `-index` it empties the `documents` table and indexes `documents.json`;
  without arguments it asks the question 'What is RAG?' and logs the answer.
- `OllamaRag.st`: embeds documents and questions with the Ollama embedding model,
  searches the store for the best match and asks the Ollama chat model with that context.
- `Store/RagStore.st`: abstract vector store base class.
  `Store/SqliteRagStore.st` and `Store/PostgresRagStore.st` implement it.
  A `STORE_CONFIG` starting with `postgresql:` selects Postgres, otherwise it is an SQLite file path.
- `Test/TestRagApp.st`: indexes the documents, asks a question and checks the answer.
  It is not a subclass of `Test`.
- `types.ts`: imports the ollama and pg npm modules only to inspect their TS types in VSCode;
  not used at runtime.

Library classes go in `../../../Smalltalk/AI/Node/<Provider>/` or `../../../Smalltalk/Node/...`,
their tests in a `Test` subfolder: `Test/Test<Class>.st`.

## Database

- `Database/createSqlite.sql`, `Database/createPostgres.sql`: create the `documents` table with embedding vectors.
- `Database/install.sh` (called by `./install.sh`) creates the SQLite database `Database/vector.db`
  with `createSqliteDatabase.js`. `Database/clean.sh` removes it.
- The Postgres database and pgvector must be set up manually; see doc/Setup.md.
- The embedding vector dimension in the SQL scripts (768, as for `nomic-embed-text`) must match the embedding model.

## Build and run

- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS
  (`../../../Compiler/start.sh -t ../../../Smalltalk/Core ../../../Smalltalk/Node +t ../../../Smalltalk/AI/Shared ../../../Smalltalk/AI/Node src out`;
  `-t` skips `Test` folders of the following input folders, `+t` includes them again),
  then starts an Ollama server (log in `ollama.log`), loads `.env`,
  runs the tests with `node out/main.js -test` and terminates Ollama (port 11434).
  Without `.env` the tests are skipped.
- `./start.sh`: loads `.env` and runs the app in query mode without rebuilding.
  Index mode: `node out/main.js -index` with `.env` loaded,
  or the VSCode launch configurations `Launch Index`, `Launch Query` and `Launch Test`.
- `./startOllama.sh`: starts a local Ollama server.
- `./install.sh`: installs npm dependencies and creates the SQLite database. `./update.sh -y`: updates them.
- `./clean.sh`: removes the generated files, including the SQLite database.
- `.env` (see `.env.example`): `OLLAMA_BASE_URL`, `OLLAMA_MODELS` (chat model),
  `OLLAMA_EMBEDDING_MODELS` and `STORE_CONFIG` (SQLite file path or Postgres connection string).
  The models must be installed in Ollama. A Postgres connection string may contain a password:
  never print, commit or copy `.env`.
- Running the tests re-indexes the documents in the store.

## Generated files

- `./out` contains compiled output (JS and source maps). Do not edit files there; edit ./src or ../../../Smalltalk instead.
- `package.json` has `"type": "module"`: compiled ST classes are ES modules, exported as `st<ClassName>$class`.
- `*.db` files are git-ignored.

## Goal

- Implement and test more RAG features and vector stores, but on specific requests only.
- Follow the structure and testing style of the other examples and of the library's own `Test` folders.
