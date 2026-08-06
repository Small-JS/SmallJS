# SmallJS README

<p align="center" width="100%" style="font-size: large; font-weight: bold;">
	<img src="Documentation/SmallJS.png" alt="SmallJS logo" width="300" height="300"/>
	<br>
	<label>Official website: </label>
	<a href="https://small-js.org" style="font-weight: bold;">small-js.org</a>
</p>

## News - SmallJS 2.2 released ! - 6-AUG-2026


### AI assistant

- Now you can use an **AI assistant** to code in SmallJS!\
  See the [Tutorial](https://small-js.org/Tutorial) home page for setting it up.

### Examples

- Added example app **RAG** showing AI use with **Research Augmented Generation**.\
  Everyting runs locally with models in Ollama, using SQLite or Postgres as vector stores.

### Contributions

- Added app **React Counter** to contributions, to show to use SmallJS in **React** projects.

### Smalltalk library

- Added embedding functionality to AI class Ollama.
- Added `doAwait:` method to class `Array` to await iterating over an async block.
- Made subsystems `Database` and `AI` more modular,
  allowing projects to just install npm packages of implementations they use.

### Build

- All projects now support **TypeScript 7** builds.
- Made build scripts more modular for example projects.
  Every project now has their own scripts for: install, build, update and clean.
- Installed package updates must be at least 7 days old, for security.


## Introducing SmallJS

SmallJS is a free and open source implementation of the elegant and powerful Smalltalk-80 (ST) language.\
It compiles to JavaScript (JS) that runs in modern browsers or in recent Node.js.\

SmallJS is file based, not image based, so you can develop in your favorite IDE.\
The default setup is for Visual Studio Code, with ST syntax coloring and step-debugging!\
You code separately from the SmallJS base libraries (image).\
Only the parts you use are imported automatically when running your app.

SmallJS is _fully_ object oriented, so customizable on every level.\
For usability, ST class and method names are kept mostly equal to their familiar JS counterparts.

JS libraries already encapsulated in ST are:

- Browsers: Document, Window, HTML elements, events, CSS, streams.
- Node.js: HTTP server, Express, file mgmt, 5 databases, 5 AI providers.
- Desktop apps: NWjs, Electron, NodeGui.

To get you started quickly, there are several example projects using the above.

## Code example

![Example.png](Example.png)

## Installing

To install SmallJS check out:
[Installing.md](Documentation/Installing/Installing.md)

## Examples

For a first impression of running SmallJS code, see the example projects:
[Examples.md](Examples/Examples.md)

## Playground

To get a feel for Smalltalk and to quickly test out ST expressions,
a playground is accessible though the offical website:
[small-js.org/Playground](https://small-js.org/Playground)

## Documentation

The complete SmallJS documentation, including a tutorial, is located here:
[Documentation.md](Documentation/Documentation.md)

## Contributions

Contributions to SmallJS that are not part of the main system,
but show interesting applications:
[Contributions.md](Contributions/Contributions.md)

