This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folders : ../../Examples, ../../Browser, ../../Node.
The SmallJS standard library is located in the folder: ../../Smalltalk.

This is an NW.js app testing the NW.js API wrappers in the SmallJS library,
located in the folder ../../Smalltalk/NWjs, with their unit tests in ../../Smalltalk/NWjs/Test.
The app also uses the Browser (DOM) and Node wrappers in ../../Smalltalk/Browser and ../../Smalltalk/Node.

The NW.js JS API documentation is here:
https://nwjs.readthedocs.io/en/latest/

## Source code

- All source code is in the folder: ./src
- `main.ts`: app entry point. Starts `MyNwApp`, or `TestMyNwApp` if the app is started with the argument `-test`.
- `MyNwApp.st`: the main app (binds the HTML elements, sets the menu bar and context menu).
- `Lpad.st`: wraps the npm package `lpad`, to show how to use an external npm package in NW.js.
- `types.ts`: imports npm modules (`nw.gui`) only to inspect their TS types in VSCode; not used at runtime.
- `Test/TestMyNwApp.st`, `Test/TestMyNwMenu.st`, `Test/TestMyNwWindow.st`: tests for this app.
  `TestMyNwApp` first runs the library tests (`TestNwApp all`), then the app tests.

## NW.js specifics

- NW.js modules are loaded with `require()` in INLINE code, e.g. `require( "nw.gui" )`.
  ESM `import` of npm packages does not work; use `require()` with a relative path to the package's main file
  (see `Lpad.st`).
- The app is started with the flags `--enable-features=NWESM,NWChainImportNode`.
- The NW.js manifest is `./web/package.json`.

## Build and run

- `./install.sh`: installs the npm packages, including `nw`.
- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS (`../../Compiler/start.sh`),
  then runs the app in test mode with the npm version of NW.js.
  The window closes automatically after the tests (`TestMyNwWindow` closes it as the last test).
- `./start.sh`: runs the app normally with the NW.js SDK installed manually in `./bin` (see `NWjs.md`).
- `./clean.sh`: removes the generated files.

## Generated files

- `./web/Script` contains compiled output (JS and source maps). Do not edit files there; edit ./src instead.
- The other files in `./web` are hand-written: `index.html`, `default.css`, `package.json`, `poem.txt`, images.

## Goal

- Expand the SmallJS library coverage of the NW.js API, but on specific requests only.
- Create unit tests (in ../../Smalltalk/NWjs/Test) and GUI tests (in ./src/Test) for the added functionality.
- Follow the structure and testing style of the other examples and of the library's own `Test` folders.

## Coding style

- Do not end cascades with `yourself` when it is not necessary.
  In SmallJS a method without an explicit `^` return returns `self`,
  so a cascade ending with such a method (e.g. a setter) already returns the receiver.
  Only use `yourself` when the last message of the cascade returns another object.

## Testing

- Unit tests must not rely on user interaction, like clicking menus, file dialogs or permission prompts.
  Test such APIs with a mock JS object instead, or by invoking the handlers directly.
- Tests must leave the app in a state where the test window can still close itself after the tests.
