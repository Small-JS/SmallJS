CLASS MutationObserver EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: MutationObserver,
 which reports changes to the DOM tree, like added nodes and changed attributes.
 The changes are reported asynchronously, in batches of MutationRecords."

CLASSMETHODS

"Creating"

new
	self error: 'Create a new MutationObserver with: MutationObserver new: [ :records :observer | ... ]'.
!
new: block
	"Block is called with an Array of MutationRecords and the MutationObserver.
	 The second block argument is optional."
	| jsBlock |
	jsBlock := [ :jsRecords :jsObserver |
		block
			value: ( Array fromJs: jsRecords elementClass: MutationRecord )
			value: ( MutationObserver fromJs: jsObserver ) ].
	^ self fromJs: INLINE 'new MutationObserver( jsBlock.js )'.
!

METHODS

"Observing"

observe: target options: options
	"Target is a Node. Options is a MutationObserverOptions instance.
	 Options must set at least one of: childList, attributes or characterData,
	 or attributeOldValue, characterDataOldValue or attributeFilter, which imply them.
	 Otherwise this throws a JS TypeError.
	 Observing the same target again replaces its options."
	INLINE 'this.js.observe( target.js, options.js )'.
!
disconnect
	"Stop observing all targets. Pending records are discarded."
	INLINE 'this.js.disconnect()'.
!
takeRecords
	"Answer and remove the pending MutationRecords, that are not yet passed to the block."
	^ Array fromJs: INLINE 'this.js.takeRecords()' elementClass: MutationRecord.
!
