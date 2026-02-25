CLASS FrequenciesApp EXTENDS BrowserApp MODULE FrequenciesApp CLASSVARS ''
	VARS 'frequencies inputTextArea calculateButton frequenciesTable'

start
	frequencies := Frequencies new.
	self bindElements.
!
bindElements
	inputTextArea := Document getElementById: 'inputTextArea' class: HtmlTextAreaElement.
	calculateButton := Document getElementById: 'calculateButton' class: HtmlButtonElement.
	calculateButton onClick: [ self calculate ].
	frequenciesTable := Document getElementById: 'frequenciesTable' class: HtmlTableElement.
!
calculate
	frequencies calculate: inputTextArea value.
	self update.
!
update
	| row |
	frequenciesTable tBody innerHtml: ''.
	frequencies letterDictionary do: [ :key :value |
		row := frequenciesTable tBody insertRow: -1.
		row insertCell textContent: key toString.
		row insertCell textContent: value toString ].
!

"Accessing - Used by tests"

inputTextArea
	^ inputTextArea.
!
calculateButton
	^ calculateButton.
!
frequenciesTable
	^ frequenciesTable.
!

