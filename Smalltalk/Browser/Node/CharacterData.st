CLASS CharacterData EXTENDS Node MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS abstract class CharacterData."

METHODS

"Properties."

data
	^ String fromJs: INLINE 'this.js.data'.
!
data: data
	INLINE 'this.js.data = data.js'.
!
length
	^ String fromJs: INLINE 'this.js.length'.
!
nextElementSibling
	^ Element fromJsSubElement: INLINE 'this.js.nextElementSibling'.
!
previousElementSibling
	^ Element fromJsSubElement: INLINE 'this.js.previousElementSibling'.
!

"=== Methods."

"Node operations."

before: node
	INLINE 'this.js.before( node.js )'.
!
after: node
	INLINE 'this.js.after( node.js )'.
!
replaceWith: node
	INLINE 'this.js.replaceWith( node.js )'.
!

"String operations."

appendData: string
	^ String fromJs: INLINE 'this.js.appendData( string.js )'.
!
deleteDataAt: offset count: count
	INLINE 'this.js.deleteData( offset.js - 1, count.js )'.
!
insertDataAt: offset with: string
	INLINE 'this.js.insertData( offset.js - 1, string.js )'.
!
remove
	INLINE 'this.js.remove()'.
!
replaceDataAt: offset count: count with: string
	INLINE 'this.js.replaceData( offset.js - 1, count.js, string.js )'.
!
substringDataAt: offset count: count
	^ String fromJs: INLINE 'this.js.substringData( offset.js - 1, count.js )'.
!
