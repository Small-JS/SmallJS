# SmallJS language

## SmallJS

SmallJS is an implementation of the pure object oriented language [Smalltalk](https://en.wikipedia.org/wiki/Smalltalk) (ST).\
Everything in ST is an object, including integers, strings and classes themselves.\
ST objects communicate by sending messages to each other.\
This allows ST to be very readable, expressive and elegant,\
while maintaining maximum customizability at every level.

## Why SmallJS?

So why create SmallJS, when there are already good and free Smalltalks out there?\
The short answer is: web development.

In a web browser, you eventually will have to run some form of JavaScript (JS).\
SmallJS transpiles to JS shielding you from JS's (ahem) 'quirks',\
while enabling you to run and debug ST code *inside* your browser.\
And wouldn't it be nice to also use that same ST language in the back-end?\
You can, because SmallJS also runs in Node.js using the same core library.

## SmallJS tutorial

If you're new to SmallJS or Smalltalk, no worries.\
You can start by walking through this online tutorial:
[small-js.org/Tutorial](https://small-js.org/Tutorial) .\
You can testing you own code live in the online playground:
[small-js.org/Playground](https://small-js.org/Playground) .

## SmallJS syntax

Here's a quick overview of the [syntax of SmallJS](Syntax.md).\
It shows all language features in a single page.\
Use the tutorial for a more gradual introduction.

## Asynchronous execution

To enable async execution, alas the JS model must be strictly followed.\
Here's how it's implemented in SmallJS: [Async](Async.md)

