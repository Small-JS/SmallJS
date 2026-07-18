# Setup

This project needs the following setup:

## Ollama

Ollama is a LLM host that can run models locally.\
Ollama can be downloaded here:\
[https://ollama.com/download](https://ollama.com/download)

After Ollama is installed, open a terminal and install 2 models with:\
`ollama run nomic-embed-text`\
`ollama run llama3.2`

You could use other models, but these are tested to work.

## Postgres

Node.js can be downloaded here:\
[https://www.postgresql.org/download](https://www.postgresql.org/download)

### pgvector

pgvector is a vector extension to Postgres, that must be installed.\
pgvector can be downloaded here:\
[https://github.com/pgvector/pgvector](https://github.com/pgvector/pgvector)

Unfortunately, this project requires your to build the extension yourself.\
If you are on Windows, then you can download the pre-built extension here:\
[https://github.com/andreiramani/pgvector_pgsql_windows](https://github.com/andreiramani/pgvector_pgsql_windows)

### pgAdmin

pgAdmin is a GUI front-end to Postgres.\
We'll need it to create the vector table conveniently and check results.\
pgAdmin can be downloaded here:\
[https://www.pgadmin.org/download/](https://www.pgadmin.org/download/)

### Create vector table

Open pgAdmin and open the SQL script `Database/postgresCreate.sql` .\
Then run it to activate the vector extension,\
and to create the table `documents` containing embedding vectors.

## Environment

Copy the file `env.example` to `.env` and update that to match your configuration.\
Maybe update the ollama models to which were installed.\
Update the Postgres connect string with the correct user, password and database.

## Next: Running the app

Phew, the tooling setup us done.\
Now we can setup run the app: [running.md](running.md) .

