// This file imports exports from npm modules that are wrapped in ST elsewhere.
// This is done to facilitate inspecting their TS types in VSCode.
// This file is not used when running this app.

import * as Electron from "electron";

let app: Electron.App;
let baseWindow: Electron.BaseWindow;
let browserWindow: Electron.BrowserWindow;
let ipcMain: Electron.IpcMain;
let rectangle: Electron.Rectangle;
