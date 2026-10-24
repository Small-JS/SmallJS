CLASS DomImplementation EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class DOMImplementation."

METHODS

createDocumentType: name publicId: publicId systemId: systemId
	^ DocumentType fromJs: INLINE 'this.js.createDocumentType( name.js, publicId.js, systemId.js )'.
!
createHtmlDocument
	^ Document fromJs: INLINE 'this.js.createHTMLDocument()'.
!
