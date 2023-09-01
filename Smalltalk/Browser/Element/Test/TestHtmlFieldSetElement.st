CLASS TestHtmlFieldSetElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

browserOnly
	^ true.
!
testProperties
	| fieldSet |

	fieldSet := Document default getElementById: 'fieldSet'.
	self assert: [ fieldSet class = HtmlFieldSetElement ].

	self assert: [ fieldSet disabled not ].
	fieldSet disabled: true.
	self assert: [ fieldSet disabled ].
	fieldSet disabled: false.

	self assert: [ fieldSet name = 'fieldSetName' ].
	self assert: [ fieldSet type = 'fieldset' ].
	self assert: [ fieldSet validationMessage = '' ].
	self assert: [ fieldSet validity class = ValidityState ].
	self assert: [ fieldSet willValidate not ].
	self assert: [ fieldSet elements first class = HtmlInputElement ].
!
testMethods
	| fieldSet |

	fieldSet := Document default getElementById: 'fieldSet'.
	self assert: [ fieldSet class = HtmlFieldSetElement ].

	self assert: [ fieldSet checkValidity ].
	self assert: [ fieldSet reportValidity ].

	self assert: [ fieldSet validity customError not ].
	fieldSet setCustomValidity: 'My custom validity error message.'.
	self assert: [ fieldSet validity customError ].
	fieldSet setCustomValidity: ''.
!
