CLASS SelectComponent EXTENDS Component MODULE MyBrowserApp CLASSVARS ''
	VARS 'select outputParagraph'

htmlPath
	^ 'InputComponents/SelectComponent.html'.
!
start
	self bindElements.
!
bindElements
	select := Document getElementById: 'select' class: HtmlSelectElement.
	outputParagraph := Document getElementById: 'selectOutputParagraph' class: HtmlParagraphElement.

	select onChange: [ self onChange ].
!
onChange
	outputParagraph textContent: select value.
!

"Accessing"

select
	^ select.
!
outputParagraph
	^ outputParagraph.
!
