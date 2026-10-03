CLASS TestElectronMessageBoxOptions EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

testUnset
	| options |

	options := ElectronMessageBoxOptions new.
	self assert: [ options message isNil ].
	self assert: [ options type isNil ].
	self assert: [ options buttons isNil ].
	self assert: [ options defaultId isNil ].
	self assert: [ options cancelId isNil ].
	self assert: [ options signal isNil ].
	self assert: [ options title isNil ].
	self assert: [ options detail isNil ].
	self assert: [ options checkboxLabel isNil ].
	self assert: [ options checkboxChecked isNil ].
	self assert: [ options icon isNil ].
	self assert: [ options normalizeAccessKeys isNil ].
!
testProperties
	| options |

	options := ElectronMessageBoxOptions message: 'Message'.
	self assert: [ options message = 'Message' ].

	options type: 'question'; buttons: #( 'Yes' 'No' ); defaultId: 0; cancelId: 1;
		title: 'Title'; detail: 'Detail'; checkboxLabel: 'Check'; checkboxChecked: true;
		icon: 'icon.png'; normalizeAccessKeys: false.
	self assert: [ options type = 'question' ].
	self assert: [ options buttons = #( 'Yes' 'No' ) ].
	self assert: [ options defaultId = 0 ].
	self assert: [ options cancelId = 1 ].
	self assert: [ options title = 'Title' ].
	self assert: [ options detail = 'Detail' ].
	self assert: [ options checkboxLabel = 'Check' ].
	self assert: [ options checkboxChecked ].
	self assert: [ options icon = 'icon.png' ].
	self assert: [ options normalizeAccessKeys = false ].
!
testSignal
	| options controller |

	controller := AbortController new.
	options := ElectronMessageBoxOptions new.
	options signal: controller signal.
	self assert: [ options signal = controller signal ].
	self assert: [ options signal class = AbortSignal ].
!
