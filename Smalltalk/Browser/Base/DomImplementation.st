CLASS DomImplementation EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS class DomImplementation."

METHODS

createDocumentType: name publicId: publicId systemId: systemId
	^ DocumentType fromJs: INLINE 'this.js.createDocumentType( name.js, publicId.js, systemId.js )'.
!
createHtmlDocument
	^ Document fromJs: INLINE 'this.js.createHTMLDocument()'.
!
