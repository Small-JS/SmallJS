CLASS HtmlDataListElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''

options
	^ Array fromJs: INLINE 'this.js.options' elementClass: HtmlOptionElement.
!
indexOf: value
	"Return the (zero-based) index of the option with the argument value, or -1 if not found."

	| index |
	index := 0.

	self options do: [ :option |
		option value = value ifTrue: [ ^ index ].
		index increment ].

	^ -1.
!
