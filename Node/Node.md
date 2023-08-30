
# SmallJS Node test project

This project tests the Node.js libraries of SmallJS by running its unit test.
Before running the tests, all ST sources are compiled first.

These databases are supported: Postgres, MariaDB and MySQL.
To set them up look here: [../Database/Database.md](../Database/Database.md)

The file `src/App.ts` (compiled to `out/App.js`) does application startup.
It dynamically loads the compiled ST class NodeApp from `out/NodeApp.js` and call its start method.
