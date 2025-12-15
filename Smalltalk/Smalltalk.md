# ./Smalltalk library (image) folder

The main Smalltalk source code of the system, for both the Node.js and browser environments and classes shared by both.

Subfolders in this folder:
- Core - Common ST classes for browser and Node environments
- Browser - Browser specific classes, mainly the DOM.
- Node - Node.js specific classes for, creating server apps.
- AI - Classes for creating AI apps.
- NWjs - Classes for creating NW.js desktop apps. (recommended)
- Electron - Classes for creating Electron desktop apps.
- NodeGui - Classes for creating NodeGui desktop apps.

Every class is implemented in a separate *.st file.
Further subfolders are used to group classes logically,
but their location does not affect their use because all classes are global variables.

Classes are grouped in modules, that are implemented using JS (ECMAScript) modules.
This limits the number of JS files that are generated with compilation and allows for circular class references between classes in the same modules.

