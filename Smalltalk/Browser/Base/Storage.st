CLASS Storage EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encasulates the JS class: Storage.
 Instances are obtained with: Storage local / session.
 Keys and values are strings."

CLASSMETHODS

local
	"Return the localStorage singleton, which persists across browser sessions."
	^ Window default localStorage.
!
session
	"Return the sessionStorage singleton, which persists for the current page session only."
	^ Window default sessionStorage.
!

METHODS

"Accessing"

length
	^ Integer fromJs: INLINE 'this.js.length'.
!
key: index
	"Return the name of the key at the (zero-based) index, or nil if index is out of range.
	 Note: The order of the keys is user-agent defined."
	INLINE 'let jsKey = this.js.key( index.js )'.
	INLINE 'if( jsKey == null ) return stNil$'.
	^ String fromJs: INLINE 'jsKey'.
!
keys
	"Return all keys as an Array of Strings."
	^ Array fromJsStrings: INLINE 'Object.keys( this.js )'.
!
item: key
	"Return the value for the key, or nil if the key does not exist."
	INLINE 'let jsValue = this.js.getItem( key.js )'.
	INLINE 'if( jsValue == null ) return stNil$'.
	^ String fromJs: INLINE 'jsValue'.
!

"Modifying"

item: key value: value
	INLINE 'this.js.setItem( key.js, value.js )'.
!
removeItem: key
	INLINE 'this.js.removeItem( key.js )'.
!
clear
	"Remove all keys."
	INLINE 'this.js.clear()'.
!
