CLASS TestFormData EXTENDS Test MODULE Core CLASSVARS '' VARS ''

"Note: Creating FormData from an HtmlFormElement is tested in the Browser tests: TestHtmlFormElement."

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
testEmpty
	| formData |

	formData := FormData new.
	self assert: [ formData keys = #() ].
	self assert: [ formData values = #() ].
	self assert: [ formData entries = #() ].
	self assert: [ ( formData has: 'name' ) not ].
	self assert: [ ( formData get: 'name' ) isNil ].
	self assert: [ ( formData getAll: 'name' ) = #() ].

	"Deleting a missing name does nothing."
	formData delete: 'name'.
	self assert: [ formData keys = #() ].
!
testSet
	| formData |

	formData := FormData new.

	"Set adds the name if it does not exist yet."
	formData set: 'name' value: 'Alice'.
	self assert: [ formData keys = #( 'name' ) ].
	self assert: [ ( formData get: 'name' ) = 'Alice' ].

	"Set replaces all values with the same name by one value, at the position of the first one."
	formData append: 'address' value: 'Church st'.
	formData append: 'name' value: 'Bob'.
	self assert: [ ( formData getAll: 'name' ) = #( 'Alice' 'Bob' ) ].
	formData set: 'name' value: 'Carol'.
	self assert: [ ( formData getAll: 'name' ) = #( 'Carol' ) ].
	self assert: [ formData keys = #( 'name' 'address' ) ].
!
testDelete
	| formData |

	formData := FormData new.
	formData append: 'name' value: 'Alice'.
	formData append: 'address' value: 'Church st'.
	formData append: 'name' value: 'Bob'.

	"Delete removes all values with the name."
	formData delete: 'name'.
	self assert: [ ( formData has: 'name' ) not ].
	self assert: [ ( formData get: 'name' ) isNil ].
	self assert: [ ( formData getAll: 'name' ) = #() ].
	self assert: [ formData entries = #( #( 'address' 'Church st' ) ) ].
!
testConversion
	| formData |

	"Values that are not a Blob are converted to strings."
	formData := FormData new.
	formData append: 'integer' value: 42.
	formData append: 'float' value: 1.5.
	formData append: 'boolean' value: true.
	formData append: 'empty' value: ''.
	self assert: [ ( formData get: 'integer' ) = '42' ].
	self assert: [ ( formData get: 'float' ) = '1.5' ].
	self assert: [ ( formData get: 'boolean' ) = 'true' ].
	self assert: [ ( formData get: 'empty' ) = '' ].
	self assert: [ ( formData get: 'integer' ) class = String ].

	"Names are case sensitive."
	self assert: [ ( formData has: 'Integer' ) not ].
!
testBlob
	| formData blob blob2 |

	formData := FormData new.
	blob := Blob fromArray: ( Uint8Array from: #( 4 5 6 7 ) ).
	formData append: 'blob' value: blob.
	blob2 := formData get: 'blob'.
	self assert: [ blob2 size = 4 ].

	"A Blob is stored as a File with the default name 'blob'."
	self assert: [ blob2 class = File ].
	self assert: [ blob2 name = 'blob' ].
	self assert: [ blob2 type = '' ].

	"Strings and Files can be mixed."
	formData append: 'blob' value: 'text'.
	self assert: [ ( formData getAll: 'blob' ) length = 2 ].
	self assert: [ ( formData getAll: 'blob' ) first class = File ].
	self assert: [ ( formData getAll: 'blob' ) last = 'text' ].
	self assert: [ formData values first class = File ].
	self assert: [ ( formData entries first at: 1 ) class = File ].
	self assert: [ ( formData entries last at: 1 ) = 'text' ].
!
