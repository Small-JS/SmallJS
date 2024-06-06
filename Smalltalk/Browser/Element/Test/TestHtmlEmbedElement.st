CLASS TestHtmlEmbedElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

testProperties
	| body embed |

	body := Document new body
		innerHtml: '<embed id="embed" type="text/html" src="Missing.html" width="300" height="40">'.
	embed := body children first.

	self assert: [ embed size = ( 300 @ 40 ) ].
	self assert: [ embed src = 'Missing.html' ].
	self assert: [ embed type = 'text/html' ].
!
