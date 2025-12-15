## SmallJS design improvements over JavaScript / DOM / HTML

Documents perceived design flaws in JavaScript / DOM / HTML.
These can be a basis for implementing cleaner structures in SmallJS, maintaining functionality.
When implementing cleaner structures would deviate too far from expected JS / DOM behavior,
no optimization will be provided, and that choice will be documented here.

# JavaScript

- Numbers are always floats, with some test for "integer floats".\
	ST: Implement integers separate from floats.
- BitInts are limited in use and are treated very differently from Numbers\
	ST: Implement LargeInteger class in unified Magnitude hierarchy
		with automatic scaling between small and large integers.
- The value "undefined" is returned for methods that do not return a specific value, preventing message chaining.\
	ST: Return 'self' ('this') as default for easier message changing.
	ST: Use ';' operator to ignore unneeded return values.
	ST: Always return self when no return value is created. (Don't return an unchanged argument as a pass-through.)
- JS deals with screen coordinates a lot, put does not have an Point class.
	ST: Implement Point class and use this iso passing around separate X and Y coordinates.
- JS has different classes for rectangles, with "loose" x, y and w, h coordinates.
	ST: Implement single Rectangle class using Point objects for origin and extent.
- JS methods can have substantially different behavior depending on argument types given.
	ST: Implement these behaviors as separate methods with clear names.
- JS has 'null' and 'undefined' which is unnecessary and requires extra checking.
	ST: Implement both as 'nil'.

# DOM / HTML

- Using different string type DOMString makes things complex.\
	ST: Implement all behaviors in single String class.
- Using different list, map and iterator types makes things complex.\
	ST: Implement all behaviors in Array and Map (todo) class.\
	Note: Iterating over live HTML lists is not implemented yet.
- Having separate 'tree element' abstract base classes Node and Element is unneeded.\
	ST: No solution, is too embedded in the whole DOM.
- Having separate document classes Document, DocumentFragment, ShadowRoot seems unneeded.\
	ST: No solution, is too embedded in the whole DOM.
- JS dynamic import() function does not support modules.\
	Needed when evaluating ST expressions.\
	ST: Workaround by adding a script node to the current document and starting that.