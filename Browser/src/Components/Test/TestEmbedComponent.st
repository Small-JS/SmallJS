CLASS TestEmbedComponent EXTENDS Test MODULE TestMyBrowserApp CLASSVARS '' VARS ''

test
	| embedComponent embedElement |
	embedComponent := MyBrowserApp default findComponent: EmbedComponent.
	embedElement := embedComponent embedElement.

	self assert: [ embedElement size = ( 300 @ 40 ) ].
	self assert: [ embedElement src endsWith: 'Components/EmbeddedDocument.html' ].
	self assert: [ embedElement type = 'text/html' ].
!
