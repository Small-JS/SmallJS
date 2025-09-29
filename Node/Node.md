
# SmallJS Node test project

This project tests the Node.js libraries of SmallJS by running its unit tests.
Before running the tests, all ST sources are compiled first.

## Getting started

First install npm dependencies by running `npm install` in a terminal.
Now start the project run the project and see that unit tests are performed successfully.

The file `src/App.ts` (compiled to `out/App.js`) does application startup.
It dynamically loads the compiled ST class NodeApp from `out/NodeApp.js` and call its start method.

## Node support

Node support classes are in the folder: '/Smalltalk/Node'.

### File support

Filesystem support classes are in the subfolder: 'File'.

### OS support

OS specific support classes are in the subfolder: 'OS'.

### Process support

Process support classes are in the subfolder: 'Process'.

### Database support

Process support classes are in the subfolder: 'Database'.

These databases are supported: Postgres, MariaDB and MySQL.
To set them up look here: [../Database/Database.md](../Database/Database.md)

Database support is disabled by default.
To enable it, copy the file `.env.example` to `.env`
and uncomment the connection string(s) to the database(s) you want
and enter the login credentials for your database server(s).

Now the unit tests of the selected databases will run automatically.

## AI support

These AI providers are currently supported: OpenAI, DeepSeek.

To enable AI, copy the file `.env.example` to `.env`
and uncomment the *_API_KEY variables for the AIs you want to use.
Of course you will first have to get your own API keys from the providers.
It's not expensive to get a usable token credit.

Now the unit tests of the selected AIs will run automatically.<br>
For a simple AI usage example, see the file: [../Smalltalk/Node/Ai/Test/TestAi.st](../Smalltalk/Node/Ai/Test/TestAi.st)

