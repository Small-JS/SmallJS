CLASS HtmlFormElement EXTENDS HtmlElement MODULE DOM CLASSVARS '' VARS ''

METHODS

"Properties"

elements
	^ Array fromJs: INLINE 'this.js.elements' elementConverter: [ :jsHtmlElement |
		HtmlElement fromJsSubElement: jsHtmlElement ].
!
name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	INLINE 'this.js.name = name.js'.
!
length
	^ Integer fromJs: INLINE 'this.js.length'.
!
method
	^ String fromJs: INLINE 'this.js.method'.
!
method: method
	INLINE 'this.js.method = method.js'.
!
target
	^ String fromJs: INLINE 'this.js.target'.
!
target: target
	INLINE 'this.js.target = target.js'.
!
action
	^ String fromJs: INLINE 'this.js.action'.
!
action: action
	INLINE 'this.js.action = action.js'.
!
enctype
	^ String fromJs: INLINE 'this.js.enctype'.
!
enctype: enctype
	INLINE 'this.js.enctype = enctype.js'.
!
acceptCharset
	^ String fromJs: INLINE 'this.js.acceptCharset'.
!
acceptCharset: acceptCharset
	INLINE 'this.js.acceptCharset = acceptCharset.js'.
!
autocomplete
	^ String fromJs: INLINE 'this.js.autocomplete'.
!
autocomplete: autocomplete
	INLINE 'this.js.autocomplete = autocomplete.js'.
!
noValidate
	^ Boolean fromJs: INLINE 'this.js.noValidate'.
!
noValidate: noValidate
	INLINE 'this.js.noValidate = noValidate.js'.
!
