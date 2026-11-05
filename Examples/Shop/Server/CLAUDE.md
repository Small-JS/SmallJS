This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folder: ../.. (Examples).
The SmallJS standard library is located in the folder: ../../../Smalltalk.

This is the server part of the Shop example: the skeleton of a web shop with users, products and orders.
It runs on Node.js and uses the SmallJS wrappers for Express and SQL databases
from the folder: ../../../Smalltalk/Node.
Overview of the whole example: ../Shop.md. Server documentation: ./ShopServer.md.

## Related projects

- `../Shared`: ST classes shared by server and clients (`Person`, `Product`, `Order`, `LoginResponse`),
  module `ShopShared`, with their tests in `../Shared/Test`.
- `../Client`: multi-page browser client. `../ClientSpa`: Single Page Application (SPA) client.
  The server serves the static web files of one of them (see `SHOP_CLIENT` below).
- `../../../Database`: database setup scripts. Setup instructions: ../../../Database/Database.md

## Source code

- All source code of this app is in the folder: ./src
- `main.ts`: entry point. With argument `-test` it starts `TestShopServer`, otherwise `ShopServer`.
- `ShopServer.st`: connects to the database, serves the client's static files with Express,
  and provides the JSON web API in route `/api`: `login`, `products` and `orders`.
  `login` is a POST with the credentials in a JSON body (`Person>>toLoginJson`), never in the URL.
  Its failure messages ('User not found: ...', 'Password check failed') are deliberately specific
  to help human testers: this is an example, not a production app. Do not merge them into one message.
  `products` and `orders` require a logged-in session.
- `DbPerson.st`: subclass of the shared `Person` with password salt and SHA256 hashing (server side only).
- `Test/TestShopServer.st`: starts the server, runs the unit tests of the imported Test* classes,
  then tests the web API with `Fetch` requests and stops the server.
  It is not a subclass of `Test`, so it is not run by `Test all` itself.
- `Test/TestDbPerson.st`: unit test of `DbPerson`.

## Build and run

- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS
  (`../../../Compiler/start.sh -t ../../../Smalltalk/Core ../../../Smalltalk/Node +t ../Shared src out`;
  `-t` skips the library's Test folders, `+t` includes those of Shared and src),
  then runs the tests with `node out/main.js -test`.
- `./start.sh`: starts the server without rebuilding or testing (`node out/main.js`).
- `./install.sh`: installs npm dependencies. `./update.sh -y`: updates them.
- `./clean.sh`: removes the generated files.
- `../build.sh`, `../install.sh`, `../update.sh`, `../clean.sh`: do the same for server and both clients.
- `.env` (see `.env.example`) is required to run. It sets:
  - `SHOP_DATABASE`: connection string for SQLite, Postgres, MariaDB or MySQL.
  - `SHOP_CLIENT`: folder with the client's web files (`../Client/web` or `../ClientSpa/web`).
  - `SHOP_PORT`: server port (the API tests assume 3000).
  Without `.env`, `build.sh` skips the tests.

## Generated files

- `./out` contains compiled output (JS and source maps). Do not edit files there;
  edit ./src, ../Shared or ../../../Smalltalk instead.
- `package.json` has `"type": "module"`: compiled ST classes are ES modules, exported as `st<ClassName>$class`.

## Coding style

- Follow the structure and coding style of the existing classes and of the other examples.
- Data classes that map to database tables subclass `SqlObject`, define their `columns`
  on the class side and implement `fromObject:` to reconstruct ST objects from JSON / database rows.
- Classes used by both server and clients belong in ../Shared, server-only classes in ./src.
