CLASS TestEnvironment EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

test
	| var data |
	var := 'SMALLJS_TEMP'.
	data := 'EnvData'.

	Environment at: var put: data.
	self assert: [ ( Environment at: var ) = data ].

	Environment deleteAt: var.
	self assert: [ ( Environment at: var ) isNil ].
!
testLoad
	| tempPath envString |

	tempPath := Os tmpPath: 'smalljs-env-'.
	envString := 'SMALLJS_LOADED=loaded\n'.
	Fs writeFileSync: tempPath data: envString options: nil.

	Environment load: tempPath.
	self assert: [ ( Environment at: 'SMALLJS_LOADED' ) = 'loaded' ].

	Fs unlinkSync: tempPath.
!
