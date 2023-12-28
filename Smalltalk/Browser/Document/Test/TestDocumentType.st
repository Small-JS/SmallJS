CLASS TestDocumentType EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

testDocumentTypeProperties
	| documentType |
	documentType := Document default doctype.
	self assert: [ documentType class = DocumentType ].
	self assert: [ documentType name = 'html' ].
	self assert: [ documentType publicId = '' ].	"HTML5"
	self assert: [ documentType systemId = '' ].	"HTML5"
!
testDocumentTypeMethods
	"Methods before, after and replaceWith place nodes in the document.
	 They seem duplicates of document functionality and not usefull for HTML documents."
!
