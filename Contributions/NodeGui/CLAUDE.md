This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folders : ../../Examples, ../../Browser, ../../Node.
The SmallJS standard library is located in the folder: ../../Smalltalk.

This is a NodeGui app testing the NodeGui API wrappers in the SmallJS library,
located in the folder ../../Smalltalk/NodeGui, with their unit tests in the `Test` subfolder
of each category folder (`Base`, `Button`, `Component`, `Layout`, `Menu`, `Widget`).
NodeGui is a Node.js library wrapping the Qt GUI library; widgets are Qt widgets, not HTML elements.
The app also uses the Node wrappers in ../../Smalltalk/Node (e.g. `Fs`, `Process`, `Timer`).

The NodeGui JS API documentation is here:
https://docs.nodegui.org/

## Source code

- All source code is in the folder: ./src
- `main.ts`: app entry point. Starts `MyNodeGuiApp`, or `TestMyNodeGuiApp` if the app is started with the argument `-test`.
- `MyNodeGuiApp.st`: the main app, a subclass of `QApplication`
  (creates the main window, menu bar, style sheet and the central widget with its layout).
- `types.ts`: imports the NodeGui classes and enums wrapped in ../../Smalltalk/NodeGui,
  only to inspect their TS types in VSCode; not used at runtime.
- `Test/TestMyNodeGuiApp.st`: tests for this app.
  `TestMyNodeGuiApp` first runs the library tests (`TestQApplication all`), then the app GUI tests.

## NodeGui specifics

- All NodeGui library classes compile into a single JS module (`out/NodeGui.js`).
  `QApplication.st` imports all NodeGui JS classes once for that module:
  `INLINE 'import * as nodegui$ from "@nodegui/nodegui";'`.
  Other library classes do not import NodeGui themselves; they use the prefix `nodegui$.`
  in INLINE code, e.g. `INLINE 'new nodegui$.QLabel()'`. The `$` prevents name clashes with ST variables.
- The app runs with `qode` (Node.js with the Qt event loop), in `./node_modules/.bin/qode`, not with plain `node`.
- `QApplication instance` always refers to the JS singleton `QApplication`.
- Styling is done with Qt style sheets (CSS-like) in `./assets/default.css`, or inline with `setInlineStyle:`.
  Widget styles cannot be read back, so tests check app state instead.
- Paths of assets (`assets/...`) are relative to the project folder, the working directory when running.

## Build and run

- `./install.sh`: installs the npm packages, including `@nodegui/nodegui` and `@nodegui/qode`.
- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS (`../../Compiler/start.sh`),
  then runs the app in test mode with `qode out/main.js -test`.
  The app quits automatically after the tests (`TestMyNodeGuiApp` calls `quit` as the last step).
- `./start.sh`: runs the app normally.
- `./clean.sh`: removes the generated files.
- `./update.sh -y`: updates the npm packages.
- On Ubuntu, Qt may need: `sudo apt-get install libxcb-cursor0` (see `NodeGui.md`).

## Generated files

- `./out` contains compiled output (JS and source maps). Do not edit files there; edit ./src instead.
- `./assets` contains hand-written files: `default.css`, `logo.ico`, `logo.png`.

## Goal

- Expand the SmallJS library coverage of the NodeGui API, but on specific requests only.
- Create unit tests (in the `Test` subfolders of ../../Smalltalk/NodeGui) and GUI tests (in ./src/Test)
  for the added functionality.
- Follow the structure and testing style of the other examples and of the library's own `Test` folders.

## Coding style

- Do not end cascades with `yourself` when it is not necessary.
  In SmallJS a method without an explicit `^` return returns `self`,
  so a cascade ending with such a method (e.g. a setter) already returns the receiver.
  Only use `yourself` when the last message of the cascade returns another object.

## Testing

- Unit tests must not rely on user interaction, like clicking menus or file dialogs.
  Test such APIs with a mock JS object instead, or by invoking the handlers directly (e.g. `click`).
- Tests must leave the app in a state where it can still quit itself after the tests.
- A failing test makes `qode` exit with code 1, which makes `build.sh` fail.
