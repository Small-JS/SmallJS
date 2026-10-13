CLASS GeolocationComponent EXTENDS Component MODULE MyBrowserApp CLASSVARS ''
	VARS 'currentButton resultParagraph'

htmlPath
	^ 'Components/GeolocationComponent.html'.
!
start
	self bindElements.
!
bindElements
	currentButton := Document getElementById: 'geolocationCurrentButton' class: HtmlButtonElement.
	currentButton onClick: [ self onCurrentButton ].

	resultParagraph := Document getElementById: 'geolocationResultParagraph' class: HtmlParagraphElement.
!
currentButton
	^ currentButton.
!
resultParagraph
	^ resultParagraph.
!
onCurrentButton
	"Note: This function cannot be GUI tested automatically
		because it requires user permission first."
	resultParagraph textContent: '[Locating...]'.
	Geolocation default
		currentPositionThen: [ :position | self showPosition: position ]
		error: [ :error | self showError: error ].
!
showPosition: position
	| coords |
	coords := position coords.
	resultParagraph textContent:
		'Latitude: ', ( coords latitude toFixed: 6 ),
		', longitude: ', ( coords longitude toFixed: 6 ),
		', accuracy: ', ( coords accuracy toFixed: 0 ), ' m'.
!
showError: error
	resultParagraph textContent: 'Error ', error code toString, ': ', error message.
!
