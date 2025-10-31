CLASS PharoClientApp EXTENDS BrowserApp MODULE PharoClientApp CLASSVARS ''
	VARS 'helloButton responseSpan'

start
	self bindElements.

	self testMode ifTrue: [
		TestPharoClientApp new test: self ].
!
bindElements
	"Bind HTML elements to vars, set defaults, set event listeners."

	helloButton := Document getElementById: 'helloButton' class: HtmlButtonElement.
	helloButton onClick: [ self sendHello ].

	responseSpan := Document getElementById: 'responseSpan' class: HtmlSpanElement.
!
sendHello
	"Send a '/hello' GET request to the server and catch the response."
	Fetch
		object: '/hello'
		then: [ :object | self onResponse: object ]
		catch: [ :error | self onError: error ] .
!
onResponse: object
	responseSpan textContent: (
		object atProperty: 'message' ).
!
onError: error
	responseSpan textContent: (
		error toString ).
!

testMode
	"2024-09-18:
	 Zinc gives an error when a URL query like '?test' is done at the root level of a website.
	 To work around that, test mode is started with 'index.html?test.
	 This bug is reported here: https://github.com/svenvc/zinc/issues/150"
	^ Window default location search toLowerCase endsWith: '?test'.
!

"Accessing (used by tests)"

helloButton
	^ helloButton.
!
responseSpan
	^ responseSpan.
!
