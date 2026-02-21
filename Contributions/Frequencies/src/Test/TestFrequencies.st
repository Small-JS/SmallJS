CLASS TestFrequencies EXTENDS Test MODULE TestFrequenciesApp
	CLASSVARS '' VARS ''

test
	| frequencies dictionary keyValue |
	frequencies := Frequencies new.
	frequencies calculate: 'abb'.

	dictionary := frequencies letterDictionary.
	self assert: [ dictionary size = 2 ].
	self assert: [ ( dictionary at: $a ) = 1 ].

	keyValue := dictionary keyValues first.
	self assert: [ keyValue key = $b ].
	self assert: [ keyValue value = 2 ].
!

