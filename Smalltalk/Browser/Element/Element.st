CLASS Element EXTENDS Node MODULE Browser CLASSVARS '' VARS ''

CLASSMETHODS

new
	self error: 'Element is an abstract class that cannot be instantiated. Use Document.createElement: .'
!
fromJsSubElement: jsElement
	"Create ST HTML Element object from JS HTML element object.
	 Throw error if unknown element."

	| jsClassName localName |

	INLINE 'if( jsElement == null ) return stNil'.

	jsClassName := String fromJs: INLINE 'jsElement.constructor.name'.

	"Workaround for this Firefox bug: https://bugzilla.mozilla.org/show_bug.cgi?id=843881"
	Window isFirefox ifTrue: [
		localName := ( JsObject fromJs: jsElement ) atJsProperty: 'localName'.
		localName = 'image' ifTrue: [ jsClassName := 'HTMLImageElement' ] ].

	jsClassName = 'HTMLAnchorElement' ifTrue: [ ^ HtmlAnchorElement fromJs: jsElement ].
	jsClassName = 'HTMLButtonElement' ifTrue: [ ^ HtmlButtonElement fromJs: jsElement ].
	jsClassName = 'HTMLFormElement' ifTrue: [ ^ HtmlFormElement fromJs: jsElement ].
	jsClassName = 'HTMLInputElement' ifTrue: [ ^ HtmlInputElement fromJs: jsElement ].
	jsClassName = 'HTMLLabelElement' ifTrue: [ ^ HtmlLabelElement fromJs: jsElement ].
	jsClassName = 'HTMLTextAreaElement' ifTrue: [ ^ HtmlTextAreaElement fromJs: jsElement ].
	jsClassName = 'HTMLSpanElement' ifTrue: [ ^ HtmlSpanElement fromJs: jsElement ].
	jsClassName = 'HTMLBodyElement' ifTrue: [ ^ HtmlBodyElement fromJs: jsElement ].
	jsClassName = 'HTMLHtmlElement' ifTrue: [ ^ HtmlHtmlElement fromJs: jsElement ].
	jsClassName = 'HTMLParagraphElement' ifTrue: [ ^ HtmlParagraphElement fromJs: jsElement ].
	jsClassName = 'HTMLImageElement' ifTrue: [ ^ HtmlImageElement fromJs: jsElement ].
	jsClassName = 'HTMLTableElement' ifTrue: [ ^ HtmlTableElement fromJs: jsElement ].
	jsClassName = 'HTMLTableCellElement' ifTrue: [ ^ HtmlTableCellElement fromJs: jsElement ].
	jsClassName = 'HTMLTableRowElement' ifTrue: [ ^ HtmlTableRowElement fromJs: jsElement ].
	jsClassName = 'HTMLDivElement' ifTrue: [ ^ HtmlDivElement fromJs: jsElement ].
	jsClassName = 'HTMLScriptElement' ifTrue: [ ^ HtmlScriptElement fromJs: jsElement ].
	jsClassName = 'HTMLSlotElement' ifTrue: [ ^ HtmlSlotElement fromJs: jsElement ].
	jsClassName = 'HTMLFieldSetElement' ifTrue: [ ^ HtmlFieldSetElement fromJs: jsElement ].
	jsClassName = 'HTMLMetaElement' ifTrue: [ ^ HtmlMetaElement fromJs: jsElement ].
	jsClassName = 'HTMLLinkElement' ifTrue: [ ^ HtmlLinkElement fromJs: jsElement ].
	jsClassName = 'HTMLTitleElement' ifTrue: [ ^ HtmlTitleElement fromJs: jsElement ].
	jsClassName = 'HTMLBRElement' ifTrue: [ ^ HtmlBrElement fromJs: jsElement ].
	jsClassName = 'HTMLEmbedElement' ifTrue: [ ^ HtmlEmbedElement fromJs: jsElement ].
	jsClassName = 'HTMLIFrameElement' ifTrue: [ ^ HtmlIframeElement fromJs: jsElement ].
	jsClassName = 'HTMLHeadElement' ifTrue: [ ^ HtmlHeadElement fromJs: jsElement ].
	jsClassName = 'HTMLUnknownElement' ifTrue: [ ^ HtmlUnknownElement fromJs: jsElement ].
	jsClassName = 'HTMLTemplateElement' ifTrue: [ ^ HtmlTemplateElement fromJs: jsElement ].

	jsClassName = 'HTMLTableElement' ifTrue: [ ^ HtmlTableElement fromJs: jsElement ].
	jsClassName = 'HTMLTableCaptionElement' ifTrue: [ ^ HtmlTableCaptionElement fromJs: jsElement ].
	jsClassName = 'HTMLTableCellElement' ifTrue: [ ^ HtmlTableCellElement fromJs: jsElement ].
	jsClassName = 'HTMLTableRowElement' ifTrue: [ ^ HtmlTableRowElement fromJs: jsElement ].
	jsClassName = 'HTMLTableSectionElement' ifTrue: [ ^ HtmlTableSectionElement fromJs: jsElement ].

	jsClassName = 'HTMLDataListElement' ifTrue: [ ^ HtmlDataListElement fromJs: jsElement ].
	jsClassName = 'HTMLOptionElement' ifTrue: [ ^ HtmlOptionElement fromJs: jsElement ].

	jsClassName = 'HTMLCanvasElement' ifTrue: [ ^ HtmlCanvasElement fromJs: jsElement ].

	^ self error: 'Element.fromJsSubElement: Unknown JS element class: ', jsClassName.
!
fromJsSubElements: jsArray
	^ Array fromJs: jsArray elementConverter:
		[ :jsHtmlElement | Element fromJsSubElement: jsHtmlElement ].
!

METHODS

"Properties."

assignedSlot
	^ HtmlSlotElement fromJs: INLINE 'this.js.assignedSlot'.
!
attributes
	^ NamedNodeMap fromJs: INLINE 'this.js.attributes'.
!
childElementCount
	^ Integer fromJs: INLINE 'this.js.childElementCount'.
!
children
	^ Array fromJs: INLINE 'this.js.children' elementConverter:
		[ :element | Element fromJsSubElement: element ].
!
classList
	^ DomTokenList fromJs: INLINE 'this.js.classList'.
!
className
	^ String fromJs: INLINE 'this.js.className'.
!
className: className
	INLINE 'this.js.className = className.js'.
!
clientHeight
	^ Integer fromJs: INLINE 'this.js.clientHeight'.
!
clientLeft
	^ Integer fromJs: INLINE 'this.js.clientLeft'.
!
clientTop
	^ Integer fromJs: INLINE 'this.js.clientTop'.
!
clientWidth
	^ Integer fromJs: INLINE 'this.js.clientWidth'.
!
firstElementChild
	^ Element fromJsSubElement: INLINE 'this.js.firstElementChild'.
!
id
	^ String fromJs: INLINE 'this.js.id'.
!
id: id
	INLINE 'this.js.id = id.js'.
!
name
	^ self getAttribute: 'name'.
!
innerHtml
	^ String fromJs: INLINE 'this.js.innerHTML'.
!
innerHtml: html
	INLINE 'this.js.innerHTML = html.js'.
!
lastElementChild
	^ Element fromJsSubElement: INLINE 'this.js.lastElementChild'.
!
localName
	^ String fromJs: INLINE 'this.js.localName'.
!
namespaceUri
	^ String fromJs: INLINE 'this.js.namespaceURI'.
!
nextElementSibling
	^ Element fromJsSubElement: INLINE 'this.js.nextElementSibling'.
!
outerHtml
	^ String fromJs: INLINE 'this.js.outerHTML'.
!
part
	^ DomTokenList fromJs: INLINE 'this.js.part'.
!
prefix
	^ String fromJs: INLINE 'this.js.prefix'.
!
previousElementSibling
	^ Element fromJsSubElement: INLINE 'this.js.previousElementSibling'.
!
scrollHeight
	^ Integer fromJs: INLINE 'this.js.scrollHeight'.
!
scrollLeft
	^ Integer fromJs: INLINE 'this.js.scrollLeft'.
!
scrollTop
	^ Integer fromJs: INLINE 'this.js.scrollTop'.
!
scrollWidth
	^ Integer fromJs: INLINE 'this.js.scrollWidth'.
!
shadowRoot
	^ ShadowRoot fromJs: INLINE 'this.js.shadowRoot'.
!
slot
	^ String fromJs: INLINE 'this.js.slot'.
!
tagName
	^ String fromJs: INLINE 'this.js.tagName'.
!

"Methods."

after: node
	INLINE 'this.js.after( node.js )'.
!
attachShadow: aMode delegatesFocus: aDelegatesFocus
	INLINE 'let options = { mode: aMode.js, delegatesFocus: aDelegatesFocus.js }'.
	^ ShadowRoot fromJs: INLINE 'this.js.attachShadow( options )'.
!
append: node
	INLINE 'this.js.append( node.js )'.
!
before: node
	INLINE 'this.js.before( node.js )'.
!
closest: selector
	^ Element fromJsSubElement: INLINE 'this.js.closest( selector.js )'.
!
dispatchEvent: event
	INLINE 'this.js.dispatchEvent( event.js )'.
!
getAttribute: name
	^ String fromJs: INLINE 'this.js.getAttribute( name.js )'.
!
getAttributeNames
	^ Array fromJsStrings: INLINE 'this.js.getAttributeNames()'.
!
getAttributeNode: name
	^ Attr fromJs: INLINE 'this.js.getAttributeNode( name.js )'.
!
getBoundingClientRect
	^ Rectangle fromJs: INLINE 'this.js.getBoundingClientRect()'.
!
getClientRects
	^ Array fromJs: INLINE 'this.js.getClientRects()' elementClass: Rectangle.
!
getElementsByClassName: name
	^ Array fromJs: INLINE 'this.js.getElementsByClassName( name.js )' elementConverter:
		[ :jsElement | Element fromJsSubElement: jsElement ].
!
getElementsByTagName: name
	^ Array fromJs: INLINE 'this.js.getElementsByTagName( name.js )' elementConverter:
		[ :jsElement | Element fromJsSubElement: jsElement ].
!
hasAttribute: name
	^ Boolean fromJs: INLINE 'this.js.hasAttribute( name.js )'.
!
hasAttributes
	^ Boolean fromJs: INLINE 'this.js.hasAttributes()'.
!
hasPointerCapture: pointerId
	^ Boolean fromJs: INLINE 'this.js.hasPointerCapture( pointerId.js )'.
!
insertAdjacentElement: element position: position
	INLINE 'this.js.insertAdjacentElement( position.js, element.js )'.
!
insertAdjacentHtml: html position: position
	INLINE 'this.js.insertAdjacentHTML( position.js, html.js )'.
!
insertAdjacentText: text position: position
	INLINE 'this.js.insertAdjacentText( position.js, text.js )'.
!
matches: selector
	^ Boolean fromJs: INLINE 'this.js.matches( selector.js )'.
!
prepend: node
	INLINE 'this.js.prepend( node.js )'.
!
querySelector: selector
	^ Element fromJsSubElement: INLINE 'this.js.querySelector( selector.js )'.
!
querySelectorAll: selector
	^ Array fromJs: INLINE 'this.js.querySelectorAll( selector.js )' elementConverter:
		[ :jsElement | Element fromJsSubElement: jsElement ].
!
releasePointerCapture: id
	INLINE 'this.js.releasePointerCapture( id.js )'.
!
remove
	INLINE 'this.js.remove()'.
!
removeAttribute: attrName
	INLINE 'this.js.removeAttribute( attrName.js )'.
!
removeAttributeNode: attr
	INLINE 'this.js.removeAttributeNode( attr.js )'.
!
replaceChildren: nodes
	INLINE 'this.js.replaceChildren( nodes.$toJs() )'.
!
replaceWith: node
	INLINE 'this.js.replaceWith( node.js )'.
!
requestFullscreen: block onError: errorBlock navigationUi: navigationUi
	INLINE '
		this.js.requestFullscreen( navigationUi.js )
		.then( block.func() )
		.catch( errorBlock.func() )'.
!
requestPointerLock
	INLINE 'this.js.requestPointerLock()'.
!
scrollTo: point
	INLINE 'this.js.scrollTo( point.x.js, point.y.js )'.
!
scrollTo: point behavior: behavior
	INLINE 'this.js.scrollTo( { top: point.y.js, left: point.x.js, behavior: behavior.js } )'.
!
scrollBy: point
	INLINE 'this.js.scrollBy( point.x.js, point.y.js )'.
!
scrollBy: point behavior: behavior
	INLINE 'this.js.scrollBy( { top: point.y.js, left: point.x.js, behavior: behavior.js } )'.
!
scrollIntoView: alignToTop
	INLINE 'this.js.scrollIntoView( alignToTop.js )'.
!
scrollIntoViewBehavior: behavior block: block inline: inline
	INLINE 'this.js.scrollIntoView( { behavior: behavior.js, block: block.js, inline: inline.js } )'.
!
setAttribute: name value: value
	INLINE 'this.js.setAttribute( name.js, value.js )'.
!
setAttributeNode: attribute
	INLINE 'this.js.setAttributeNode( attribute.js )'.
!
setPointerCapture: pointerId
	INLINE 'this.js.setPointerCapture( pointerId.js )'.
!
toggleAttribute: name
	^ Boolean fromJs: INLINE 'this.js.toggleAttribute( name.js )'.
!
toggleAttribute: name force: force
	^ Boolean fromJs: INLINE 'this.js.toggleAttribute( name.js, force.js )'.
!
