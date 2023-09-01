CLASS TestHtmlEmbedElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

browserOnly
	^ true.
!
testProperties
	| embed |

	embed := Document default getElementById: 'embed'.
	self assert: [ embed class = HtmlEmbedElement ].
	self assert: [ embed size = ( 300 @ 40 ) ].
	self assert: [ embed src endsWith: '/Test/Embed.html' ].
	self assert: [ embed type = 'text/html' ].
!
