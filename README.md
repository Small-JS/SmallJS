# SmallJS README

# What is SmallJS?

SmallJS is a compiler (transpiler) from the Smalltalk (ST) language to JavaScript (JS).
The generated JS code runs in all modern browsers or in Node.js.
SmallJS has full syntax support for the simple and elegant Smalltalk-80 language.

SmallJS is file based, not image based, so you can develop in your favorite IDE
The default setup is for Visual Studio Code, with ST syntax coloring and step debugging!

SmallJS is *fully* object oriented, so customizable on every level.
For usability, ST class and method names are kept mostly equal to their familiar JS counterparts.
JS libraries already encapsulated in ST are:
- Browser: Document, Window, HTML elements, events, CSS, streams.
- Node.js: HTTP server, Express, 3 databases.
- And an Example webshop client + server app template.

# Getting started

SmallJS is currently set-up for use with Visual Studio Code, but other IDEs could be added.
For the back-end, Node.js is the framework of choice, also using Express.
Databases Postgres, MariaDB and MySQL are supported out of the box.

To install all the prerequisites, look at:
>[./Documentation/Installing.md](./Documentation/Installing.md)

For a first impression of SmallJS, you can start the Browser test project, see:
>[./Browser/README.md](./Browser/Browser.md)

The complete documentation is indexed here:
>[./Documentation/README.md](./Documentation/Documentation.md)
