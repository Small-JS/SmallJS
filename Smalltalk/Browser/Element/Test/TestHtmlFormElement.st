CLASS TestHtmlFormElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| document form formLabel |

	document := Document default.
	form := document getElementById: 'form' class: HtmlFormElement.

	formLabel := document getElementById: 'formLabel' class: HtmlLabelElement.
	formLabel textContent: document location search.

	self assert: [ form elements length = 2 ].
	self assert: [ form length = 2 ].

	self assert: [ form name = 'formName' ].
	form name: 'formName2'.
	self assert: [ form name = 'formName2' ].
	form name: 'formName'.

	self assert: [ form method = 'get' ].
	form method: 'post'.
	self assert: [ form method = 'post' ].
	form method: 'get'.

	self assert: [ form target = '' ].
	form target: 'notarget'.
	self assert: [ form target = 'notarget' ].
	form target: ''.

	self assert: [ form action endsWith: 'Index.html' ].
	form action: 'noaction'.
	self assert: [ form action endsWith: 'noaction' ].
	form action: 'Index.html'.

	self assert: [ form enctype = 'application/x-www-form-urlencoded' ].
	form enctype: 'text/plain'.
	self assert: [ form enctype = 'text/plain' ].
	form enctype: 'application/x-www-form-urlencoded'.

	self assert: [ form acceptCharset = '' ].
	form acceptCharset: 'utf-8'.
	self assert: [ form acceptCharset = 'utf-8' ].
	form acceptCharset: ''.

	self assert: [ form autocomplete = 'on' ].
	form autocomplete: 'off'.
	self assert: [ form autocomplete = 'off' ].
	form autocomplete: 'on'.

	self assert: [ form noValidate not ].
	form noValidate: true.
	self assert: [ form noValidate ].
	form noValidate: false.
!
testSubmitButton
	| button |
	button := Document getElementById: 'formSubmitButton' class: HtmlButtonElement.

	self assert: [ button form class = HtmlFormElement ].
	self assert: [ button formAction startsWith: 'http' ].
	self assert: [ button formEnctype = '' ].
	self assert: [ button formMethod = '' ].
	self assert: [ button formNoValidate not ].
	self assert: [ button formTarget = '' ].
!
testInput
	| input |
	input := Document getElementById: 'formInput' class: HtmlInputElement.

	self assert: [ input form class = HtmlFormElement ].
	self assert: [ input formAction startsWith: 'http' ].
	self assert: [ input formEnctype = '' ].
	self assert: [ input formMethod = '' ].
	self assert: [ input formNoValidate not ].
	self assert: [ input formTarget = '' ].
!
