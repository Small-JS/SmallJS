CLASS TestHtmlInputElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Form related properties are tested in TestHtmlFormElement."

test
	| input |
	input := Document new createElement: 'input'.

	input name: 'inputName'.
	self assert: [ input name = 'inputName' ].

	self assert: [ input type = 'text' ].
	input type: 'button'.
	self assert: [ input type = 'button' ].
	input type: 'text'.

	self assert: [ input disabled not ].
	input disabled: true.
	self assert: [ input disabled ].

	self assert: [ input autofocus not ].
	input autofocus: true.
	self assert: [ input autofocus ].

	self assert: [ input value = '' ].
	input value: 'New input'.
	self assert: [ input value = 'New input' ].
	input setRangeText: ' inserted ' start: 3 end: 4 selectMode: 'select'.
	self assert: [ input value = 'New inserted input' ].

	self assert: [ input autocomplete= '' ].
	input autocomplete: 'on'.
	self assert: [ input autocomplete= 'on' ].

	self assert: [ input readOnly not ].
	input readOnly: true.
	self assert: [ input readOnly ].

	self assert: [ #( 'forward' 'none' ) includes: input selectionDirection ].
	input selectionDirection: 'backward'.
	self assert: [ input selectionDirection = 'backward' ].
	input selectionDirection: 'forward'.

	self assert: [ input size = 20 ].
	input size: 30.
	self assert: [ input size = 30 ].
	input size: 20.
!
testValidation
	| input |
	input := Document new createElement: 'input'.

	self assert: [ input validity ].
	self assert: [ input validationMessage = '' ].
	self assert: [ input willValidate ].
	self assert: [ input checkValidity ].
	self assert: [ input reportValidity ].

	input setCustomValidity: ''.
!
testSelection
	| input |
	input := Document new createElement: 'input'.

	input value: 'My value'.

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
!
testCheckboxInput
	| checkboxInput |
	checkboxInput := Document new createElement: 'input'.
	checkboxInput type: 'checkbox'.

	self assert: [ checkboxInput type = 'checkbox' ].
	self assert: [ checkboxInput checked not ].
	checkboxInput checked: true.
	self assert: [ checkboxInput checked ].
	checkboxInput checked: false.
!
testRadioInput
	| radioInput |
	radioInput := Document new createElement: 'input'.
	radioInput type: 'radio'; name: 'radioSelect'; value: 'radio'.

	self assert: [ radioInput type = 'radio' ].
	self assert: [ radioInput checked not ].
	radioInput checked: true.
	self assert: [ radioInput checked ].

	self assert: [ radioInput defaultChecked not ].
	radioInput defaultChecked: true.
	self assert: [ radioInput defaultChecked ].

	self assert: [ radioInput indeterminate not ].
!
testImageInput
	| imageInput |
	imageInput := Document new createElement: 'input'.
	imageInput type: 'image'.

	self assert: [ imageInput type = 'image' ].

	self assert: [ imageInput src = '' ].
	imageInput src: 'Missing.jpg'.
	self assert: [ imageInput src endsWith: 'Missing.jpg' ].

	self assert: [ imageInput alt = '' ].
	imageInput alt: 'SmallJS2'.
	self assert: [ imageInput alt = 'SmallJS2' ].

	self assert: [ imageInput imageSize = ( 0 @ 0 ) ].
	imageInput imageSize: ( 64 @ 32 ).
	self assert: [ imageInput imageSize = ( 64 @ 32 ) ].
!
testFileInput
	| fileInput |
	fileInput := Document new createElement: 'input'.
	fileInput type: 'file'.

	self assert: [ fileInput type = 'file' ].

	self assert: [ fileInput accept = '' ].
	fileInput accept: 'image/png'.
	self assert: [ fileInput accept = 'image/png' ].

	self assert: [ fileInput files = #( ) ].
!
testNumber
	| numberInput |

	numberInput := Document new createElement: 'input'.

	self assert: [ numberInput min = '' ].
	numberInput min: '1'.
	self assert: [ numberInput min = '1' ].

	self assert: [ numberInput max = '' ].
	numberInput max: '99'.
	self assert: [ numberInput max = '99' ].

	self assert: [ numberInput minLength = -1 ].
	numberInput minLength: 1.
	self assert: [ numberInput minLength = 1 ].

	self assert: [ numberInput maxLength = -1 ].
	numberInput maxLength: 2.
	self assert: [ numberInput maxLength = 2 ].

	self assert: [ numberInput pattern = '' ].
	numberInput pattern: '[0-9]*'.
	self assert: [ numberInput pattern = '[0-9]*' ].

	self assert: [ numberInput placeholder = '' ].
	numberInput placeholder: 'Alt text'.
	self assert: [ numberInput placeholder = 'Alt text' ].
!
testDateInput
	| dateInput |
	dateInput := Document new createElement: 'input'.
	dateInput type: 'date'.

	self assert: [ dateInput type = 'date' ].

	dateInput value: '1900-01-01'.
	self assert: [ dateInput value = '1900-01-01' ].
	self assert: [ dateInput valueAsDate year = 1900 ].
	self assert: [ dateInput valueAsNumber = -2208988800000 ].

	dateInput stepUp: 2.
	self assert: [ dateInput value = '1900-01-03' ].
	dateInput stepDown: 1.
	self assert: [ dateInput value = '1900-01-02' ].
!
