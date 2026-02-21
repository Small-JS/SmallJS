CLASS Character EXTENDS Magnitude MODULE Core CLASSVARS '' VARS ''
	"The inherited variable 'js' contains a JS integer number representing the Unicode value of the character."

CLASSMETHODS

fromCode: code
	^ self new js: code js.
!
newline
	^ self fromCode: 10.
!

METHODS

"Acesssing."

code
	^ Integer fromJs: INLINE 'this.js'.
!

"Converting."

toString
	^ String fromCharacter: self.
!
toUpperCase
	^ self isLowerCase
		ifTrue: [ Character fromCode: self code - 32 ]
		ifFalse: [ self ].
!
toLowerCase
	^ self isUpperCase
		ifTrue: [ Character fromCode: self code + 32 ]
		ifFalse: [ self ].
!

"Comparisons."

= character
	^ Boolean fromJs: INLINE 'this.js == character.js'.
!
< character
	^ Boolean fromJs: INLINE 'this.js < character.js'.
!
<= character
	^ Boolean fromJs: INLINE 'this.js <= character.js'.
!

"Testing."

isUpperCase
	^ Boolean fromJs: INLINE 'this.js >= 65 && this.js <= 90'.
!
isLowerCase
	^ Boolean fromJs: INLINE 'this.js >= 97 && this.js <= 122'.
!
isLetter
	^ self isUpperCase | self isLowerCase.
!
isDigit
	^ Boolean fromJs: INLINE 'this.js >= 48 && this.js <= 57'.
!
