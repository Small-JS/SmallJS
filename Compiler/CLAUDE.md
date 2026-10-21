This is the SmallJS compiler. It compiles (transpiles) SmallJS source code to JavaScript.
SmallJS is a Smalltalk dialect. Its source files have the extension: .st
The compiler is written in TypeScript and runs in Node.js.
It is hand-written, without parser or generator libraries. The only npm dependency is `source-map`.
Because it is not written in ST, all ST code can change without bootstrapping problems.

Other projects call it to compile their ST code, e.g. ../Node, ../Browser and ../Examples.
The SmallJS standard library it usually compiles is in the folder: ../Smalltalk
(Core, Node, Browser, Electron, NWjs, NodeGui, AI).
User documentation: ./Compiler.md and ../Documentation.

## Source code

All source code is in the folder: ./src
- `main.ts`: entry point. Creates a `Compiler` and calls `start`.
- `Compiler.ts`: parses the command line, loads `.st` files from the input folders,
  orders classes by inheritance (starting at `Object`), minimizes them (`-m`),
  and generates the modules, `CompiledClassesJson.js` and `Runtime.js`.
  It also contains the version number (`Compiler.version`).
- `Parser.ts`: hand-written tokenizer / parser over the ST source text. `Position.ts`: line / column position.
- `ClassCompiler.ts`: compiles one class: header (`CLASS`, `EXTENDS`, `MODULE`, `CLASSVARS`, `VARS`),
  then `METHODS` / `CLASSMETHODS`, methods, statements, expressions, blocks, literals and messages
  into `SourceNode` trees from `source-map`. It also handles `CLASSEXTENSION`, `INLINE` JS and `async` / `await`.
- `CompiledClass.ts`, `CompiledMethod.ts`, `CompiledVariable.ts`: the compiled model and JS generation for classes, metaclasses and methods.
- `CompiledModule.ts`: writes one `<Module>.js` file (plus `.js.map`) per `MODULE` name,
  with imports of the other modules, the classes, the class singletons and the inheritance setup.
- `CompiledClassJson.ts`: class metadata written to `CompiledClassesJson.js` (also used by ../Playground).
- `DocumentedClassJson.ts`, `DocumentedMethodJson.ts`: class documentation for `-d` mode (`DocumentedClasses.json`).
- `Runtime.ts`: support code used by both the compiler and compiled apps: `BlockReturn`,
  `Naming` (ST to JS name mapping), `CharUtil` and `NumUtil`.
  It is compiled to `out/Runtime.js` and copied into every output folder, without its source map.

## ST to JS naming

Defined in `Naming` in `Runtime.ts`:
- Class `Foo` becomes JS class `StFoo`, its metaclass `StFoo$class` and the metaclass singleton `stFoo$class`.
- Unary method `foo` becomes `$foo`. Keyword method `at:put:` becomes `$at$put$`. Binary operators are mapped by `operatorMap`.
- A variable named like a JS reserved word gets a `$` appended.
- The singletons `stNil$`, `stTrue$` and `stFalse$` are exported from module `Core`.

## Usage

	./start.sh [-s] [-d] [-m <start class>] [-v] [-t] <ST source folders> [+t <ST source folders>] <JS output folder>

- `-s`: don't generate source maps and remove existing ones.
- `-m <class>`: minimize: remove classes and methods not reachable from the start class
  (plus some classes the compiler always needs, listed in `minimizeClasses`).
- `-t` / `+t`: skip / resume compiling `Test` subfolders. These are placed between the folders, not before them.
- `-d`: only generate `DocumentedClasses.json`, no JS. `-v`: show the version.
- The last argument is the output folder.

Example, as used by ../Node: `../Compiler/start.sh ../Smalltalk/Core ../Smalltalk/Node src out`

## Build and test

- `./build.sh`: compiles TypeScript (`tsc`) from ./src to ./out.
  In VSCode the default build task runs `tsc --watch` on folder open.
- `./install.sh`: installs npm dependencies. `./update.sh -y`: updates them. `./clean.sh`: removes ./out.
- There are no unit tests in this project. To test a compiler change, build it,
  then compile and run the ../Node tests: `../Node/build.sh`.
  For browser related changes, also build and test ../Browser.
- VSCode launch configurations (`.vscode/launch.json`) run the compiler on ../Node, with or without minimize,
  and in documentation mode. They then run the Node tests.
- If you change the generated code, check the output of a small class in `../Node/out/<Module>.js`.

## Source maps and debugging

The source maps let the VS Code debugger set breakpoints and step through the .st source.
They are tuned for the V8 engine and break easily. When changing code generation in `ClassCompiler.ts`:
- Never concatenate a `SourceNode` into a string (`"..." + node`), because this loses its mappings.
  Add child nodes instead.
- `mapFirstLine` maps the unmapped JS on the first line of a statement to the statement start,
  because V8 only stops at "breakable" locations. Keep it working for assignments, single expressions and blocks.
- `sourceNode` creates unmapped nodes, `positionedSourceNode(At)` mapped ones.
- `disableBreakpoints` leaves common methods and classes unmapped, so the debugger steps over them.
- `relativeFilename` uses the parser's file name, so class extension methods map to their own .st file.
- Projects skip `**/Runtime.js` in the `skipFiles` of their launch.json.

## Playground

../Playground contains a modified copy of these sources that compiles to memory in the browser.
Code that differs there is marked with comments containing "Playground". Keep these comments
when editing, so the changes can be ported. See ../Playground/Playground.md.

## Code style

- Follow the style of the existing code: tabs, spaces inside parentheses (`foo( a, b )`),
  braces on their own line for classes and methods, and `_class` as a variable name for classes.
- Compile errors are reported with `error(...)`, which prints the message and file and exits the process.
- Do not edit the files in ./out; they are generated.
