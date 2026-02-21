CLASS TestFrequenciesApp EXTENDS Object MODULE TestFrequenciesApp
	CLASSVARS '' VARS 'frequenciesApp'

async test: aFrequenciesApp
	frequenciesApp := aFrequenciesApp.
	await TestFrequencies all.
	await self testGui.
	frequenciesApp stop.
!
async testGui
	frequenciesApp inputTextArea value: 'abb'.
	frequenciesApp calculateButton click.
	await Timer timeout: 3000.

	self checkRow: 0 letter: $b frequency: 2.
	self checkRow: 1 letter: $a frequency: 1.
!
checkRow: rowIndex letter: letter frequency: frequency
	| row |
	row := frequenciesApp frequenciesTable tBody rows at: rowIndex.
	self assert: [ ( row cells at: 0 ) textContent = letter toString ].
	self assert: [ ( row cells at: 1 ) textContent = frequency toString ].
!

