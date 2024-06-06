CLASS FileInputComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'fileInput outputLabel'

htmlPath
	^ 'Components/Input/FileInputComponent.html'.
!
start
	self bindElements.
!
bindElements
	fileInput := Document getElementById: 'fileInput' class: HtmlInputElement.
	outputLabel := Document getElementById: 'fileInputOutputLabel' class: HtmlLabelElement.

	fileInput addEventListener: 'change' then: [ self onFileSelected ].
!
onFileSelected
	| file |

	outputLabel textContent: fileInput value.

	fileInput files length > 0 ifTrue: [
		file := fileInput files first.
		self assert: [ file class = File ].
		self assert: [ file lastModified > 0 ] ].
!

"Accessing"

fileInput
	^ fileInput.
!
outputLabel
	^ outputLabel.
!
