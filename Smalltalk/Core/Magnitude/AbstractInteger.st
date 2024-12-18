CLASS AbstractInteger EXTENDS Number MODULE Core CLASSVARS '' VARS ''
	"Abstract base class for AbstractInteger classes (small and large)."

METHODS

"Conversions."

toInteger
	^ self.
!

"Comparions to fractions."

argIsEqualToFraction: fraction
	^ fraction numerator = ( self * fraction denominator ).
!
argIsSmallerThanFraction: fraction
	^ fraction numerator < ( self * fraction denominator ).
!
argIsSmallerOrEqualToFraction: fraction
	^ fraction numerator <= ( self * fraction denominator ).
!

"Basic arithmatic with Fraction arguments."

addToFraction: fraction
	^ Fraction numerator: fraction numerator + ( self * fraction denominator )
		denominator: fraction denominator.
!
subtractFromFraction: fraction
	^ Fraction numerator: fraction numerator - ( self * fraction denominator )
		denominator: fraction denominator.
!
multiplyByFraction: fraction
	^ Fraction numerator: fraction numerator * self
		denominator: fraction denominator.
!
divideIntoFraction: fraction
	^ Fraction numerator: fraction numerator
		denominator: fraction denominator * self.
!
integerDivideIntoFraction: fraction
	^ fraction numerator // ( fraction denominator * self ).
!
moduloFromFraction: fraction
	^ fraction numerator % ( self * fraction denominator ) / fraction denominator.
!

"Iteration."

to: max do: block
	| index |
	index := self.
	[ index <= max ] whileTrue: [
		block value: index.
		index := index + 1 ].
!
to: limit by: by do: block
	| index |
	by = 0 ifTrue: [ self error: 'to:by:do: By is 0.'].

	index := self.
	[ ( ( by > 0 ) & ( index <= limit ) ) |
		( ( by < 0 ) & ( index >= limit ) ) ] whileTrue: [
		block value: index.
		index := index + by ].
!
timesRepeat: block
	| count |
	count := self.
	[ count > 0 ] whileTrue: [
		block value.
		count := count - 1 ].
!

"Other arithmatic functions."

even
	^ self % 2 = 0.
!
odd
	^ self % 2 ~= 0.
!
factorial
	| fac |
	self < 0 ifTrue: [
		self error: 'Negative factorial.' ].

	fac := 1.
	1 to: self do: [ :num |
		fac := fac * num ].

	^ fac.
!
isPrime
	"Answer whether the receiver is a prime number."
	| divider |

	self <= 3 ifTrue: [ ^ self > 1 ].
	( self even or: [ self \\ 3 = 0 ] ) ifTrue: [ ^ false ].

	divider := 5.
	[ divider * divider <= self ] whileTrue: [
		( self \\ divider = 0 or: [ self \\ ( divider + 2 ) = 0 ] ) ifTrue: [ ^ false ].
		divider := divider + 6 ].
	^ true.
!
factors
	"Answer an OrderedCollection with the prime factors making up this number.
	 Receiver should be positive."

	| factors remainder divider |

	factors := Array new.
	remainder := self.

	[ remainder > 1 ] whileTrue: [
		divider := remainder firstDivider.
		factors add: divider.
		remainder := remainder // divider ].

	^ factors.
!
firstDivider
	"Answer the first integer divider of the reciever,
	 so will return receiver if it is prime.
	 Returns only positive dividers."

	| maxDivider positiveReceiver |

	positiveReceiver := self abs.

	maxDivider := positiveReceiver sqrt toInteger + 1.

	2 to: maxDivider do: [ :divider |
		( positiveReceiver \\ divider = 0 ) ifTrue: [
			^ divider ] ].

	^ positiveReceiver.
!
