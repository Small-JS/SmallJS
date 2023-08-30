CLASS NamedNodeMap EXTENDS JsObject MODULE DOM CLASSVARS '' VARS ''
	"This class encasulates the JS NamedNodeMap class."

CLASSMETHODS

METHODS

"Properties."

length
	^ Integer fromJs: INLINE 'this.js.length'.
!

"Methods"

getNamedItem: name
	^ Attr fromJs: INLINE 'this.js.getNamedItem( name.js )'.
!
setNamedItem: attr
	INLINE 'this.js.setNamedItem( attr.js )'.
!
removeNamedItem: attrName
	INLINE 'this.js.removeNamedItem( attrName.js )'.
!
item: index
	"Index is 1 based, per ST convertion."
	^ Attr fromJs: INLINE 'this.js.item( index.js - 1 )'.
!
