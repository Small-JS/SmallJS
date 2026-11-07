This is the VSCode language extension for SmallJS (.st files), published as `RichardRonteltap.smalljs`.
It is declarative only: there is no TypeScript or JavaScript code, no build step and no npm dependencies.
It provides syntax coloring (a TextMate grammar), bracket handling, and enables setting breakpoints in .st files.
User documentation (shown on the marketplace page): ./Extension.md.

## Files

- `package.json`: the extension manifest. Declares the `smalljs` language for `.st`,
  the grammar (scope `source.smalljs`) and `breakpoints` support for the language.
- `syntaxes/smalljs.tmLanguage.json`: the TextMate grammar; all coloring rules are here.
- `language-configuration.json`: brackets, auto-closing and surrounding pairs.
  Comments are `"..."` in SmallJS, so no line or block comment toggling is configured.
- `Test/Test.st`: a sample file to visually check the coloring. It is not compiled or run.
- `.vscode/launch.json`: "Extension" launch config; opens `Test/ExtensionTest.code-workspace`
  in an Extension Development Host with this extension loaded.
- `.vscodeignore`: files left out of the .vsix package.
- `SmallJS.png`: marketplace icon. `images/Screenshot.png`: used in Extension.md.
- `vsc-extension-quickstart.md`: the generated VSCode template readme; not maintained.
- `*.vsix`: generated packages; ignored by git.

## Grammar

The top-level patterns are applied in order: strings, constants, keywords, classes, methods, comments.
Order matters: an earlier pattern wins at the same position.
- `keyword.smalljs`: `self super nil true false`, the class file keywords
  `CLASS CLASSEXTENSION EXTENDS MODULE CLASSVARS VARS CLASSMETHODS METHODS INLINE`, and `await async`.
- `keyword.control.smalljs`: `ifTrue ifFalse whileTrue`, and runs of binary operator characters.
- `string.quoted.single.smalljs`: `'...'`. `constant.character.smalljs`: `$c`. `constant.numeric.smalljs`: digits.
- `entity.name.class.smalljs`: capitalized identifiers. `entity.name.function.smalljs`: keyword selectors (`name:`).
- `comment.smalljs`: `"..."`.

When the compiler gets a new keyword (see `Compiler/src/ClassCompiler.ts`, `tryParseTerm`),
add it to the keyword list here and add an example to `Test/Test.st`.
Known limitation: unary method names are colored like variables.

## Testing

There are no automated tests. To check a change:
press F5 in VSCode with this folder open (launch config "Extension"),
then look at `Test/Test.st` in the development host window.
Use "Developer: Inspect Editor Tokens and Scopes" to see which scope a token gets.

## Scripts

Bash scripts (Git Bash on Windows), called by the root scripts.
- `install.sh`: packages the extension with `npx @vscode/vsce package --readme-path Extension.md`
  and installs the resulting `smalljs-<version>.vsix` in VSCode with `code --install-extension`.
  The version is read from `package.json`.
- `clean.sh`: removes the generated .vsix files.

## Packaging

- vsce only uses `README.md` by default, so always pass `--readme-path Extension.md`,
  or the marketplace page has no description.
- `.vscodeignore` must leave out everything except the manifest, grammar, language configuration,
  icon, images, LICENSE and Extension.md. Add new non-extension files to it.
  Check the contents with `unzip -l smalljs-<version>.vsix`.

## Releasing

- Bump the version in `package.json` and add a release note to `Extension.md`.
- Publishing to the marketplace (`npx @vscode/vsce publish minor`) is done only by the maintainer.
  Never run it.
