CLASS FileInputComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'fileInput outputParagraph'

htmlPath
	^ 'InputComponents/FileInputComponent.html'.
!
start
	self bindElements.
!
bindElements
	fileInput := Document getElementById: 'fileInput' class: HtmlInputElement.
	outputParagraph := Document getElementById: 'fileInputOutputParagraph' class: HtmlParagraphElement.

	fileInput addEventListener: 'change' then: [ self onFileSelected ].
!
onFileSelected
	| file |

	outputParagraph textContent: fileInput value.

	fileInput files length > 0 ifTrue: [
		file := fileInput files first.
		self assert: [ file class = File ].
		self assert: [ file lastModified > 0 ] ].
!

"Accessing"

fileInput
	^ fileInput.
!
outputParagraph
	^ outputParagraph.
!
