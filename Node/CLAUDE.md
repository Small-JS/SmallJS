This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folders: ../Examples, ../Browser.
The SmallJS standard library is located in the folder: ../Smalltalk.

This is an app testing the Node.js API wrappers in the SmallJS library,
located in the folder: ../Smalltalk/Node
(subfolders: Base, Database, Event, File, Os, Process, Server, Workers).

The Node.js API documentation is here:
https://nodejs.org/docs/latest/api

## Source code

- All source code of this app is in the folder: ./src
- `main.ts`: entry point. Imports `NodeApp.js` and calls `start`. This project is always in test mode.
- `NodeApp.st`: references each Test* class to force importing its module, then runs `Test all`.
  New test classes must be referenced there, or they will not run.
- `worker.ts`: worker script used by the NodeWorker tests (starts `MyNodeWorker` from module `TestNode`).
- `types.ts`: imports npm modules only to inspect their TS types in VSCode; not used at runtime.

Library classes go in `../Smalltalk/Node/<Area>/`,
their tests in `../Smalltalk/Node/<Area>/Test/Test<Class>.st`.

## Build and run

- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS
  (`../Compiler/start.sh ../Smalltalk/Core ../Smalltalk/Node src out`),
  then runs the tests with `node out/main.js`.
- `./start.sh`: runs the tests without rebuilding. `./startWait.sh` does the same, but waits before closing.
- `./install.sh`: installs npm dependencies. `./update.sh -y`: updates them.
- `./clean.sh`: removes the generated files.
- `.env` (see `.env.example`): optional database connection strings (SQLite, Postgres, MariaDB, MySQL).
  Without it, database tests are skipped. Database setup: ../Database/Database.md

## Generated files

- `./out` contains compiled output (JS and source maps). Do not edit files there; edit ./src or ../Smalltalk instead.
- `package.json` has `"type": "module"`: compiled ST classes are ES modules, exported as `st<ClassName>$class`.

## Goal

- Implement and test more libraries, but on specific requests only.
- Follow the structure and testing style of the other examples and of the library's own `Test` folders.
