# SmallJS documentation

Click on the headings to open further documentation.

## [The Smalltalk language & SmallJS design](Language.md)

A quick introduction to the Smalltalk language.

## [SmallJS design](Design.md)

Design choices for the SmallJS implementation.

## Folders in this repo

The SmallJS repo has the following subfolders:

### [./Smalltalk](../Smalltalk/Smalltalk.md)

The main Smalltalk source code of the system, for browser and Node.js environments and classes shared by both.

### [./Compiler](../Compiler/Compiler.md)

The compiler (transpiler) compiles from ST to JS, running in Node.js.
It is called from other projects, like ./Node and ./Browser.

### [./Node](../Node/Node.md)

Test application for running SmallJS code in Node.js.

### [./Browser](../Browser/Browser.md)

Test testing application for running SmallJS code in a web browser.

### [./Database](../Browser/README.md)

A guide to installing and using supported databases with SmallJS.

### ./Shop

This is a small but complete example web application.\
It contains a Node.js based, database enabled [Shop Server](../Shop/Server/ShopServer.md).\
And a browser based  [Shop Client](../Shop/Client/ShopClient.md).
