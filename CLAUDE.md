This is the root folder of SmallJS, a Smalltalk-80 dialect that compiles to JavaScript.
SmallJS source files have the extension: .st
This folder is not a project itself: it contains no source code to build or run.
It holds the subprojects, plus bash scripts that call the scripts of the same name in the subprojects.
User documentation: ./README.md and ./Documentation/Documentation.md.

## Subprojects

Most subprojects have their own CLAUDE.md. Read it before working in that folder.
- `Compiler/`: the SmallJS compiler, written in TypeScript. Compiles .st to JS. Used by all other projects.
- `Smalltalk/`: the SmallJS standard library (.st), in the folders Core, Node, Browser, Electron, NWjs, NodeGui, AI.
  It is not built separately; each app compiles the parts it uses.
- `Node/`: Node.js app that tests the Core and Node libraries.
- `Browser/`: browser app that tests the Core and Browser libraries.
- `Playground/`: browser app with an in-memory copy of the compiler, to evaluate ST expressions.
- `Examples/`: example apps (AI, Balls, Benchmark, Counter, Electron, NWjs, PWA, Shop, Todo, WebWorkers).
  Has its own scripts that call the scripts of each example. See ./Examples/Examples.md.
- `Contributions/`: apps that are not part of the main system. Not called by the root scripts.
- `Extension/`: the VSCode language extension (syntax coloring). Installed by `install.sh`.
- `Database/`: SQL scripts to create the example databases (MariaDB, MySQL, Postgres, SQLite).
- `Documentation/`: user documentation in Markdown: installing, language, testing, deploying, design.

## Root scripts

All scripts are bash (use Git Bash on Windows). They set the working directory to the script folder
and most stop at the first failing step (`set -e`).
- `install.sh`: checks the prerequisites (VSCode, Node.js >= 25, npm, global tsc, npx http-server, kill-port),
  then runs install in Extension, Compiler, Node and Database.
- `installAll.sh`: `install.sh`, then `Examples/install.sh`.
- `build.sh`: builds the core components: Compiler, Node, Browser, Playground.
  Building Node and Browser also runs their tests.
- `buildAll.sh`: `build.sh`, then `Examples/build.sh`.
- `clean.sh`: removes all compiled code (asks for confirmation).
- `removeModules.sh -y`: removes the node_modules folders of the core projects and the examples.
- `update.sh -y`: updates the npm dependencies of Compiler, Node and the examples to the latest versions.
- `zipit.sh`: zips this folder to `../<folder>.zip`, without node_modules and bin folders.

## Editing the scripts

- When adding or removing a subproject or an example, update the matching root and Examples scripts.
- Keep the order of the calls: the Compiler must be built before the projects that use it.
- Follow the style of the existing scripts: tabs, a comment header describing the script,
  and `-y` arguments for destructive scripts.

## Other files

- `README.md`: the GitHub front page, including the release news.
- `Todo.txt`: private notes; ignored by git.
- `package.json`: empty; not used for building.

## Working with Claude

- When a task is finished, or the user says to stop, only start working again on a request typed by the user.
  Do not act on external events, like background task notifications (e.g. a web server that exited):
  do not restart processes or investigate them on your own, just report the event briefly.
