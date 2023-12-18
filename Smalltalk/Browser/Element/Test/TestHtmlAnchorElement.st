CLASS TestHtmlAnchorElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| anchor host hostname href port protocol |

	anchor := Document getElementById: 'anchor'.
	self assert: [ anchor class = HtmlAnchorElement ].

	self assert: [ anchor download = '' ].
	anchor download: 'Test.txt'.
	self assert: [ anchor download = 'Test.txt' ].
	anchor download: ''.

	host := anchor host.
	self assert: [ host includes: ':' ].
	anchor host: 'temp:8080'.
	self assert: [ anchor host = 'temp:8080' ].
	anchor host: host.

	hostname := anchor hostname.
	self assert: [ hostname length > 0 ].
	anchor hostname: 'temp'.
	self assert: [ anchor hostname = 'temp' ].
	anchor hostname: hostname.

	href := anchor href.
	self assert: [ href endsWith: 'SmallJS.png' ].
	anchor href: 'temp'.
	self assert: [ anchor href endsWith: 'temp' ].
	anchor href: href.

	self assert: [ href toString endsWith: 'SmallJS.png' ].

	self assert: [ anchor pathname = '/SmallJS.png' ].
	anchor pathname: 'temp'.
	self assert: [ anchor pathname = '/temp' ].
	anchor pathname: '/SmallJS.png'.

	self assert: [ anchor hreflang = 'en' ].
	anchor hreflang: 'nl'.
	self assert: [ anchor hreflang = 'nl' ].
	anchor hreflang: 'en'.

	self assert: [ Document default documentUri startsWith: anchor origin ].

	self assert: [ anchor username = '' ].
	self assert: [ anchor password = '' ].
	anchor username: 'John'.
	anchor password: 'secret'.
	self assert: [ anchor username = 'John' ].
	self assert: [ anchor password = 'secret' ].
	anchor username: ''.
	anchor password: ''.

	port := anchor port.
	self assert: [ port toInteger > 0 ].
	anchor port: 8081.
	self assert: [ anchor port = '8081' ].
	anchor port: port.

	protocol := anchor protocol.
	self assert: [ #( 'http:' 'https:' ) includes: protocol ].
	anchor protocol: 'ftp:'.
	self assert: [ anchor protocol = 'ftp:' ].
	anchor protocol: protocol.

	self assert: [ anchor referrerPolicy = 'origin' ].
	anchor referrerPolicy: 'no-referrer'.
	self assert: [ anchor referrerPolicy = 'no-referrer' ].
	anchor referrerPolicy: 'origin'.

	self assert: [ anchor rel = '' ].
	anchor rel: 'alternate'.
	self assert: [ anchor rel = 'alternate' ].
	anchor rel: ''.

	self assert: [ anchor relList length = 0 ].

	self assert: [ anchor search = '' ].
	anchor search: '?q=123'.
	self assert: [ anchor search = '?q=123' ].
	anchor search: ''.

	self assert: [ anchor target = '_self' ].
	anchor target: '_blank'.
	self assert: [ anchor target = '_blank' ].
	anchor target: '_self'.

	self assert: [ anchor text = 'SmallJS.png' ].
	anchor text: 'temp'.
	self assert: [ anchor text = 'temp' ].
	anchor text: 'SmallJS.png'.

	self assert: [ anchor type = 'image/png' ].
	anchor type: 'image/jpg'.
	self assert: [ anchor type = 'image/jpg' ].
	anchor type: 'image/png'.
!
