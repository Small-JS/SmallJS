CLASS TestHtmlIframeElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| iframe expectedReferrerPolicy |

	iframe := Document getElementById: 'iframe'.
	self assert: [ iframe class = HtmlIframeElement ].

	self assert: [ iframe allow = 'geolocation' ].
	iframe allow: 'camera'.
	self assert: [ iframe allow = 'camera' ].
	iframe allow: 'geolocation'.

	self assert: [ iframe size = ( 300 @ 40 ) ].
	self assert: [ iframe contentDocument class = Document ].
	self assert: [ iframe contentWindow class = Window ].

	self assert: [ iframe name = 'iframeName' ].
	iframe name: 'newName'.
	self assert: [ iframe name = 'newName' ].
	iframe name: 'iframeName'.

	self assert: [ iframe referrerPolicy = 'origin' ].
	iframe referrerPolicy: 'strict-origin'.
	"For some reason, the field is now empty in Chromium browsers."
	expectedReferrerPolicy := Window isChromium ifTrue: [ '' ] ifFalse: [ 'strict-origin' ].
	self assert: [ iframe referrerPolicy = expectedReferrerPolicy ].
	iframe referrerPolicy: 'origin'.

	self assert: [ iframe sandbox entries = #( ) ].
	self assert: [ iframe src endsWith: '/Test/IFrame.html' ].

	self assert: [ iframe srcDoc = '' ].
	iframe srcDoc: '<!DOCTYPE html><p>Hello World!</p>'.
	self assert: [ iframe srcDoc = '<!DOCTYPE html><p>Hello World!</p>' ].
	iframe removeAttribute: 'srcdoc'.
!
