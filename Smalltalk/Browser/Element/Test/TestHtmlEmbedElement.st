CLASS TestHtmlEmbedElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

testProperties
	| embed |

	embed := Document getElementById: 'embed'.
	self assert: [ embed class = HtmlEmbedElement ].
	self assert: [ embed size = ( 300 @ 40 ) ].
	self assert: [ embed src endsWith: '/Test/Embed.html' ].
	self assert: [ embed type = 'text/html' ].
!
