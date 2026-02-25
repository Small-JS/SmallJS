CLASS PharoClientApp EXTENDS BrowserApp MODULE PharoClientApp CLASSVARS ''
	VARS 'helloButton responseSpan'

start
	self bindElements.
!
bindElements
	"Bind HTML elements to vars, set defaults, set event listeners."

	helloButton := Document getElementById: 'helloButton' class: HtmlButtonElement.
	helloButton onClick: [ self sendHello ].

	responseSpan := Document getElementById: 'responseSpan' class: HtmlSpanElement.
!
async sendHello
	"Send a '/hello' GET request to the server and catch the response."
	| object |
	object := await Fetch object: '/hello'.
	responseSpan textContent: (
		object atProperty: 'message' ).
!

"Accessing (used by tests)"

helloButton
	^ helloButton.
!
responseSpan
	^ responseSpan.
!
