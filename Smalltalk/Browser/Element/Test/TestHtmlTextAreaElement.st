CLASS TestHtmlTextAreaElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| textArea defaultValue |
	textArea := Document default getElementById: 'textArea'.
	self assert: [ textArea class = HtmlTextAreaElement ].
	defaultValue := 'aa\nbb'.

	"Auto capitalization does not seem to work in Edge 107."
	self assert: [ textArea autocapitalize = 'none' ].
	textArea autocapitalize: 'words'.
	self assert: [ textArea autocapitalize = 'words' ].
	textArea autocapitalize: 'none'.

	self assert: [ textArea autofocus not ].
	textArea autofocus: true.
	self assert: [ textArea autofocus ].
	textArea autofocus: false.

	self assert: [ textArea cols = 20 ].
	textArea cols: 30.
	self assert: [ textArea cols = 30 ].
	textArea cols: 20.

	self assert: [ textArea rows = 2 ].
	textArea rows: 3.
	self assert: [ textArea rows = 3 ].
	textArea rows: 2.

	self assert: [ textArea defaultValue = defaultValue ].
	textArea defaultValue: 'zz'.
	self assert: [ textArea defaultValue = 'zz' ].
	textArea defaultValue: defaultValue.

	self assert: [ textArea disabled not ].
	textArea disabled: true.
	self assert: [ textArea disabled ].
	textArea disabled: false.

	self assert: [ textArea form isNil ].

	self assert: [ textArea minLength = 1 ].
	textArea minLength: 4.
	self assert: [ textArea minLength = 4 ].
	textArea minLength: 1.

	self assert: [ textArea maxLength = 100 ].
	textArea maxLength: 98.
	self assert: [ textArea maxLength = 98 ].
	textArea maxLength: 100.

	self assert: [ textArea name = 'textAreaName' ].
	textArea name: 'newName'.
	self assert: [ textArea name = 'newName' ].
	textArea name: 'textAreaName'.

	self assert: [ textArea placeholder = 'Enter text here.' ].
	textArea placeholder: 'New hint.'.
	self assert: [ textArea placeholder = 'New hint.' ].
	textArea placeholder: 'Enter text here.'.

	self assert: [ textArea readOnly not ].
	textArea readOnly: true.
	self assert: [ textArea readOnly ].
	textArea readOnly: false.

	self assert: [ textArea required not ].
	textArea required: true.
	self assert: [ textArea required ].
	textArea required: false.

	self assert: [ textArea selectionDirection = 'forward' ].
	textArea selectionDirection: 'backward'.
	self assert: [ textArea selectionDirection = 'backward' ].
	textArea selectionDirection: 'forward'.

	textArea select.
	self assert: [ textArea selectionStart = 0 ].
	textArea selectionStart: 3.
	self assert: [ textArea selectionStart = 3 ].
	textArea selectionStart: 0.

	self assert: [ textArea selectionEnd = textArea value length ].
	textArea selectionEnd: 4.
	self assert: [ textArea selectionEnd = 4 ].
	textArea selectionEnd: 0.

	textArea setSelectionRange: 1 to: 3.
	self assert: [ textArea selectionStart = 1 ].
	self assert: [ textArea selectionEnd = 3 ].

	self assert: [ textArea textLength = 5 ].
	self assert: [ textArea validationMessage = '' ].
	self assert: [ textArea validity class = ValidityState ].
	self assert: [ textArea willValidate ].
	self assert: [ textArea checkValidity ].
	self assert: [ textArea reportValidity ].

	textArea setCustomValidity: 'Custom error'.
	self assert: [ textArea checkValidity not ].
	textArea setCustomValidity: ''.
	self assert: [ textArea checkValidity ].

	self assert: [ textArea value = defaultValue ].
	textArea value: 'yy'.
	self assert: [ textArea value = 'yy' ].
	textArea value: defaultValue.

	textArea setRangeText: 'N' start: 2 end: 3.
	self assert: [ textArea value = 'aaNbb' ].
	textArea value: defaultValue.

	self assert: [ textArea wrap = 'soft' ].
	textArea wrap: 'hard'.
	self assert: [ textArea wrap = 'hard' ].
	textArea wrap: 'soft'.

	self assert: [ textArea labels length = 0 ].
!
