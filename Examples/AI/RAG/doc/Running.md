# Running

The app is first run in document indexing mode, then in query mode.

## Index mode

First make sure that Ollama and Postgres are running.\
Ollama can also be started with the script: `startOllama.sh` .

Open the workspace `RagApp.code-workspace` in VSCode.\
TypeScript source files will automatically be compiled to JavaScript.\
Click the `Debug and Run` triangle-with-bug on the left of the screen.\
Now check the selected configuration on top is: `Launch Index (RagApp)`.\
Now click the green triangle to 'Start Debugging`.

If all went well the debug console should show the message: `Documents indexed` .\
The documents (lines) from the file `documents.json` \
are now put into the `documents` table in Postgres \
each with a embedding (similarity) vector field describing the document.

## Query mode

In the open the workspace `RagApp.code-workspace` in VSCode,\
again on click the `Debug and Run` triangle-with-bug on the left of the screen.\
On top, now select configuration on top is: `Launch Query (RagApp)`.\
Now click the green triangle to 'Start Debugging`.

If all went well the debug console should show the messages:.\
`Question: What is RAG?`\
`Answer: <a verbose explanation of RAG based on the 3rd embedded document:`\
`   "RAG combines retrieval with language generation.">`

## Next step

Now that everything is working, let's check out the [code.md](code.md)
