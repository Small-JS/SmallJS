CLASS CustomElementRegistry EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS class: CustomElementRegistry.
	 Element constructors are JS classes that extend HTMLElement (or a subclass of it),
	 wrapped in a JsObject."

METHODS

define: name constructor: constructor
	"Define an autonomous custom element."
	INLINE 'this.js.define( name.js, constructor.js )'.
!
define: name constructor: constructor extends: tagName
	"Define a customized built-in element, that extends the element with the given tag name.
	 Note: Not supported in Safari."
	INLINE 'this.js.define( name.js, constructor.js, { extends: tagName.js } )'.
!
get: name
	"Return the constructor of the named custom element, or nil if not defined."
	^ JsObject fromJs: INLINE 'this.js.get( name.js )'.
!
getName: constructor
	"Return the name of the custom element for the constructor, or nil if not defined."
	INLINE 'let jsName = this.js.getName( constructor.js )'.
	INLINE 'if( jsName == null ) return stNil'.
	^ String fromJs: INLINE 'jsName'.
!
upgrade: root
	"Upgrade all custom elements in the subtree of root (a Node), even if not connected to the document."
	INLINE 'this.js.upgrade( root.js )'.
!
async whenDefined: name
	"Wait until the named custom element is defined, then return its constructor."
	^ JsObject fromJs: INLINE 'await this.js.whenDefined( name.js )'.
!
