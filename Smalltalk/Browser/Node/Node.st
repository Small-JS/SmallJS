CLASS Node EXTENDS EventTarget MODULE DOM CLASSVARS '' VARS ''
	"This class encasulates the JS 'Node' class."


CLASSMETHODS

fromJsSubNode: jsNode
	"Create ST Node subsclass object from JS Node element or subsclass.
	 Raise error if none found."

	| jsClassName |

	INLINE 'if( jsNode == null ) return stNil'.

	jsClassName := String fromJs: INLINE 'jsNode.constructor.name'.

	jsClassName = 'Text' ifTrue: [ ^ Text fromJs: jsNode ].
	jsClassName = 'Attr' ifTrue: [ ^ Attr fromJs: jsNode ].
	jsClassName = 'CharacterData' ifTrue: [ ^ CharacterData fromJs: jsNode ].
	jsClassName = 'Text' ifTrue: [ ^ Text fromJs: jsNode ].
	jsClassName = 'Comment' ifTrue: [ ^ Comment fromJs: jsNode ].

	jsClassName = 'Document' ifTrue: [ ^ Document fromJs: jsNode ].
	jsClassName = 'HTMLDocument' ifTrue: [ ^ Document fromJs: jsNode ].
	jsClassName = 'DocumentFragment' ifTrue: [ ^ DocumentFragment fromJs: jsNode ].
	jsClassName = 'DocumentType' ifTrue: [ ^ DocumentType fromJs: jsNode ].

	"Try if jsNode is a subclass of Element."
	^ Element fromJsSubElement: jsNode.
!

METHODS

"Properties"

baseUri
	^ String fromJs: INLINE 'this.js.baseURI'.
!
childNodes
	^ Array fromJs: INLINE 'this.js.childNodes' elementConverter:
		[ :node | Node fromJsSubNode: node ].
!
firstChild
	^ Node fromJsSubNode: INLINE 'this.js.firstChild'.
!
isConnected
	^ Boolean fromJs: INLINE 'this.js.isConnected'.
!
lastChild
	^ Node fromJsSubNode: INLINE 'this.js.lastChild'.
!
nextSibling
	^ Node fromJsSubNode: INLINE 'this.js.nextSibling'.
!
nodeName
	^ String fromJs: INLINE 'this.js.nodeName'.
!
nodeType
	^ Integer fromJs: INLINE 'this.js.nodeType'.
!
nodeValue
	^ String fromJs: INLINE 'this.js.nodeValue'.
!
nodeValue: nodeValue
	INLINE 'this.js.nodeValue = nodeValue.js'.
!
ownerDocument
	^ Document fromJs: INLINE 'this.js.ownerDocument'.
!
parentElement
	^ Element fromJsSubElement: INLINE 'this.js.parentElement'.
!
parentNode
	^ Node fromJsSubNode: INLINE 'this.js.parentNode'.
!
previousSibling
	^ Node fromJsSubNode: INLINE 'this.js.previousSibling'.
!
textContent
	^ String fromJs: INLINE 'this.js.textContent'.
!
textContent: textContent
	INLINE 'this.js.textContent = textContent.js'.
!

"Methods"

appendChild: node
	INLINE 'this.js.appendChild( node.js )'.
!
cloneNode: deep
	^ Node fromJsSubNode: INLINE 'this.js.cloneNode( deep.js )'.
!
compareDocumentPosition: node
	^ Integer fromJs: INLINE 'this.js.compareDocumentPosition( node.js )'.
!
contains: node
	^ Boolean fromJs: INLINE 'this.js.contains( node.js )'.
!
getRootNode
	^ Node fromJsSubNode: INLINE 'this.js.getRootNode()'.
!
getRootNodeComposed
	^ Node fromJsSubNode: INLINE 'this.js.getRootNode( { composed: true } )'.
!
hasChildNodes
	^ Boolean fromJs: INLINE 'this.js.hasChildNodes()'.
!
insert: node before: referenceNode
	| jsReferenceNode |
	jsReferenceNode := referenceNode isNil ifTrue: [ INLINE 'null' ] ifFalse: [ INLINE 'referenceNode.js' ].
	INLINE 'this.js.insertBefore( node.js, jsReferenceNode )'.
!
isEqualNode: node
	^ Boolean fromJs: INLINE 'this.js.isEqualNode( node.js )'.
!
isSameNode: node
	^ Boolean fromJs: INLINE 'this.js.isSameNode( node.js )'.
!
normalize
	INLINE 'this.js.normalize()'.
!
removeChild: node
	INLINE 'this.js.removeChild( node.js )'.
!
remove
	self parentNode removeChild: self.
!
replaceChild: node with: newNode
	INLINE 'this.js.replaceChild( newNode.js, node.js )'.
!
removeChildren
	self childNodes do: [ :childNode |
		self removeChild: childNode ].
!
