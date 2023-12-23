CLASS TestElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

testProperties
	| element element2 |

	element := Document getElementById: 'element' class: HtmlParagraphElement.
	self assert: [ element id = 'element' ].
	self assert: [ element assignedSlot = nil ].
	self assert: [ ( element attributes getNamedItem: 'id' ) value = 'element' ].

	self assert: [ element parentNode childElementCount = 2 ].
	self assert: [ element parentNode children first = element ].

	self assert: [ element classList length = 1  ].
	self assert: [ element classList contains: 'elementClass' ].
	self assert: [ element className = 'elementClass' ].

	self assert: [ element clientTop = 0 ].
	self assert: [ element clientLeft = 0 ].
	self assert: [ element clientHeight > 10 ].
	self assert: [ element clientWidth > 100 ].

	self assert: [ element parentNode firstElementChild = element ].
	self assert: [ element parentNode lastElementChild id = 'element2' ].
	self assert: [ element id = 'element' ].
	self assert: [ element innerHtml = 'Element' ].
	self assert: [ element localName = 'p' ].
	self assert: [ element namespaceUri startsWith: 'http' ].
	self assert: [ element outerHtml startsWith: '<p ' ].
	self assert: [ ( element part item: 0 ) = 'elementPart' ].
	self assert: [ element prefix = nil ].

	element2 := element nextElementSibling.
	self assert: [ element2 id = 'element2' ].
	self assert: [ element2 previousElementSibling = element ].

	self assert: [ element scrollTop >= 0 ].
	self assert: [ element scrollLeft >= 0 ].
	self assert: [ element scrollHeight >= 0 ].
	self assert: [ element scrollWidth >= 0 ].

	self assert: [ element shadowRoot = nil ].
	self assert: [ element slot = '' ].
	self assert: [ element tagName = 'P' ].
!
testMethods
	| document element element2 element3 |

	"Method attachShadow: is tested in TestShadowRoot."
	"Todo: Test dispatchEvent: in class Event class"
	"Todo: Test these in class PointerEvents:
		hasPointerCapture, releasePointerCapture, setPointerCapture, requestPointerLock "
	"Todo: Test requestFullscreen:... in interactive mode."

	document := Document default.

	element := document getElementById: 'element' class: HtmlParagraphElement.
	self assert: [ element id = 'element' ].

	element2 := document getElementById: 'element2' class: HtmlParagraphElement.
	self assert: [ element2 id = 'element2' ].

	element3 := ( document createElement: 'p' ) id: 'element3'; textContent: 'Element 3'.
	element2 after: element3.
	self assert: [ element2 nextElementSibling = element3 ].

	element2 before: element3.
	self assert: [ element2 previousElementSibling = element3 ].

	element2 insertAdjacentElement: element3 position: 'afterend'.
	self assert: [ element2 parentNode lastElementChild = element3 ].
	element3 remove.

	element2 insertAdjacentHtml: '<p id="element4">Inserted as HTML.</p>' position: 'afterend'.
	self assert: [ element2 parentNode lastElementChild id = 'element4' ].
	element2 parentNode lastElementChild remove.

	element2 insertAdjacentText: 'Inserted Text node' position: 'afterend'.
	self assert: [ element2 nextSibling textContent = 'Inserted Text node' ].
	element2 nextSibling remove.

	self assert: [ ( element closest: '#elementTesterTable' ) class = HtmlTableElement ].
	self assert: [ ( element getAttribute: 'id' ) = 'element' ].
	self assert: [ element getAttributeNames first = 'id' ].
	self assert: [ ( element getAttributeNode: 'id' ) value = 'element' ].
	self assert: [ element hasAttribute: 'id' ].
	self assert: [ element hasAttributes ].
	self assert: [ element matches: '#element' ].

	self assert: [ element getBoundingClientRect class = Rectangle ].
	self assert: [ element getClientRects first class = Rectangle ].

	self assert: [ ( element parentNode getElementsByClassName: 'elementClass' ) first = element ].
	self assert: [ ( element parentNode getElementsByTagName: 'p' ) first = element ].
!
testMethods2
	| document element paragraph text div elements attr |

	document := Document default.
	element := document getElementById: 'element' class: HtmlParagraphElement.

	div := document createElement: 'div'.
	paragraph := ( document createElement: 'p' ) textContent: 'Prepend paragraph'.
	div prepend: paragraph.
	self assert: [ div children first textContent = 'Prepend paragraph' ].

	element := document body querySelector: '#element'.
	self assert: [ element id = 'element' ].

	elements := document body querySelectorAll: '#element'.
	self assert: [ elements first id = 'element' ].

	"Attribute names must be lower case."
	div setAttribute: 'my-attr' value: 'my-value'.
	self assert: [ ( div getAttribute: 'my-attr' ) = 'my-value' ].
	div removeAttribute: 'my-attr'.
	self assert: [ ( div getAttribute: 'my-attr' ) = nil ].

	attr := ( document createAttribute: 'my-attr2' ) value: 'my-value2'.
	div setAttributeNode: attr.
	self assert: [ ( div getAttribute: 'my-attr2' ) = 'my-value2' ].
	div removeAttributeNode: attr.
	self assert: [ ( div getAttribute: 'my-attr2' ) = nil ].

	paragraph := ( document createElement: 'p' ) textContent: 'Paragraph appended'.
	div append: paragraph.
	self assert: [ div children length >= 1 ].
	div replaceChildren: Array new.
	self assert: [ div children length = 0 ].

	paragraph := ( document createElement: 'p' ) textContent: 'Paragraph replacing'.
	div append: paragraph.
	element := document createElement: 'span'.
	div children first replaceWith: element.
	self assert: [ div children first class = HtmlSpanElement ].
!
testScrolling
	| document element |

	document := Document default.
	element := document getElementById: 'element' class: HtmlParagraphElement.
	self assert: [ element id = 'element' ].

	"These 4 calls don't have any effect because is nothing to scroll:"
	element scrollTo: 0 @ 0.
	element scrollTo: 200 @ 400 behavior: 'smooth'.
	element scrollBy: 0 @ 200.
	element scrollBy: 200 @ 400 behavior: 'smooth'.

	"To see this you have to make the browser smaller and step in debug mode:"
	element scrollIntoView: true.
	element scrollIntoViewBehavior: 'smooth' block: 'center' inline: 'center'.

	element := document getElementById: 'input' class: HtmlInputElement.
	element toggleAttribute: 'disabled'.
	self assert: [ ( element getAttribute: 'disabled' ) = '' ].
	self assert: [ ( element toggleAttribute: 'disabled' force: false ) not ].
!
testCreation
	| document element |
	document := Document default.

	#( 'body' 'br' 'button' 'div' 'embed' 'field' 'form' 'head' 'html' 'image' 'input'
	   'label' 'link' 'meta' 'p' 'script' 'slot' 'span' 'textarea' 'title' 'unknown' )
	   	do: [ :tagName |
			element := document createElement: tagName.
			self assert: [ element tagName = tagName toUpperCase ] ].
!
