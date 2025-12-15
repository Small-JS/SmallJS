# SmallJS design details

These are some detailed design decisions for the SmallJS system.\
They differ from other Smalltalk implementations...

- SmallJS overall design goals
	- Runs in any modern browser and on Node.js.
	- Lightweight implementation. Fast startup times.
	- Pure ST language behavior, hiding JS pitfalls.
	- Fast direct DOM manipulation in MVC model, no HTML rendering.
	- Implement only 1 way of doing something in ST when there are multiple JS options.
<br><br>
- File based development, using VSCode as the IDE
- Leverage the powerful and mature IDE features of VSCode, including step debugging.
	- Facilitates source code control, needed anyway.
	- Keep runtime small and modular, no need for "image stripping".
<br><br>
- The Compiler is written in TypeScript
	- Not JS, for type safety of course!
	- The compiler is not written in ST itself, to prevent bootstrapping issues.
<br><br>
- Compiles (transpiles) to high level JS
	- Not to bytecodes, interpreter on interpreter would slow and hard to debug.
	- Not to TS, preventing need for extra transpiler step.
	- Adding new JS primitives is easy this way.
<br><br>
- Compiler targets latest JS version (esNext).
	- Will give cleaner, easier to debug output.
	- Browsers on all devices are updated regularly nowadays.
<br><br>
- JS native types are wrapped in ST classes
	- Makes implementation simpler and cleaner.
	- Prevents unwanted leaking of JS behavior to ST.
	- BigInt support can be transparent, like it should be.
<br><br>
- Smalltalk library
	- Standardize on JS naming of methods, because of familiarity.
	- Wrap high level JS classes i.s.o. re-implementing them in ST. E.g.: class Date.
	- Capitalized JS abbreviations are converted to ST camel-case.\
	  E.g.: HTLMElement -> HtmlElement.
<br><br>
- HTML - DOM
	- Support for direct DOM manipulation, not HTML generation.
	- HTML & CSS used as starting templates, dynamic behavior implemented in ST for full control.
	- Only support latest HTML version, no poly-fills, quirks or deprecated features.
	- Only international English language support, for now.
	- Event handling all done through single *addEventHandler* method.
	- Only implement HTML elements for *GUI* features,\
		other stuff (data) should be done directly in ST.
	- All documents are HTML documents.\
		Lesser used XML, SVG, XSLT, XPath, Animations are not implemented yet.
	- DOM / HTML classes that mimic basic JS data types are not implemented.\
		Their use is replaced with ST basic data types. E.g.: DOMString > String.
	- DOM collection and iterator classes are not implemented.
		Use ST collections in stead, mostly Array.
	- ST Namespaces are not implemented yet.
	- No automatic conversion from strings to string nodes.\
		Use objects of proper classes.
	- ST class Document contains merged functionality of the JS Document and HTMLDocument classes.
