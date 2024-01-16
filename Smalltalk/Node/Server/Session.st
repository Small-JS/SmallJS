CLASS Session EXTENDS JsObject MODULE Server CLASSVARS '' VARS ''
	"Implements the Session class from Express."

"Getter and setter convenience methods."

get: name
	^ self atJsProperty: name.
!
set: name to: value
	^ self atJsProperty: name put: value.
!
id
	^ String fromJs: INLINE 'this.js.id'.
!
