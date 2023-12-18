CLASS Document EXTENDS Node MODULE DOM CLASSVARS '' VARS ''
	"This class encasulates JS HTML 'document' and HTML5 'HTMLDocument' classes."

CLASSMETHODS

new
	^ self fromJs: INLINE 'document.implementation.createHTMLDocument()'.
!
default
	^ self fromJs: INLINE 'document'.
!
getElementById: id
	"Convenience method because it's used often."

	^ self default getElementById: id.
!
METHODS

"Properties."

activeElement
	^ HtmlElement fromJsSubElement: INLINE 'this.js.activeElement'.
!
body
	^ HtmlBodyElement fromJs: INLINE 'this.js.body'.
!
body: body
	INLINE 'this.js.body = body.js'.
!
characterSet
	^ String fromJs: INLINE 'this.js.characterSet'.
!
childElementCount
	^ Integer fromJs: INLINE 'this.js.childElementCount'.
!
children
	^ Array fromJs: INLINE 'this.js.children' elementConverter:
		[ :element | Element fromJsSubElement: element ]
!
contentType
	^ String fromJs: INLINE 'this.js.contentType'.
!
doctype
	^ DocumentType fromJs: INLINE 'this.js.doctype'.
!
documentElement
	^ Element fromJsSubElement: INLINE 'this.js.documentElement'.
!
documentUri
	^ String fromJs: INLINE 'this.js.documentURI'.
!
embeds
	^ Element fromJsSubElements: INLINE 'this.js.embeds'.
!
firstElementChild
	^ Element fromJsSubElement: INLINE 'this.js.firstElementChild'.
!
lastElementChild
	^ Element fromJsSubElement: INLINE 'this.js.lastElementChild'.
!
forms
	^ Array fromJs: INLINE 'this.js.embeds' elementClass: HtmlFormElement.
!
fullscreenElement
	^ Element fromJsSubElement: INLINE 'this.js.fullscreenElement'.
!
head
	^ HtmlHeadElement fromJs: INLINE 'this.js.head'.
!
hasFocus
	^ Boolean fromJs: INLINE 'this.js.hasFocus()'.
!
hidden
	^ Boolean fromJs: INLINE 'this.js.hidden'.
!
images
	^ Array fromJs: INLINE 'this.js.images' elementClass: HtmlImageElement.
!
implementation
	^ DomImplementation fromJs: INLINE 'this.js.implementation'.
!
links
	^ Array fromJs: INLINE 'this.js.links' elementClass: HtmlLinkElement.
!
plugins
	^ Array fromJs: INLINE 'this.js.plugins' elementClass: HtmlEmbedElement.
!
pointerLockElement
	^ Element fromJsSubElement: INLINE 'this.js.pointerLockElement'.
!
scripts
	^ Array fromJs: INLINE 'this.js.scripts' elementClass: HtmlScriptElement.
!
styleSheets
	^ Array fromJs: INLINE 'this.js.styleSheets' elementClass: CssStyleSheet.
!
visibilityState
	^ String fromJs: INLINE 'this.js.visibilityState'.
!

"HTMLDocument properties."

cookie
	^ String fromJs: INLINE 'this.js.cookie'.
!
cookie: cookie
	INLINE 'this.js.cookie = cookie.js'.
!
defaultView
	^ Window fromJs: INLINE 'this.js.defaultView'.
!
designMode
	^ String fromJs: INLINE 'this.js.designMode'.
!
designMode: designMode
	INLINE 'this.js.designMode = designMode.js'.
!
dir
	^ String fromJs: INLINE 'this.js.dir'.
!
dir: dir
	INLINE 'this.js.dir = dir.js'.
!
lastModified
	^ String fromJs: INLINE 'this.js.lastModified'.
!
location
	^ Location fromJs: INLINE 'this.js.location'.
!
readyState
	^ String fromJs: INLINE 'this.js.readyState'.
!
referrer
	^ String fromJs: INLINE 'this.js.referrer'.
!
title
	^ String fromJs: INLINE 'this.js.title'.
!
title: title
	INLINE 'this.js.title = title.js'.
!
url
	^ String fromJs: INLINE 'this.js.URL'.
!

"Methods."

adoptNode: node
	^ Node fromJsSubNode: INLINE 'this.js.adoptNode( node.js )'.
!
append: node
	^ Node fromJs: INLINE 'this.js.append( node.js )'.
!
createAttribute: name
	^ Attr fromJs: INLINE 'this.js.createAttribute( name.js )'.
!
createComment: data
	^ Comment fromJs: INLINE 'this.js.createComment( data.js )'.
!
createDocumentFragment
	^ DocumentFragment fromJs: INLINE 'this.js.createDocumentFragment()'.
!
createElement: tagName
	^ Element fromJsSubElement: INLINE 'this.js.createElement( tagName.js )'.
!
createRange
	^ Range fromJs: INLINE 'this.js.createRange()'.
!
createTextNode: text
	^ Text fromJs: INLINE 'this.js.createTextNode( text.js )'.
!
elementFromPoint: point
	^ Element fromJsSubElement: INLINE 'this.js.elementFromPoint( point.x.js, point.y.js )'.
!
elementsFromPoint: point
	^ Element fromJsSubElements: INLINE 'this.js.elementsFromPoint( point.x.js, point.y.js )'.
!
getElementById: id
	^ Element fromJsSubElement: INLINE 'this.js.getElementById( id.js )'.
!
getElementsByClassName: className
	^ Element fromJsSubElements: INLINE 'this.js.getElementsByClassName( className.js )'.
!
getElementsByTagName: tagName
	^ Element fromJsSubElements: INLINE 'this.js.getElementsByTagName( tagName.js )'.
!
getSelection
	^ Selection fromJs: INLINE 'this.js.getSelection()'.
!
importNode: node deep: deep
	^ Node fromJsSubNode: INLINE 'this.js.importNode( node.js, deep.js )'.
!
prepend: node
	^ Node fromJs: INLINE 'this.js.prepend( node.js )'.
!
querySelector: selector
	^ Element fromJsSubElement: INLINE 'this.js.querySelector( selector.js )'.
!
querySelectorAll: selector
	^ Element fromJsSubElements: INLINE 'this.js.querySelectorAll( selector.js )'.
!
replaceChildren: elements
	INLINE 'this.js.replaceChildren( elements.$toJs() )'.
!

"Exension for HTML documents."

close
	INLINE 'this.js.close()'.
!
getElementsByName: name
	^ Element fromJsSubElements: INLINE 'this.js.getElementsByName( name.js )'.
!
open
	INLINE 'this.js.open()'.
!
write: html
	INLINE 'this.js.write( html.js )'.
!
writeln: html
	INLINE 'this.js.writeln( html.js )'.
!
