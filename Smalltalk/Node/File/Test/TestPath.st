CLASS TestPath EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

test
	Path isWindows
		ifTrue: [ self checkWindows: Path ]
		ifFalse: [ self checkPosix: Path ].

	self checkWindows: Path win32.
	self checkPosix: Path posix.
!
checkPosix: pathClass
	| pathObject |

	self assert: [ ( pathClass resolve: 'file.txt' ) endsWith: '/file.txt' ].
	self assert: [ ( pathClass join: '/dir' with: 'file.txt' )  = '/dir/file.txt' ].

	self assert: [  pathClass sep = '/' ].
	self assert: [  pathClass delimiter = ':' ].

	self assert: [ ( pathClass dirname: '/dir/file.txt' )  = '/dir' ].
	self assert: [ ( pathClass basename: '/dir/file.txt' suffix: '' )  = 'file.txt' ].
	self assert: [ ( pathClass basename: '/dir/file.txt' suffix: '.txt' )  = 'file' ].
	self assert: [ ( pathClass extname: '/dir/file.txt' )  = '.txt' ].

	pathObject := PathObject new
		dir: '/dir'; name: 'file'; ext: '.txt'.
	self assert: [ ( pathClass format: pathObject )  = '/dir/file.txt' ].

	pathObject := pathClass parse: '/dir/file.txt'.
	self assert: [ pathObject root = '/' ].
	self assert: [ pathObject dir = '/dir' ].
	self assert: [ pathObject base = 'file.txt' ].
	self assert: [ pathObject name = 'file' ].
	self assert: [ pathObject ext = '.txt' ].

	self assert: [ pathClass matches: '/dir/file.txt' glob: '/dir/*' ].
	self assert: [ pathClass isAbsolute: '/dir/file.txt' ].

	self assert: [ pathClass isAbsolute: '/dir/file.txt' ].
	self assert: [ ( pathClass isAbsolute: 'dir/file.txt' ) not ].

	self assert: [ ( pathClass normalize: '/dir/../file.txt' ) = '/file.txt' ].
	self assert: [ ( pathClass relativeFrom: '/a/b/c' to: '/a/b/d' ) = '../d' ].
	self assert: [ ( pathClass toNamespacedPath: '/dir/file.txt' ) = '/dir/file.txt' ].

	self assert: [ pathClass posix = pathClass win32 posix ].
	self assert: [ pathClass win32 = pathClass posix win32 ].
!
checkWindows: pathClass
	| pathObject |

	self assert: [ ( pathClass resolve: 'file.txt' ) endsWith: '\\file.txt' ].
	self assert: [ ( pathClass join: '\\dir' with: 'file.txt' )  = '\\dir\\file.txt' ].

	self assert: [  pathClass sep = '\\' ].
	self assert: [  pathClass delimiter = ';' ].

	self assert: [ ( pathClass dirname: '\\dir\\file.txt' )  = '\\dir' ].
	self assert: [ ( pathClass basename: '\\dir\\file.txt' suffix: '' )  = 'file.txt' ].
	self assert: [ ( pathClass basename: '\\dir\\file.txt' suffix: '.txt' )  = 'file' ].
	self assert: [ ( pathClass extname: '\\dir\\file.txt' )  = '.txt' ].

	pathObject := PathObject new
		dir: '\\dir'; name: 'file'; ext: '.txt'.
	self assert: [ ( pathClass format: pathObject )  = '\\dir\\file.txt' ].

	pathObject := pathClass parse: '\\dir\\file.txt'.
	self assert: [ pathObject root = '\\' ].
	self assert: [ pathObject dir = '\\dir' ].
	self assert: [ pathObject base = 'file.txt' ].
	self assert: [ pathObject name = 'file' ].
	self assert: [ pathObject ext = '.txt' ].

	self assert: [ pathClass matches: '\\dir\\file.txt' glob: '\\dir\\*' ].
	self assert: [ pathClass isAbsolute: '\\dir\\file.txt' ].

	self assert: [ pathClass isAbsolute: '\\dir\\file.txt' ].
	self assert: [ ( pathClass isAbsolute: 'dir\\file.txt' ) not ].

	self assert: [ ( pathClass normalize: '\\dir\\..\\file.txt' ) = '\\file.txt' ].
	self assert: [ ( pathClass relativeFrom: '\\a\\b\\c' to: '\\a\\b\\d' ) = '..\\d' ].
	self assert: [ ( pathClass toNamespacedPath: '\\dir\\file.txt' ) startsWith: '\\\\?' ].

	self assert: [ pathClass posix = pathClass win32 posix ].
	self assert: [ pathClass win32 = pathClass posix win32 ].
!
