CLASS HtmlLiElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class HTMLLIElement."
	"The deprecated property type is not implemented."

METHODS

value
	^ Integer fromJs: INLINE 'this.js.value'.
!
value: value
	INLINE 'this.js.value = value.js'.
!
