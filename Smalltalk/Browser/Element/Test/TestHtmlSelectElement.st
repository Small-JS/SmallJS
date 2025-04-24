CLASS TestHtmlSelectElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| select option v |
	select := Document new createElement: 'select'.

	self assert: [ select name = '' ].
	select name: 'selectName'.
	self assert: [ select name = 'selectName' ].

	self assert: [ select type = 'select-one' ].

	self assert: [ select length = 0 ].
	select length: 1.
	self assert: [ select length = 1 ].

	self assert: [ select selectedIndex = 0 ].
	select selectedIndex: -1.
	self assert: [ select selectedIndex = -1 ].

	"Options"

	select length: 0.
	option := Document new createElement: 'option'.
	option id: 'optionId'.
	option value: 'optionValue'.
	select add: option.
	self assert: [ select options length = 1 ].
	self assert: [ select options first id = 'optionId' ].
	self assert: [ select options first = option ].

	self assert: [ ( select item: 0 ) = option ].
	self assert: [ ( select namedItem: 'optionId' ) = option ].

	"Modifying"

	select remove: 0.
	self assert: [ select options length = 0 ].

	"Settings"

	self assert: [ select autocomplete = '' ].
	select autocomplete: 'on'.
	self assert: [ select autocomplete = 'on' ].

	self assert: [ select disabled not ].
	select disabled: true.
	self assert: [ select disabled ].

	self assert: [ select multiple not ].
	select multiple: true.
	self assert: [ select multiple ].

	self assert: [ select required not ].
	select required: true.
	self assert: [ select required ].

	self assert: [ select form isNil ].

	self assert: [ select labels length = 0 ].

	"Validating"

	self assert: [ select validationMessage = '' ].
	self assert: [ select validity valueMissing ].
	self assert: [ select willValidate not ].
	self assert: [ select checkValidity ].
	self assert: [ select reportValidity ].
	select setCustomValidity: 'myError'.
	self assert: [ select validity customError ].
!
