# Compiler project

## General

The SmallJS compiler compiles (transpiles) from ST to JS, running in Node.js.
It is called from other projects, like ../Node and ../Browser to compile ST base sources from the ../Smalltalk folder and any ST sources your custom project adds.

The compiler itself is written in TypeScript, so is independent from ST. This way all ST can be modified without bootstrapping issues. The compiler is implemented 'by hand' without using parser or generator libraries, to keep it compact, quick and stable.
To test itself after changes, the compiler starts the ../Node project and runs its unit tests.

## Usage

	node ./out/App.js [-s] <ST source folder>... <JS output folder>
		-s: Don't generate source map files and remove existing ones.

The -s option is convienient if you want to debug purely in JS, not a mix of ST and JS.

Example for Node projects:

	node ./out/App.js ../Smalltalk/Core ../Smalltalk/Node", "src", "out"

Example for browser projects:

	node ./out/App.js -s ../Smalltalk/Core ../Smalltalk/Browser", "src", "web"

Note that for Node and browser projects, different parts of the ST image should compiled, otherwise runtime errors will occur in the compiled code.

The easiest way to start a new project is to make a copy of the ../Node or ../Browser folders and rename it to your app name. The configuration will then be set up properly through VSCode launch and task configurations.

## Deployment

Just copy the generated JS module files (".js") to the deployment location,
including the Runtime.js that contains some low level support classes written in JS.
Exclude files named Test*.js files to skip unit tests.
Also copy the source map files (*.map) files if you want to allow debugging.
