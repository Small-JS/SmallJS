CLASS TestHtmlInputElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''
	"Form related properties are tested in TestHtmlFormElement."

test
	| input outputLabel outputButton |
	input := Document default getElementById: 'input'.
	self assert: [ input class = HtmlInputElement ].

	self assert: [ input name = 'inputName' ].
	input name: 'inputName2'.
	self assert: [ input name = 'inputName2' ].
	input name: 'inputName'.

	self assert: [ input type = 'text' ].
	input type: 'button'.
	self assert: [ input type = 'button' ].
	input type: 'text'.

	self assert: [ input disabled not ].
	input disabled: true.
	self assert: [ input disabled ].
	input disabled: false.

	self assert: [ input autofocus not ].
	input autofocus: true.
	self assert: [ input autofocus ].
	input autofocus: false.

	self assert: [ input value = 'Test input' ].
	input value: 'New input'.
	self assert: [ input value = 'New input' ].
	input setRangeText: ' inserted ' start: 3 end: 4 selectMode: 'select'.
	self assert: [ input value = 'New inserted input' ].
	input value: 'Test input'.

	self assert: [ input autocomplete= 'on' ].
	input autocomplete: 'off'.
	self assert: [ input autocomplete= 'off' ].
	input autocomplete: 'on'.

	self assert: [ input readOnly not ].
	input readOnly: true.
	self assert: [ input readOnly ].
	input readOnly: false.

	outputLabel := Document default getElementById: 'inputOutputLabel'.
	self assert: [ outputLabel class = HtmlLabelElement ].

	outputButton := Document default getElementById: 'inputOutputButton'.
	self assert: [ outputButton type = 'button' ].
	outputButton addEventListener: 'click' then: [ outputLabel textContent: input value ].
!
testValidation
	| input |
	input := Document default getElementById: 'input'.
	self assert: [ input class = HtmlInputElement ].

	self assert: [ input class = HtmlInputElement ].
	self assert: [ input validity ].
	self assert: [ input validationMessage = '' ].
	self assert: [ input willValidate ].
	self assert: [ input checkValidity ].
	self assert: [ input reportValidity ].

	input setCustomValidity: ''.
!
testSelection
	| input |
	input := Document default getElementById: 'input'.
	self assert: [ input class = HtmlInputElement ].

	input selectionStart: 1.
	self assert: [ input selectionStart = 1 ].
	input selectionEnd: 4.
	self assert: [ input selectionEnd = 4 ].

	input select.
	self assert: [ input selectionStart = 0 ].
	self assert: [ input selectionEnd = input value length ].

	input setSelectionRange: 2 to: 5.
	self assert: [ input selectionStart = 2 ].
	self assert: [ input selectionEnd = 5 ].

	self assert: [ input selectionDirection = 'forward' ].
	input selectionDirection: 'backward'.
	self assert: [ input selectionDirection = 'backward' ].
	input selectionDirection: 'forward'.

	self assert: [ input size = 20 ].
	input size: 30.
	self assert: [ input size = 30 ].
	input size: 20.
!
testCheckbox
	| checkbox |
	checkbox := Document default getElementById: 'checkbox'.
	self assert: [ checkbox class = HtmlInputElement ].

	self assert: [ checkbox checked not ].
	checkbox checked: true.
	self assert: [ checkbox checked ].
	checkbox checked: false.
!
testRadio
	| radio1 radio2 |
	radio1 := Document default getElementById: 'radio1'.
	self assert: [ radio1 class = HtmlInputElement ].
	radio2 := Document default getElementById: 'radio2'.
	self assert: [ radio2 class = HtmlInputElement ].

	self assert: [ radio1 checked ].
	self assert: [ radio2 checked not ].

	radio2 checked: true.
	self assert: [ radio1 checked not ].
	self assert: [ radio2 checked ].

	radio1 checked: true.

	self assert: [ radio1 defaultChecked ].
	radio1 defaultChecked: false.
	self assert: [ radio1 defaultChecked not ].
	radio1 defaultChecked: true.

	self assert: [ radio1 indeterminate not ].
!
testImageInput
	| imageInput |
	imageInput := Document default getElementById: 'imageInput'.
	self assert: [ imageInput class = HtmlInputElement ].

	self assert: [ imageInput alt = 'SmallJS logo' ].
	imageInput alt: 'SmallJS2'.
	self assert: [ imageInput alt = 'SmallJS2' ].
	imageInput alt: 'SmallJS logo'.

	self assert: [ imageInput imageSize = ( 50 @ 50 ) ].
	imageInput imageSize: ( 64 @ 32 ).
	self assert: [ imageInput imageSize = ( 64 @ 32 ) ].
	imageInput imageSize: ( 50 @ 50 ).

!
testFileInput
	| fileInput |
	fileInput := Document default getElementById: 'fileInput'.
	self assert: [ fileInput type = 'file' ].

	self assert: [ fileInput accept = 'image/png, image/jpeg' ].
	fileInput accept: 'image/png'.
	self assert: [ fileInput accept = 'image/png' ].
	fileInput accept: 'image/png, image/jpeg'.

	self assert: [ fileInput files = #( ) ].

	fileInput addEventListener: 'change' then: [ self onFileInputChange ].
!
onFileInputChange
	| file |
	( Document default getElementById: 'fileInput' ) files do: [ :file |
		TestFile new onTest: file. ].
!
testNumber
	| numberInput outputButton outputLabel |
	numberInput := Document default getElementById: 'numberInput'.
	self assert: [ numberInput class = HtmlInputElement ].

	self assert: [ numberInput min = '1' ].
	numberInput min: '2'.
	self assert: [ numberInput min = '2' ].
	numberInput min: '1'.

	self assert: [ numberInput max = '99' ].
	numberInput max: '98'.
	self assert: [ numberInput max = '98' ].
	numberInput max: '99'.

	self assert: [ numberInput minLength = 1 ].
	numberInput minLength: 2.
	self assert: [ numberInput minLength = 2 ].
	numberInput minLength: 1.

	self assert: [ numberInput maxLength = 2 ].
	numberInput maxLength: 3.
	self assert: [ numberInput maxLength = 3 ].
	numberInput maxLength: 2.

	self assert: [ numberInput pattern = '[0-9]*' ].
	numberInput pattern: '[0-8]*'.
	self assert: [ numberInput pattern = '[0-8]*' ].
	numberInput pattern: '[0-9]*'.

	self assert: [ numberInput placeholder = 'Two digit number' ].
	numberInput placeholder: 'Alt text'.
	self assert: [ numberInput placeholder = 'Alt text' ].
	numberInput placeholder: 'Two digit number'.

	outputLabel := Document default getElementById: 'numberInputOutputLabel'.
	self assert: [ outputLabel class = HtmlLabelElement ].

	outputButton := Document default getElementById: 'numberInputOutputButton'.
	self assert: [ outputButton type = 'button' ].
	outputButton addEventListener: 'click' then: [ outputLabel textContent: numberInput value ].
!
testDate
	| dateInput date pickButton outputButton outputLabel |
	dateInput := Document default getElementById: 'dateInput'.
	self assert: [ dateInput type = 'date' ].

	dateInput value: '1900-01-01'.
	self assert: [ dateInput value = '1900-01-01' ].
	dateInput stepUp: 2.
	self assert: [ dateInput value = '1900-01-03' ].
	dateInput stepDown: 1; stepDown: 1.
	self assert: [ dateInput value = '1900-01-01' ].

	pickButton := Document default getElementById: 'dateInputPickButton'.
	self assert: [ pickButton type = 'button' ].
	pickButton addEventListener: 'click' then: [ dateInput showPicker ].

	outputLabel := Document default getElementById: 'dateInputOutputLabel'.
	self assert: [ outputLabel class = HtmlLabelElement ].

	outputButton := Document default getElementById: 'dateInputOutputButton'.
	self assert: [ outputButton type = 'button' ].
	outputButton addEventListener: 'click' then: [ outputLabel textContent: dateInput value ].
!
