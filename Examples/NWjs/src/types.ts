// This file imports exports from npm modules that are wrapped in ST elsewhere.
// This is done to facilitate inspecting their TS types in VSCode.
// This file is not used when running this app,
// and it would in fact fail, because NW.js does not support ESM imports yet (2025-8-3).

// NW.js wiki
// https://github.com/nwjs/nw.js/wiki

// ESM support flag:
// https://groups.google.com/g/nwjs-general/c/KSUVExtmUU4/m/SoZhSx7uCQAJ

// ESM example:
// https://github.com/fprijate/nwjs-esm/tree/master/src

// This works for coding with types, but does not run:
import gui = require( "nw.gui" );

// This works for running:
// let gui = require( "nw.gui" );

let eventEmitter = new gui.EventEmitter();
let app = gui.App;
let window = gui.Window.get();
let menu = new gui.Menu();
let menuItemConfig: gui.MenuItemConfig = {};
let menuItem = new gui.MenuItem( menuItemConfig );
let shortcutOption: gui.ShortcutOption = { key: '', active: function active() {} , failed: function failed( message: string ) {} };
let shortcut = new gui.Shortcut( shortcutOption );
