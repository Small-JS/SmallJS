CLASS Clipboard EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"TODO: Implement other methods"

readTextThen: block
	^ String fromJs: INLINE 'this.js.readText()
		.then( text => block.$value$( stString$class.$fromJs$( text ) ) )'.
!
writeText: text then: block
	^ String fromJs: INLINE 'this.js.writeText( text.js )
		.then( text => block.$value$( stString$class.$fromJs$( text ) ) )'.
!
