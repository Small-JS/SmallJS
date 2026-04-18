CLASS TestHtmlIframeElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| iframe |

	iframe := Document default createElement: 'iframe'.

	self assert: [ iframe allow = '' ].
	iframe allow: 'camera'.
	self assert: [ iframe allow = 'camera' ].

	self assert: [ iframe size = ( 0 @ 0 ) ].
	self assert: [ iframe contentDocument isNil ].
	self assert: [ iframe contentWindow isNil ].

	self assert: [ iframe name = '' ].
	iframe name: 'newName'.
	self assert: [ iframe name = 'newName' ].

	self assert: [ iframe referrerPolicy = '' ].
	iframe referrerPolicy: 'strict-origin'.
	self assert: [ iframe referrerPolicy = 'strict-origin' ].

	self assert: [ iframe sandbox entries isEmpty ].

	self assert: [ iframe src = '' ].
	iframe src: 'Missing.html'.
	self assert: [ iframe src endsWith: 'Missing.html' ].

	self assert: [ iframe srcDoc = '' ].
	iframe srcDoc: '<!DOCTYPE html><p>Hello World!</p>'.
	self assert: [ iframe srcDoc = '<!DOCTYPE html><p>Hello World!</p>' ].
!
