# ./Smalltalk folder

The main Smalltalk source code of the system, for both the Node.js and browser environments and classes shared by both.

There are 3 subfolders in this folder:
- Core - Common ST classes for the Node and Browser environments
- Browser - Browser specific classes, mainly the DOM.
- Node - Node.js specific classes for, creating server apps.

Every class is implemented in a separate *.st file.
Further subfolders are used to group classes logically,
but their location does not affect their use because all classes are global variables.

Classes are grouped in modules, that are implemented using JS (ECMAScript) modules.
This limits the number of JS files that are created with compilation and allows for circular class references, within modules only.

## Class syntax

Here's an example SmallJS class from the Smalltalk folder.
For more info standard Smalltalk syntax,

![Integer Class](../Documentation/IntegerClass.png)

Explanation of keywords used in order:

- `CLASS` : Is followed by the class name.
- `EXTENDS` : Indicates the base class. `Object` is the root class.
- `MODULE` : The JS module this class should be put in.
- `CLASSVARS` : Variables of the class (not object) instance. Sort of globals.
- `VARS` : Instance variables objects created from a class, e.g. `String new`.
- `"Instance ..."` : Comments are put in double quotes.
- `CLASSMETHODS` : Following methods will be added to the (meta)class, like static methods in JS.
- `fromJs: jsNumber` : Keyword method `fromJs` with argument `jsNumber`.
- `INLINE` : Inline JS in the method. ST variables can be accessed with the same name.
- `^` : Return a value.
- `!` : End of the method
- `METHODS` : Following methods will be added to class **instances**, like regular methods in JS.\
	This is the default method type if neither `CLASSMETHODS` or `METHODS` is specified.
