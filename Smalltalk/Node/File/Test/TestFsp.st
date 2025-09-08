CLASS TestFsp EXTENDS Test MODULE TestNode CLASSVARS '' VARS 'tempDirName'

test
	| prefix |
	prefix := Path join: Os tmpdir with: 'smalljs-'.

"	Fsp mkdtemp: prefix
		then: [ :dirName | self onMkdtemp: dirName ]
		error: [ :error | error throw ]."
!
onMkdtemp: dirName
	tempDirName := dirName.
!

"TODO: More tests."
