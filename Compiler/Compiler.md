# Compiler project

## General

The SmallJS compiler compiles (transpiles) from ST to JS, running in Node.js.
It is called from other projects, like ../Node and ../Browser to compile ST base sources from the ../Smalltalk folder and any ST sources your custom project adds.

The compiler itself is written in TypeScript, so is independent from ST. This way all ST can be modified without bootstrapping issues. The compiler is implemented 'by hand' without using parser or generator libraries, to keep it compact, quick and stable.
To test itself after changes, the compiler starts the ../Node project and runs its unit tests.

## Usage

	node ./out/App.js [-s] [-m <start class>] [-t] <ST source folders> [+t <ST source folders>] <JS output folder>
		-s : Don't generate source map files and remove existing ones.
		-m : Minimize generated classes from specified starting class.
		-t : Don't compile ./Test subfolders in following folders.
		+t : Resume compiling ./Test subfolders in following folders.
		-d : Only generate class documentation: DocumentedClasses.json.
		-v : Show SmallJS version number and exit.

- Option '-s' is convenient if you want to debug purely in JS, and not a mix of ST and JS.\
- Options '-t' and '+t' can be used to skip compiling units tests for ST base libraries and for production deployment of your app.\
- Option '-m' with also strip any test classes that are one explicitly referenced.\
For multi-page web applications you need to excplicitly reference the startup classes and methods for the startup classes of other web pages, or they will be minimized away. \
See `Examples/Shop/Client/LoginApp.st` for an example.
- Option '-d' does not generate JS code.

Example for Node projects:

	node ./out/App.js -t ../Smalltalk/Core ../Smalltalk/Node +t src out

Example for browser projects:

	node ./out/App.js -s -t ../Smalltalk/Core ../Smalltalk/Browser +t src web

Note that for Node and browser projects, different parts of the ST image should compiled, otherwise runtime errors will occur in the compiled code.

The easiest way to start a new project is to make a copy of the ../Node or ../Browser folders and rename it to your app name. The configuration will then be set up properly through VSCode launch and task configurations.

## Deployment

Just copy the generated JS module files (\*.js) to the deployment location,
including the Runtime.js that contains some low level support classes.
Exclude files named Test\*.js files to skip unit tests or use the -t option to prevent their compilation.
Also copy the generated source map files (\*.map) files and ST source files (\*.st)  if you want to allow ST level debugging.
