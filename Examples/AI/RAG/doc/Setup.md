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

## SQLite with vectors

You can use either SQLite or Postgres to store vectors,\
but SQLite is the easiest to setup.\
The SQLite database is included in Node.js, it does not need to be installed separately.

### sqlite-vec

An SQLite extension to enable vector storage.\
The binary of the actual extension is included in the npm package,\
in the folder `node_modules/sqlite-vec-<platform>`.\
The app loads it automatically.

The `install.sh` script for this app creates the SQLite `vector.db` database automatically.\
So the manual steps below are not necessary to run the app.

### DB Brower for SQLite

'DB Browser for SQLite' is a GUI front-end for SQLite.\
We'll need it to create the vector table conveniently.\
It can be downloaded here:\
[sqlitebrowser.org/dl](https://sqlitebrowser.org/dl)

### Create vector table

Open DB Browser and activate the vector extension through the menu:
`Tools | Load extension | ./node_modules/sqlite-vec-<platform>/vec0*`
Then open the SQL script `Database/createSqlite.sql` .\
Run it to table `documents` also containing embedding vectors.

2026-08-06: MacOS note.\
This step currently fails on MacOS 26.6 on Intel (ARM not tested).\
Use the install script to create the datebase on MacOS.

## Postgres with vectors

An alternative to SQLite, you can use Postgres.
It can be downloaded here:\
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
We'll need it to create the vector table conveniently.\
pgAdmin can be downloaded here:\
[https://www.pgadmin.org/download/](https://www.pgadmin.org/download/)

### Create vector table

Open pgAdmin and open the SQL script `Database/createPostgres.sql` .\
Then run it to activate the vector extension,\
and to create the table `documents` containing embedding vectors.

## Environment

Copy the file `env.example` to `.env` and update that to match your configuration.\
Maybe update the ollama models to which were installed.\
Select the database you want to use by uncommenting its `STORE_CONFIG` variable.

## Next: Running the app

Phew, the tooling setup us done.\
Now we can setup run the app: [Running.md](Running.md) .

