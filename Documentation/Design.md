# SmallJS design

There are other Smalltalks out there like, Pharo, Squeak, Dolphin and Cincom.
SmallJS takes a different approach to these in de following ways:

- It compiles to JavaScript that can run in any modern browser and on Node.js.

SmallJS is source file based (not 'image based')

- So you can use your favorite, powerful IDE.
- Apps can remain small an modular, no need for 'image stripping'
- The IDE is safely separated from your app.
- The ST to JS compiler is written in TypeScript, not ST. So there are no 'bootstrapping' issues, even when ST is modified at a low level.

Here's a small PowerPoint presentation with the points above and more,\
if you want to learn more or tell others: [Why_SmallJS.pptx](Why_SmallJS.pptx)

## [Design details](DesignDetails.md)

These are some detailed design decisions for the SmallJS system.\
They differ from other Smalltalk implementations...

## [Design improvements](DesignImprovements.md)

Documents where SmallJS attempts to improve on the design of the underlying (encapsulated) JavaScript / DOM / HTML implementation.
