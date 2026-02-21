CLASS Frequencies EXTENDS Object MODULE FrequenciesApp
	CLASSVARS '' VARS 'letterDictionary'

constructor
	letterDictionary := Dictionary new.
!
calculate: string
	letterDictionary clear.
	string do: [ :character |
		character isLetter ifTrue: [
			self incrementFrequency: character toLowerCase ] ].
	"Sort result by frequency descending."
	letterDictionary keyValues sortWith:
		[ :kv1 :kv2 | kv2 value - kv1 value ].
!
incrementFrequency: letter
	| frequency |
	frequency := letterDictionary at: letter ifAbsent: [ 0 ].
	letterDictionary at: letter put: frequency + 1.
!
letterDictionary
	^ letterDictionary.
!
