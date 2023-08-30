CLASS HtmlElement EXTENDS Element MODULE DOM CLASSVARS '' VARS ''
	"This class encasulates the JS class HTMLElement
	 of which variable js contains an instance."

METHODS

"Properties."

accessKey
	^ String fromJs: INLINE 'this.js.accessKey'.
!
accessKey: accessKey
	INLINE 'this.js.accessKey = accessKey.js'.
!
dir
	^ String fromJs: INLINE 'this.js.dir'.
!
dir: direction
	INLINE 'this.js.dir = direction.js'.
!
enterKeyHint
	^ String fromJs: INLINE 'this.js.enterKeyHint'.
!
enterKeyHint: hint
	INLINE 'this.js.enterKeyHint = hint.js'.
!
hidden
	^ Boolean fromJs: INLINE 'this.js.hidden'.
!
hidden: boolean
	INLINE 'this.js.hidden = boolean.js'.
!
inert
	^ Boolean fromJs: INLINE 'this.js.inert'.
!
inert: boolean
	INLINE 'this.js.inert = boolean.js'.
!
innerText
	^ String fromJs: INLINE 'this.js.innerText'.
!
innerText: string
	INLINE 'this.js.innerText = string.js'.
!
outerText
	^ String fromJs: INLINE 'this.js.outerText'.
!
outerText: string
	INLINE 'this.js.outerText = string.js'.
!
isContentEditable
	^ Boolean fromJs: INLINE 'this.js.isContentEditable'.
!
lang
	^ String fromJs: INLINE 'this.js.lang'.
!
lang: string
	INLINE 'this.js.lang = string.js'.
!
nonce
	^ String fromJs: INLINE 'this.js.nonce'.
!
nonce: string
	INLINE 'this.js.nonce = string.js'.
!
offsetHeight
	^ Integer fromJs: INLINE 'this.js.offsetHeight'.
!
offsetLeft
	^ Integer fromJs: INLINE 'this.js.offsetLeft'.
!
offsetParent
	^ Integer fromJs: INLINE 'this.js.offsetParent'.
!
offsetTop
	^ Integer fromJs: INLINE 'this.js.offsetTop'.
!
offsetWidth
	^ Integer fromJs: INLINE 'this.js.offsetWidth'.
!
style
	^ CssStyleDeclaration fromJs: INLINE 'this.js.style'.
!
tabIndex
	^ String fromJs: INLINE 'this.js.tabIndex'.
!
tabIndex: tabIndex
	INLINE 'this.js.tabIndex = tabIndex.js'.
!
title
	^ String fromJs: INLINE 'this.js.title'.
!
title: string
	INLINE 'this.js.title = string.js'.
!

"Methods."

blur
	INLINE 'this.js.blur()'.
!
click
	INLINE 'this.js.click()'.
!
onClick: block
	self addEventListener: 'click' then: block.
!
focus
	INLINE 'this.js.focus()'.
!
forceFocus
	"Make focus always succeed by setting tabIndex first."
	self tabIndex: 0; focus.
!

