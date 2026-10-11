CLASS TestNodeWorkerOptions EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

test
	| options limits env |
	options := NodeWorkerOptions new.

	options name: 'Worker1'.
	self assert: [ options name = 'Worker1' ].
	options eval: true.
	self assert: [ options eval ].
	options workerData: 'Data'.
	self assert: [ options workerData = 'Data' ].
	options transferList: Array new.
	self assert: [ options transferList isEmpty ].
	options argv: ( Array with: 'a' with: 'b' ).
	self assert: [ options argv = ( Array with: 'a' with: 'b' ) ].
	options execArgv: ( Array with: '--no-warnings' ).
	self assert: [ options execArgv first = '--no-warnings' ].

	env := JsObject newEmpty.
	env atJsProperty: 'MY_VAR' put: 'Value'.
	options env: env.
	self assert: [ ( options env atJsProperty: 'MY_VAR' ) = 'Value' ].
	self assert: [ options shareEnv not ].
	options shareEnv: true.
	self assert: [ options shareEnv ].
	options shareEnv: false.
	self assert: [ options shareEnv not ].

	options stdin: true.
	self assert: [ options stdin ].
	options stdout: true.
	self assert: [ options stdout ].
	options stderr: false.
	self assert: [ options stderr not ].
	options trackUnmanagedFds: false.
	self assert: [ options trackUnmanagedFds not ].

	limits := NodeResourceLimits new.
	limits stackSizeMb: 4.
	options resourceLimits: limits.
	self assert: [ options resourceLimits class = NodeResourceLimits ].
	self assert: [ options resourceLimits stackSizeMb = 4 ].
!
