CLASS MutationObserverOptions EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS options object for: MutationObserver observe:options:."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

attributeFilter
	^ Array fromJsStrings: INLINE 'this.js.attributeFilter'.
!
attributeFilter: attributeFilter
	"An Array of attribute name Strings. Changes to other attributes are not reported.
	 Implies: attributes: true."
	INLINE 'this.js.attributeFilter = attributeFilter.$toJs()'.
!
attributeOldValue
	^ Boolean fromJs: INLINE 'this.js.attributeOldValue'.
!
attributeOldValue: attributeOldValue
	"Report the old attribute value in: MutationRecord oldValue. Implies: attributes: true."
	INLINE 'this.js.attributeOldValue = attributeOldValue.js'.
!
attributes
	^ Boolean fromJs: INLINE 'this.js.attributes'.
!
attributes: attributes
	"Report changes to attributes."
	INLINE 'this.js.attributes = attributes.js'.
!
characterData
	^ Boolean fromJs: INLINE 'this.js.characterData'.
!
characterData: characterData
	"Report changes to the text of Text and Comment nodes."
	INLINE 'this.js.characterData = characterData.js'.
!
characterDataOldValue
	^ Boolean fromJs: INLINE 'this.js.characterDataOldValue'.
!
characterDataOldValue: characterDataOldValue
	"Report the old text in: MutationRecord oldValue. Implies: characterData: true."
	INLINE 'this.js.characterDataOldValue = characterDataOldValue.js'.
!
childList
	^ Boolean fromJs: INLINE 'this.js.childList'.
!
childList: childList
	"Report added and removed child nodes."
	INLINE 'this.js.childList = childList.js'.
!
subtree
	^ Boolean fromJs: INLINE 'this.js.subtree'.
!
subtree: subtree
	"Also report changes to all descendants of the target."
	INLINE 'this.js.subtree = subtree.js'.
!
