CLASS TestHeaders EXTENDS Test MODULE Core CLASSVARS '' VARS ''

test
	| headers entries |

	headers := Headers new.
	self assert: [ headers class = Headers ].
	self assert: [ headers jsClassName = 'Headers' ].

	entries := #(
  		#( 'set-cookie' 'greeting=hello' )
  		#( 'x-custom-header' 'name=world' ) ).
	headers := Headers init: entries.
	self assert: [ headers entries = entries ].
	self assert: [ headers keys = #( 'set-cookie' 'x-custom-header' ) ].
	self assert: [ headers values = #( 'greeting=hello' 'name=world' ) ].
	self assert: [ headers getSetCookie = #( 'greeting=hello' ) ].

	headers append: 'x-header' value: 'value'.
	self assert: [ ( headers get: 'x-header' ) = 'value' ].

	headers set: 'x-header' value: 'new-value'.
	self assert: [ ( headers get: 'x-header' ) = 'value, new-value' ].

	self assert: [ headers has: 'x-header' ].
	headers delete: 'x-header'.
	self assert: [ ( headers has: 'x-header' ) not ].
!
