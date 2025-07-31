CLASS TestFormData EXTENDS Test MODULE Core CLASSVARS '' VARS ''

test
	| formData |

	formData := FormData new.
	self assert: [ formData class = FormData ].

	formData append: 'name' value: 'Alice'.
	formData append: 'address' value: 'Church st'.

	self assert: [ formData has: 'name' ].
	self assert: [ ( formData has: 'xname' ) not ].

	self assert: [ formData keys = #( 'name' 'address') ].
	self assert: [ formData values = #( 'Alice' 'Church st') ].
	self assert: [ formData entries = #( #( 'name' 'Alice' ) #( 'address' 'Church st') ) ].

	formData append: 'name' value: 'Bob'.
	self assert: [ ( formData get: 'name' ) = 'Alice' ].
	self assert: [ ( formData getAll: 'name' ) = #( 'Alice' 'Bob' ) ].

	formData set: 'address' value: 'Penny ln'.
	self assert: [ ( formData get: 'address' ) = 'Penny ln' ].

	formData delete: 'address'.
	self assert: [ formData keys = #( 'name' 'name' ) ].
!
testBlob
	| formData blob blob2 |

	formData := FormData new.
	blob := Blob fromArray: ( Uint8Array from: #( 4 5 6 7 ) ).
	formData append: 'blob' value: blob.
	blob2 := formData get: 'blob'.
	self assert: [ blob2 size = 4 ]
!

"TODO: Test creation with HtmlFormElement in Browser tests."
