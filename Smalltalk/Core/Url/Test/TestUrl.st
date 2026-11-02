CLASS TestUrl EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testCreation
	| url |
	self assertError: [ Url new ].
	self assertError: [ Url url: 'not a url' ].

	url := Url url: 'https://example.com/path'.
	self assert: [ url class = Url ].
	self assert: [ url jsClassName = 'URL' ].
	self assert: [ url href = 'https://example.com/path' ].
	self assert: [ url toString = 'https://example.com/path' ].
	self assert: [ url toJson = '"https://example.com/path"' ].

	url := Url url: '../other?x=1' base: 'https://example.com/a/b/c'.
	self assert: [ url href = 'https://example.com/a/other?x=1' ].
!
testParse
	self assert: [ ( Url parse: 'not a url' ) = nil ].
	self assert: [ ( Url parse: 'https://example.com' ) href = 'https://example.com/' ].
	self assert: [ ( Url parse: '/path' base: 'https://example.com' ) href = 'https://example.com/path' ].

	self assert: [ Url canParse: 'https://example.com' ].
	self assert: [ ( Url canParse: '/path' ) not ].
	self assert: [ Url canParse: '/path' base: 'https://example.com' ].
!
testProperties
	| url |
	url := Url url: 'https://user:secret@example.com:8080/dir/page.html?a=1&b=2#section'.
	self assert: [ url protocol = 'https:' ].
	self assert: [ url username = 'user' ].
	self assert: [ url password = 'secret' ].
	self assert: [ url host = 'example.com:8080' ].
	self assert: [ url hostname = 'example.com' ].
	self assert: [ url port = '8080' ].
	self assert: [ url pathname = '/dir/page.html' ].
	self assert: [ url search = '?a=1&b=2' ].
	self assert: [ url hash = '#section' ].
	self assert: [ url origin = 'https://example.com:8080' ].

	"The default port of the protocol is empty."
	self assert: [ ( Url url: 'https://example.com:443' ) port = '' ].
!
testSetters
	| url |
	url := Url url: 'https://example.com'.
	url
		protocol: 'http';
		username: 'user';
		password: 'secret';
		hostname: 'example.org';
		port: 8080;
		pathname: 'dir/page';
		search: 'q=1';
		hash: 'top'.
	self assert: [ url href = 'http://user:secret@example.org:8080/dir/page?q=1#top' ].

	url host: 'example.net:9000'.
	self assert: [ url hostname = 'example.net' ].
	self assert: [ url port = '9000' ].

	url href: 'https://example.com/new'.
	self assert: [ url pathname = '/new' ].
	self assert: [ url search = '' ].
!
testSearchParams
	| url params |
	url := Url url: 'https://example.com/?a=1&b=2'.
	params := url searchParams.
	self assert: [ params class = UrlSearchParams ].
	self assert: [ ( params get: 'b' ) = '2' ].

	"Changing the search params updates the URL."
	params append: 'c' value: 'x y'.
	self assert: [ url search = '?a=1&b=2&c=x+y' ].

	"Changing the URL updates the search params."
	url search: '?d=4'.
	self assert: [ params keys = #( 'd' ) ].
!
testObjectUrl
	| url |
	url := Url createObjectUrl: ( Blob fromArray: #( 'Hello' ) ).
	self assert: [ url startsWith: 'blob:' ].
	Url revokeObjectUrl: url.
!
