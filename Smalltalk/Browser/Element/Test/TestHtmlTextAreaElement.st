CLASS TestHtmlTextAreaElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| textArea |
	textArea := Document new createElement: 'textarea'.
	self assert: [ textArea class = HtmlTextAreaElement ].

	self assert: [ textArea placeholder = '' ].
	textArea placeholder: 'Enter text here'.
	self assert: [ textArea placeholder = 'Enter text here' ].

	self assert: [ textArea value = '' ].
	textArea defaultValue: 'zz'.
	self assert: [ textArea defaultValue = 'zz' ].

	self assert: [ textArea value = 'zz' ].
	textArea value: 'aa\nbb'.
	self assert: [ textArea value = 'aa\nbb' ].

	self assert: [ textArea autocapitalize = '' ].
	textArea autocapitalize: 'none'.
	self assert: [ textArea autocapitalize = 'none' ].

	self assert: [ textArea autofocus not ].
	textArea autofocus: true.
	self assert: [ textArea autofocus ].

	self assert: [ textArea cols = 20 ].
	textArea cols: 30.
	self assert: [ textArea cols = 30 ].

	self assert: [ textArea rows = 2 ].
	textArea rows: 3.
	self assert: [ textArea rows = 3 ].

	self assert: [ textArea disabled not ].
	textArea disabled: true.
	self assert: [ textArea disabled ].

	self assert: [ textArea form isNil ].

	self assert: [ textArea minLength = -1 ].
	textArea minLength: 4.
	self assert: [ textArea minLength = 4 ].

	self assert: [ textArea maxLength = -1 ].
	textArea maxLength: 98.
	self assert: [ textArea maxLength = 98 ].

	self assert: [ textArea readOnly not ].
	textArea readOnly: true.
	self assert: [ textArea readOnly ].

	self assert: [ textArea required not ].
	textArea required: true.
	self assert: [ textArea required ].

	textArea select.
	self assert: [ textArea selectionStart = 0 ].
	textArea selectionStart: 3.
	self assert: [ textArea selectionStart = 3 ].

	self assert: [ textArea selectionEnd = 5 ].
	textArea selectionEnd: 4.
	self assert: [ textArea selectionEnd = 4 ].

	textArea setSelectionRange: 1 to: 3.
	self assert: [ textArea selectionStart = 1 ].
	self assert: [ textArea selectionEnd = 3 ].

	self assert: [ #( 'forward' 'none' ) includes: textArea selectionDirection ].
	textArea selectionDirection: 'backward'.
	self assert: [ textArea selectionDirection = 'backward' ].

	self assert: [ textArea textLength = 5 ].
	self assert: [ textArea validationMessage = '' ].
	self assert: [ textArea validity class = ValidityState ].
	self assert: [ textArea willValidate not ].
	self assert: [ textArea reportValidity ].

	self assert: [ textArea checkValidity ].
	textArea setCustomValidity: 'Custom error'.
	self assert: [ textArea checkValidity ].
	textArea setCustomValidity: ''.
	self assert: [ textArea checkValidity ].

	textArea setRangeText: 'AA' start: 0 end: 2.
	self assert: [ textArea value = 'AA\nbb' ].

	self assert: [ textArea wrap = '' ].
	textArea wrap: 'soft'.
	self assert: [ textArea wrap = 'soft' ].

	self assert: [ textArea labels length = 0 ].
!
