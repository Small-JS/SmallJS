CLASS TestHtmlAnchorElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| anchor |

	anchor := Document new createElement: 'a'.
	self assert: [ anchor class = HtmlAnchorElement ].

	self assert: [ anchor download = '' ].
	anchor download: 'Test.txt'.
	self assert: [ anchor download = 'Test.txt' ].

	self assert: [ anchor href = '' ].
	self assert: [ anchor protocol = ':' ].
	self assert: [ anchor host = '' ].
	self assert: [ anchor port = '' ].
	self assert: [ anchor hostname = '' ].
	self assert: [ anchor origin = '' ].

	anchor href: 'http://localhost:8080/SmallJS.png'.
	self assert: [ anchor href = 'http://localhost:8080/SmallJS.png' ].
	self assert: [ anchor host = 'localhost:8080' ].
	self assert: [ anchor hostname = 'localhost' ].
	self assert: [ anchor port = '8080' ].
	self assert: [ anchor pathname = '/SmallJS.png' ].
	self assert: [ anchor origin = 'http://localhost:8080' ].

	self assert: [ anchor hreflang = '' ].
	anchor hreflang: 'en'.
	self assert: [ anchor hreflang = 'en' ].

	self assert: [ anchor username = '' ].
	anchor username: 'John'.
	self assert: [ anchor username = 'John' ].

	self assert: [ anchor password = '' ].
	anchor password: 'secret'.
	self assert: [ anchor password = 'secret' ].

	self assert: [ anchor protocol = 'http:' ].
	anchor protocol: 'ftp:'.
	self assert: [ anchor protocol = 'ftp:' ].

	self assert: [ anchor referrerPolicy = '' ].
	anchor referrerPolicy: 'origin'.
	self assert: [ anchor referrerPolicy = 'origin' ].

	self assert: [ anchor rel = '' ].
	anchor rel: 'alternate'.
	self assert: [ anchor rel = 'alternate' ].
	self assert: [ anchor relList length = 1 ].

	self assert: [ anchor search = '' ].
	anchor search: '?q=123'.
	self assert: [ anchor search = '?q=123' ].

	self assert: [ anchor target = '' ].
	anchor target: '_blank'.
	self assert: [ anchor target = '_blank' ].

	self assert: [ anchor text = '' ].
	anchor text: 'SmallJS.png'.
	self assert: [ anchor text = 'SmallJS.png' ].

	self assert: [ anchor type = '' ].
	anchor type: 'image/jpg'.
	self assert: [ anchor type = 'image/jpg' ].
!
