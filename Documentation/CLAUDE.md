This folder holds the high level user documentation of SmallJS, a Smalltalk-80 dialect that compiles to JavaScript.
It is not a project: there is nothing to build, run or test here, and it has no scripts.
All content is Markdown (GitHub flavored), plus a few images.
Subprojects have their own user documentation in `../<Project>/<Project>.md`; this folder covers the system as a whole.

## Files

- `Documentation.md`: the entry page, linked from `../README.md`.
  Links to the topic pages below and to the `<Project>.md` page of each subproject.
- `SmallJS.png`: the SmallJS logo, shown on the GitHub front page (`../README.md`).
- `Documentation.code-workspace`: VSCode workspace with this folder and the repo root.
- `Installing/`
  - `Installing.md`: getting the repo, running `install.sh` and `build.sh`.
  - `Prerequisites.md`: installing Git, VSCode, the VSCode Firefox extension, Node.js, TypeScript, etc.
  - `Updating.md`: updating VSCode, Node.js, global npm packages and npm dependencies.
  - `Building.md`: running `build.sh` / `buildAll.sh`, browser testing setup via `.env`, MacOS and Firefox notes.
- `Language/`
  - `Language.md`: what SmallJS is and why, links to the online tutorial and the pages below.
  - `Syntax.md`, `Syntax.png`: the SmallJS syntax on one page.
  - `Async.md`: async / await / promises in JS and in SmallJS (async blocks, loops, class Promise).
- `Testing/Testing.md`: writing and running unit tests (naming of Test classes and methods, assertions).
- `Deploying/Deploying.md`: which files to copy to deploy an app.
- `Design/`
  - `Design.md`: how SmallJS differs from other Smalltalks (file based, compiles to JS, compiler in TypeScript).
  - `DesignDetails.md`: detailed design decisions.
  - `DesignImprovements.md`: perceived flaws in JS / DOM / HTML and how SmallJS improves on them.

## Editing the documentation

- The audience is SmallJS users: developers who may be new to Smalltalk, SmallJS or the tooling.
- Keep pages short and high level; details belong in the documentation of the subprojects.
- Follow the style of the existing pages: a `#` title, `##` / `###` sections,
  a trailing `\` for line breaks inside a paragraph, and `>` blockquotes for commands and URLs to type or open.
- Use relative links, so they work both on GitHub and in the VSCode Markdown preview.
  Pages in subfolders link to each other by filename (e.g. `[Async](Async.md)`),
  and to subprojects via `../` paths from the page's own location.
- When adding, renaming or moving a page, update the links to it in `Documentation.md`, `../README.md`
  and the other pages. Check that all relative links still resolve.
- When the root scripts, the subprojects or the examples change, check that the descriptions here still match,
  e.g. the list of examples in `Documentation.md` and the prerequisites in `Installing/`.
- External links: the online tutorial is at https://small-js.org/Tutorial and the Playground at https://small-js.org/Playground.
