CLASS MutationRecord EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: MutationRecord, a change reported by a MutationObserver."

METHODS

"Properties"

addedNodes
	^ Array fromJs: INLINE 'this.js.addedNodes' elementConverter:
		[ :node | Node fromJsSubNode: node ].
!
attributeName
	"The name of the changed attribute, or nil."
	^ String fromJs: INLINE 'this.js.attributeName'.
!
attributeNamespace
	"The namespace of the changed attribute, or nil."
	^ String fromJs: INLINE 'this.js.attributeNamespace'.
!
nextSibling
	"The next sibling of the added or removed nodes, or nil."
	^ Node fromJsSubNode: INLINE 'this.js.nextSibling'.
!
oldValue
	"The old attribute value or text, if requested with attributeOldValue: or characterDataOldValue:.
	 Otherwise nil."
	^ String fromJs: INLINE 'this.js.oldValue'.
!
previousSibling
	"The previous sibling of the added or removed nodes, or nil."
	^ Node fromJsSubNode: INLINE 'this.js.previousSibling'.
!
removedNodes
	^ Array fromJs: INLINE 'this.js.removedNodes' elementConverter:
		[ :node | Node fromJsSubNode: node ].
!
target
	"The Node that changed. For type 'characterData', the Text or Comment node."
	^ Node fromJsSubNode: INLINE 'this.js.target'.
!
type
	"One of: 'attributes', 'characterData' or 'childList'."
	^ String fromJs: INLINE 'this.js.type'.
!
