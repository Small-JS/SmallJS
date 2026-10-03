// This file imports exports from npm modules that are wrapped in ST elsewhere.
// This is done to facilitate inspecting their TS types in VSCode.
// This file is not used when running this app.

import * as Electron from "electron";

// App
let app: Electron.App;
let shell: Electron.Shell;

// Window
let baseWindow: Electron.BaseWindow;
let browserWindow: Electron.BrowserWindow;
let rectangle: Electron.Rectangle;
let webContents: Electron.WebContents;

// IPC
let ipcMain: Electron.IpcMain;
let ipcRenderer: Electron.IpcRenderer;
let contextBridge: Electron.ContextBridge;
