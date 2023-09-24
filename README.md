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

# Example

![./Documentation/Example.png](./Documentation/Example.png)

# Getting started

SmallJS is currently set-up for use with Visual Studio Code, but other IDEs could be added.
For the back-end, Node.js is the framework of choice, also using Express.
Databases Postgres, MariaDB and MySQL are supported out of the box.

## Install prerequisites

To install all the prerequisites, look at:
>[./Documentation/Installing.md](./Documentation/Installing.md)

Now run the bash script `./install.sh`.
On Windows, the `.sh` extension can be associated with Git Bash.

This script:
- Checks if manually installed prerequisites are present.
- Installs the SmallJS language extension in VSCode.
- Installs npm dependencies for all projects.

## Build SmallJS projects

Run the bash script: `./build.sh`.\

This script:
- First builds the Smalltalk `./Compiler`, TS to JS.
- Builds all other ST projects after installing any NPM packages needed\
  and runs their unit tests if present.

Note that browser type ST projects are only compiled, not run or tested.\
Check if everything builds successfully before going to the next step.

## Browser project

For a first impression of running SmallJS code in a browser, you can start the Browser test project, see:
>[./Browser/Browser.md](./Browser/Browser.md)

# Documentation

The complete documentation is located here:
>[./Documentation/Documentation.md](./Documentation/Documentation.md)
