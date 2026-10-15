This project is mainly written in the programming language SmallJS, a Smalltalk dialect.
SmallJS source files have the extension: .st
Examples of SmallJS apps are in the folders : ../../Examples, ../../Browser, ../../Node.
The SmallJS standard library is located in the folder: ../../Smalltalk.

This is an Electron app testing the Electron API wrappers in the SmallJS library,
located in the folder ../../Smalltalk/Electron, with their unit tests in the `Test` subfolders,
e.g. ../../Smalltalk/Electron/Node/App/Test.
The app also uses the Browser (DOM) and Node wrappers in ../../Smalltalk/Browser and ../../Smalltalk/Node.

The Electron JS API documentation is here:
https://www.electronjs.org/docs/latest/api/app

## Electron processes

An Electron app has 3 parts, each compiled to its own JS module (see `Electron.md`):

- Main (Node.js): `src/Node/MyElectronApp.st` > module `MyElectronMain`.
  Base class `ElectronApp` in ../../Smalltalk/Electron/Node/App.
- Preload (API, IPC bridge): `src/Node/MyElectronApi.st` > module `MyElectronPreload`.
  Base class `ElectronApi` in ../../Smalltalk/Electron/Node/Api.
- Renderer (Browser): `src/Browser/MyElectronView.st` > module `MyElectronRenderer`.
  Base class `ElectronView` in ../../Smalltalk/Electron/Browser.

The renderer has no direct access to Node.js or Electron.
It calls the API that the preload script exposes with `contextBridge.exposeInMainWorld`,
which forwards calls to the main process with IPC (`ipcRenderer.send` / `invoke`, `ipcMain.on` / `handle`).
Only raw JS values can be passed through the contextBridge.

## Library wrappers

Electron wrappers in ../../Smalltalk/Electron/Node, per folder:
`App` (app), `Window` (BaseWindow, BrowserWindow, WebContents, options), `Menu` (Menu, MenuItem),
`Dialog` (dialog, options and results), `Shell` (shell), `Api` (contextBridge, ipcRenderer).
Electron modules are imported in INLINE code with `INLINE 'import * as electron$ from "electron";'`.

## Source code

- All source code is in the folder: ./src
- `main.ts`: main process entry point. Starts `MyElectronApp`, or `TestMyElectronApp` if started with the argument `-test`.
- `preload.ts`: preload script entry point. Exposes `MyElectronApi` as `window.myApi`.
- `renderer.ts`: renderer entry point. Starts `MyElectronView`, or `TestMyElectronView` if the page URL has `?test`.
- `types.ts`: imports the `electron` module only to inspect its TS types in VSCode; not used at runtime.
- `Node/MyElectronApp.st`: the main app (IPC handlers, menu bar, windows, dialogs, context menu).
- `Node/MyElectronWindowState.st`: saves and restores the main window bounds.
- `Browser/MyElectronView.st`: the view (binds the HTML elements, calls the API).
- `Node/Test/TestMyElectronApp.st`: tests for the main process.
  It first runs the library tests (`Test all`), then the live app tests.
- `Browser/Test/TestMyElectronView.st`: GUI tests for the view. Quits the app as the last step.

## Build and run

- `./install.sh`: installs the npm packages, including `electron`.
- `./build.sh`: compiles TypeScript (`tsc`) and SmallJS (`../../Compiler/start.sh`),
  then runs the app in test mode.
  The Node and Browser parts are compiled separately, to prevent class name clashes.
  The app quits automatically after the tests (`TestMyElectronView` sends `quit` as the last step).
- `./preLaunch.sh`: copies `./web` to `./out` and `preload.js` to `preload.mjs`. Called by `build.sh`.
- `./start.sh`: runs the app normally.
- `./clean.sh`: removes the generated files.
- `./update.sh -y`: updates the npm packages.
- On Ubuntu, Electron may need: `sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0`.

## Generated files

- `./out` contains compiled output (JS and source maps) and copies of `./web`.
  Do not edit files there; edit ./src or ./web instead.
- The files in `./web` are hand-written: `index.html`, `about.html`, `default.css`, images.

## Goal

- Expand the SmallJS library coverage of the Electron API, but on specific requests only.
- Create unit tests (in the `Test` subfolders of ../../Smalltalk/Electron)
  and app tests (in ./src/Node/Test and ./src/Browser/Test) for the added functionality.
- Follow the structure and testing style of the other examples and of the library's own `Test` folders.

## Coding style

- Do not end cascades with `yourself` when it is not necessary.
  In SmallJS a method without an explicit `^` return returns `self`,
  so a cascade ending with such a method (e.g. a setter) already returns the receiver.
  Only use `yourself` when the last message of the cascade returns another object.

## Testing

- Unit tests must not rely on user interaction, like clicking menus, file dialogs or permission prompts.
  Test such APIs with a mock JS object instead, by invoking the handlers directly,
  or by emitting the events directly (e.g. `window.js.emit( "event" )`).
- Use hidden windows (`show: false`) for window tests where possible, and destroy them afterwards.
- Methods that quit or relaunch the app must not be called in tests.
- Tests must leave the app in a state where it can still quit itself after the tests.
