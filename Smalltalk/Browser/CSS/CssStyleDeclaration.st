CLASS CssStyleDeclaration EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS classes CSSStyleDeclaration."

METHODS

"Properties."

cssText
	^ String fromJs: INLINE 'this.js.cssText'.
!
cssText: text
	^ INLINE 'this.js.cssText = text.js'.
!
length
	^ Integer fromJs: INLINE 'this.js.length'.
!
parentRule
	^ CssRule fromJs: INLINE 'this.js.parentRule'.
!
float
	^ String fromJs: INLINE 'this.js.float'.
!
float: text
	^ INLINE 'this.js.float = text.js'.
!

"Methods."

getPropertyPriority: property
	^ String fromJs: INLINE 'this.js.getPropertyPriority( property.js )'.
!
getPropertyValue: property
	^ String fromJs: INLINE 'this.js.getPropertyValue( property.js )'.
!
item: index
	^ String fromJs: INLINE 'this.js.item( index.js )'.
!
removeProperty: property
	^ String fromJs: INLINE 'this.js.getPropertyValue( property.js )'.
!
setProperty: property value: value
	INLINE 'this.js.setProperty( property.js, value.js )'.
!
