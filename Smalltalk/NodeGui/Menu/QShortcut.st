CLASS QShortcut EXTENDS QObject MODULE NodeGui CLASSVARS '' VARS ''

"A keyboard shortcut, without a menu item. It is active for its parent widget,
 depending on its context, see the QAction shortcut context enums.
 NodeGui has no JS getters, so those are read as Qt properties."

CLASSMETHODS

new: parentWidget
	^ self fromJs: INLINE 'new nodegui$.QShortcut( parentWidget.js )'.
!

METHODS

setKey: keySequence
	INLINE 'this.js.setKey( keySequence.js )'.
!
key
	^ QKeySequence fromVariant: ( self property: 'key' ).
!
setContext: shortcutContext
	"Use the QAction shortcut context enums, the default is QAction windowShortcut."
	INLINE 'this.js.setContext( shortcutContext.js )'.
!
context
	^ Integer fromJs: INLINE 'this.js.property( "context" ).toInt()'.
!
setEnabled: enabled
	INLINE 'this.js.setEnabled( enabled.js )'.
!
isEnabled
	^ Boolean fromJs: INLINE 'this.js.property( "enabled" ).toBool()'.
!
setAutoRepeat: autoRepeat
	"If autoRepeat, holding the keys down activates the shortcut repeatedly."
	INLINE 'this.js.setAutoRepeat( autoRepeat.js )'.
!
autoRepeat
	^ Boolean fromJs: INLINE 'this.js.property( "autoRepeat" ).toBool()'.
!

"Events"

onActivate: block
	"Block is called when the user presses the keys."
	self addEventListener: 'activated' then: [ block value ].
!
onActivateAmbiguously: block
	"Block is called when the keys match more than one shortcut."
	self addEventListener: 'activatedAmbiguously' then: [ block value ].
!
