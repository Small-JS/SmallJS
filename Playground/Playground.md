
# Playground

This project provides a playground where you can
evaluate arbitrary Smalltalk (ST) expressions and see the results.
First run `startWebBrowser.sh` to start a static web server.
Before the app is started, all ST sources are compiled first.

Now enter an arbitrary ST expression in the expression text area
and press [>Evaluate] to see the result below.
This is handy for learning SmallJS and real-time testing.

## How it works

Expressions are evaluated locally in the browser.
For a new expression a slightly modified version of the compiler is used that compiles to memory. Before compilation the array of compiled class names is fetched from the file:
`Smalltalk/CompiledClassesJson.js` to be able to check references to class name references.
The evaluated expression is then put into temporary class `Evaluator` in the method `evaluate`.
This class is compiled to memory and put in a HTML `<script>` node on the page ending with some JS code that calls the `evaluate` function and catches the async result in a callback.

## How to upgrade (for maintainers)

If the compiler changes, it needs to be re-ported to the playground with a few changes.
The leading source files of the compiler are in the folder `/Compiler/src`.
Overwrite sources files with the same names as in `/Playground/src/Compiler`.
Then search for the string "Playground" in the sources to see where code needs to be adjusted.

Note that the file `/Playground/src/Compiler/SourceNode.ts` is unique to the Playground.
This is a limited implementation of the npm package `source-node`
that only manages source trees but does not generate (unneeded) source map files.
