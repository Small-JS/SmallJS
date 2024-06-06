CLASS TestHtmlFieldSetElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

testProperties
	| fieldSet |

	fieldSet := Document default createElement: 'fieldset'.

	self assert: [ fieldSet disabled not ].
	fieldSet disabled: true.
	self assert: [ fieldSet disabled ].

	fieldSet name: 'fieldSetName'.
	self assert: [ fieldSet name = 'fieldSetName' ].
	self assert: [ fieldSet type = 'fieldset' ].
	self assert: [ fieldSet validationMessage isEmpty ].
	self assert: [ fieldSet validity class = ValidityState ].
	self assert: [ fieldSet willValidate not ].
	self assert: [ fieldSet elements isEmpty ].
!
testMethods
	| fieldSet |

	fieldSet := Document default createElement:  'fieldset'.

	self assert: [ fieldSet checkValidity ].
	self assert: [ fieldSet reportValidity ].

	self assert: [ fieldSet validity customError not ].
	fieldSet setCustomValidity: 'My custom validity error message.'.
	self assert: [ fieldSet validity customError ].
	fieldSet setCustomValidity: ''.
!
