CLASS TestIframeComponent EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| iframeComponent iframeElement |
	iframeComponent := MyBrowserApp default findComponent: IframeComponent.
	iframeElement := iframeComponent iframeElement.

	self assert: [ iframeElement name = 'iframeName' ].
	self assert: [ iframeElement title = 'IFrame title' ].
	self assert: [ iframeElement size = ( 300 @ 40 ) ].
	self assert: [ iframeElement src endsWith: 'Components/IframeContent.html' ].
	self assert: [ iframeElement referrerPolicy = 'origin' ].
	self assert: [ iframeElement allow = 'geolocation' ].
!
