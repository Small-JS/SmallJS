CLASS TestHtmlDataListElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| dataListInput dataList options option3 |

	dataListInput := Document getElementById: 'dataListInput' class: HtmlInputElement.
	dataListInput addEventListener: 'input' then: [ self onInput ].

	dataList := Document getElementById: 'dataList' class: HtmlDataListElement.
	options := dataList options.
	self assert: [ options length = 2 ].
	self assert: [ options first value = 'First' ].
	self assert: [ ( dataList indexOf: 'Second' ) = 1 ].
	self assert: [ ( dataList indexOf: 'Missing' ) = -1 ].
!
onInput
	| dataListInput dataListOutputLabel |

	dataListInput := Document getElementById: 'dataListInput' class: HtmlInputElement.
	dataListOutputLabel := Document getElementById: 'dataListOutputLabel' class: HtmlLabelElement.
	dataListOutputLabel textContent: dataListInput value.
!
