CLASS KeyboardEventOptions EXTENDS UiEventOptions MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating a KeyboardEvent instance."

METHODS

"Key"

key
	^ String fromJs: INLINE 'this.js.key'.
!
key: key
	INLINE 'this.js.key = key.js'.
!
code
	^ String fromJs: INLINE 'this.js.code'.
!
code: code
	INLINE 'this.js.code = code.js'.
!
location
	^ Integer fromJs: INLINE 'this.js.location'.
!
location: location
	INLINE 'this.js.location = location.js'.
!
repeat
	^ Boolean fromJs: INLINE 'this.js.repeat'.
!
repeat: repeat
	INLINE 'this.js.repeat = repeat.js'.
!
isComposing
	^ Boolean fromJs: INLINE 'this.js.isComposing'.
!
isComposing: isComposing
	INLINE 'this.js.isComposing = isComposing.js'.
!

"Modifier keys"

altKey
	^ Boolean fromJs: INLINE 'this.js.altKey'.
!
altKey: altKey
	INLINE 'this.js.altKey = altKey.js'.
!
ctrlKey
	^ Boolean fromJs: INLINE 'this.js.ctrlKey'.
!
ctrlKey: ctrlKey
	INLINE 'this.js.ctrlKey = ctrlKey.js'.
!
metaKey
	^ Boolean fromJs: INLINE 'this.js.metaKey'.
!
metaKey: metaKey
	INLINE 'this.js.metaKey = metaKey.js'.
!
shiftKey
	^ Boolean fromJs: INLINE 'this.js.shiftKey'.
!
shiftKey: shiftKey
	INLINE 'this.js.shiftKey = shiftKey.js'.
!
