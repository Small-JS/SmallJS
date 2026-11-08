# Smalltalk library folder

The source code of the SmallJS system library.

Subfolders in this folder:
- Core - Common ST classes for browser and Node.js environments.
- Browser - Browser specific classes, mainly the DOM.
- Node - Node.js specific classes for creating server apps.
- AI - Classes for creating AI apps.
- NWjs - Classes for creating NW.js desktop apps.
- Electron - Classes for creating Electron desktop apps.
- NodeGui - Classes for creating NodeGui desktop apps.

Every class is implemented in a separate *.st file.
A file can also extend an existing class with `CLASSEXTENSION`, adding methods to it.
Further subfolders are used to group classes logically,
but their location does not affect their use because all classes are global variables.

Classes are grouped in modules, that are implemented using JS (ECMAScript) modules.
The module of a class is set by the keyword `MODULE` in its class header, not by its folder.
A folder can contain several modules, e.g. Core contains the modules Core and Crypto.
Modules limit the number of JS files that are generated with compilation.
They also allow for circular class references between classes in the same module.

Unit tests are in `Test` subfolders, in separate modules named `Test<module>`, e.g. TestCore.
The compiler option `-t` skips compiling the `Test` subfolders of the folders that follow it,
and `+t` includes them again.
