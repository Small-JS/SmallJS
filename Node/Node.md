
# SmallJS Node test project

This project tests the Node.js libraries of SmallJS by running its unit tests.
Before running the tests, all ST sources are compiled first.

## Getting started

First install npm dependencies by running `./install.sh` (or `npm install`) in a terminal.
Then run `./build.sh` to compile the project and see that the unit tests are performed successfully.
To run the tests again without recompiling, use `./start.sh`.

The file `src/main.ts` (compiled to `out/main.js`) does application startup.
It dynamically loads the compiled ST class NodeApp from `out/NodeApp.js` and calls its start method.

## Node support

Node support classes are in the folder: '/Smalltalk/Node'.

### Base support

Basic classes like Buffer are in the subfolder: 'Base'.

### Event support

Event classes like EventEmitter are in the subfolder: 'Event'.

### File support

Filesystem support classes are in the subfolder: 'File'.

### OS support

OS specific support classes are in the subfolder: 'Os'.

### Process support

Process support classes are in the subfolder: 'Process'.

### Server support

Web server support classes (Express) are in the subfolder: 'Server'.

### Worker support

Worker thread support classes are in the subfolder: 'Workers'.

### Database support

Database support classes are in the subfolder: 'Database'.

These databases are supported: SQLite, Postgres, MariaDB and MySQL.
To set them up look here: [../Database/Database.md](../Database/Database.md)

Database support is disabled by default.
To enable it, copy the file `.env.example` to `.env`
and uncomment the connection string(s) to the database(s) you want
and enter the login credentials for your database server(s).

Now the unit tests of the selected databases will run automatically.

## AI support

AI support classes are in the folder: '/Smalltalk/AI'.
They are not tested in this project, but in the AI example: [../Examples/AI/AI.md](../Examples/AI/AI.md)
