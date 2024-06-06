CLASS TestHtmlFormElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| form |

	form := Document default createElement: 'form'.
	form appendChild: ( Document default createElement: 'input' ).
	form appendChild: ( Document default createElement: 'button' ).

	self assert: [ form elements length = 2 ].
	self assert: [ form length = 2 ].

	form name: 'formName'.
	self assert: [ form name = 'formName' ].

	self assert: [ form method = 'get' ].
	form method: 'post'.
	self assert: [ form method = 'post' ].

	self assert: [ form target = '' ].
	form target: 'notarget'.
	self assert: [ form target = 'notarget' ].

	form action: 'Index.html'.
	self assert: [ form action endsWith: 'Index.html' ].
	form action: 'noaction'.
	self assert: [ form action endsWith: 'noaction' ].

	self assert: [ form enctype = 'application/x-www-form-urlencoded' ].
	form enctype: 'text/plain'.
	self assert: [ form enctype = 'text/plain' ].

	self assert: [ form acceptCharset = '' ].
	form acceptCharset: 'utf-8'.
	self assert: [ form acceptCharset = 'utf-8' ].

	self assert: [ form autocomplete = 'on' ].
	form autocomplete: 'off'.
	self assert: [ form autocomplete = 'off' ].

	self assert: [ form noValidate not ].
	form noValidate: true.
	self assert: [ form noValidate ].
!
testSubmitButton
	| form button |

	button := Document default createElement: 'button'.
	form := Document default createElement: 'form'.
	form appendChild: button.

	self assert: [ button form class = HtmlFormElement ].
	self assert: [ button formAction startsWith: 'http' ].
	self assert: [ button formEnctype = '' ].
	self assert: [ button formMethod = '' ].
	self assert: [ button formNoValidate not ].
	self assert: [ button formTarget = '' ].
!
testInput
	| form input |

	input := Document default createElement: 'input'.
	form := Document default createElement: 'form'.
	form appendChild: input.

	self assert: [ input form class = HtmlFormElement ].
	self assert: [ input formAction startsWith: 'http' ].
	self assert: [ input formEnctype = '' ].
	self assert: [ input formMethod = '' ].
	self assert: [ input formNoValidate not ].
	self assert: [ input formTarget = '' ].
!
