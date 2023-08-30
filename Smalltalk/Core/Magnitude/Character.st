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

isUppercase
	^ Boolean fromJs: INLINE 'this.js >= 65 && this.js <= 90'.
!
isLowercase
	^ Boolean fromJs: INLINE 'this.js >= 97 && this.js <= 122'.
!
isLetter
	^ self isUppercase | self isLowercase.
!
