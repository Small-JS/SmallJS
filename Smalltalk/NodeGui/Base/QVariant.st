CLASS QVariant EXTENDS JsObject MODULE NodeGui CLASSVARS '' VARS ''

"Holds a value of a Qt property. Use the to* methods to get the value."

CLASSMETHODS

new: value
	"Value can be a String, Number, Boolean or Array of Strings."
	^ self fromJs: INLINE 'new nodegui$.QVariant( value.$toJs() )'.
!

METHODS

toString
	^ String fromJs: INLINE 'this.js.toString()'.
!
toInt
	^ Integer fromJs: INLINE 'this.js.toInt()'.
!
toDouble
	^ Float fromJs: INLINE 'this.js.toDouble()'.
!
toBool
	^ Boolean fromJs: INLINE 'this.js.toBool()'.
!
toStringList
	^ Array fromJs: INLINE 'this.js.toStringList()' elementClass: String.
!
