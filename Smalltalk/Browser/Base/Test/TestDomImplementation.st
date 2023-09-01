CLASS TestDomImplementation EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

browserOnly
	^ true.
!
testCreateDocumentType
	| documentType |
	documentType := Document default implementation
		createDocumentType: 'svg:svg' publicId: '-//W3C//DTD SVG 1.1//EN' systemId: 'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd'.
	self assert: [ documentType name = 'svg:svg' ].
!
testCreateHtmlDocument
	| document |
	document := Document default implementation createHtmlDocument.
	self assert: [ document class name = 'Document' ].
!
