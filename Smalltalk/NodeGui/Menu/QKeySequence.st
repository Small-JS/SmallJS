CLASS QKeySequence EXTENDS JsObject MODULE NodeGui CLASSVARS '' VARS ''

"A sequence of up to 4 keys, used for shortcuts, e.g. 'Ctrl+S' or 'Ctrl+K, Ctrl+C'."

CLASSMETHODS

new
	"Answer an empty key sequence."
	^ self fromJs: INLINE 'new nodegui$.QKeySequence()'.
!
new: keys
	"Keys is a String in portable text format, e.g. 'Ctrl+S' or 'Ctrl+K, Ctrl+C'."
	^ self fromJs: INLINE 'new nodegui$.QKeySequence( keys.js )'.
!
fromVariant: variant
	"Answer the key sequence held by QVariant variant, e.g. from QObject property:."
	^ self fromJs: INLINE 'nodegui$.QKeySequence.fromQVariant( variant.js )'.
!

"Sequence format enums, used by toString:"

nativeText
	"Text for display, e.g. on macOS 'Ctrl' is shown as the command key symbol."
	^ 0.
!
portableText
	"Text that is the same on all platforms, e.g. for storing."
	^ 1.
!

"Sequence match enums, answered by matches:"

noMatch
	^ 0.
!
partialMatch
	^ 1.
!
exactMatch
	^ 2.
!

METHODS

"Comparing"

= keySequence
	"Key sequences are equal if they have the same keys."
	^ ( keySequence isKindOf: QKeySequence ) and: [ self toString = keySequence toString ].
!
matches: keySequence
	"Answer a sequence match enum: exactMatch if keySequence is equal,
	 partialMatch if keySequence starts with this sequence, otherwise noMatch."
	^ Integer fromJs: INLINE 'this.js.matches( keySequence.js )'.
!

"Accessing"

count
	"Answer the number of keys in the sequence, 0 to 4."
	^ Integer fromJs: INLINE 'this.js.count()'.
!
isEmpty
	^ Boolean fromJs: INLINE 'this.js.isEmpty()'.
!

"Printing"

toString
	"Answer the keys in portable text format."
	^ self toString: QKeySequence portableText.
!
toString: format
	"Answer the keys as text in format, a sequence format enum."
	^ String fromJs: INLINE 'this.js.toString( format.js )'.
!
