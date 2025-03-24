CLASS Mithril EXTENDS Object MODULE CounterUsingMithrilApp CLASSVARS '' VARS ''

INLINE 'import "../resources-from-npm/mithril.js";'

CLASSMETHODS

mount: aComponent on: aElement
    "Mount a Mithril component on a DOM element."
    ^ INLINE 'm.mount(aElement, aComponent)'
!

mount: aComponent
    "Mount a Mithril component on the body of the document."
    |aElement|
    aElement := INLINE 'document.body'.
    ^ self mount: aComponent on: aElement
!

mountViewBlock: viewBlock
    |app|
    app := INLINE '{view: viewBlock.js}'.
    self mount: app.
    ^ app
!

m: elementName
    "Create a Mithril component."
    ^ INLINE 'm(elementName.js)'
!

m: elementName with: aComponent1
    "Create a Mithril component."
    ^ INLINE 'm(elementName.js, aComponent1.js || aComponent1)'
!

m: elementName with: aComponent1 with: aComponent2
    "Create a Mithril component."
    ^ INLINE 'm(elementName.js, aComponent1.js || aComponent1, aComponent2.js || aComponent2)'
!

m: elementName with: aComponent1 with: aComponent2 with: aComponent3
    "Create a Mithril component."
    ^ INLINE 'm(elementName.js, aComponent1.js || aComponent1, aComponent2.js || aComponent2, aComponent3.js || aComponent3)'
!

m: elementName with: aComponent1 with: aComponent2 with: aComponent3 with: aComponent4
    "Create a Mithril component."
    ^ INLINE 'm(elementName.js, aComponent1.js || aComponent1, aComponent2.js || aComponent2, aComponent3.js || aComponent3, aComponent4.js || aComponent4)'
!

attribute: attributeName value: value
    "Create a Mithril attribute."
    ^ INLINE '{[attributeName.js]: value.js}'
!

attribute: attributeName1 value: value1 attribute: attributeName2 value: value2
    "Create a Mithril attribute."
    ^ INLINE '{[attributeName1.js]: value1.js, [attributeName2.js]: value2.js}'
!

attribute: attributeName1 value: value1 attribute: attributeName2 value: value2 attribute: attributeName3 value: value3
    "Create a Mithril attribute."
    ^ INLINE '{[attributeName1.js]: value1.js, [attributeName2.js]: value2.js, [attributeName3.js]: value3.js}'
!

trust: aString
    ^ INLINE 'm.trust(aString.js)'
!
