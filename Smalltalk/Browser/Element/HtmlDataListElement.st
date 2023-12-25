CLASS HtmlDataListElement EXTENDS HtmlElement MODULE DOM CLASSVARS '' VARS ''

options
	^ Array fromJs: INLINE 'this.js.options' elementClass: HtmlOptionElement.
!
indexOf: value
	"Return the HtmlOptionElement that contains argument text"

	| index |
	index := 0.

	self options do: [ :option |
		option value = value ifTrue: [ ^ index ].
		index increment ].

	^ -1.
!
