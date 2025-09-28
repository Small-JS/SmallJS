CLASS TestProcessConfig EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

test
	| config variables targetDefaults |

	config := Process config.
	self assert: [ config class = ProcessConfig ].

	variables := config targetDefaults.
	self assert: [ ( variables atJsProperty: 'default_configuration' ) length > 0 ].

	variables := config variables.
	self assert: [ ( variables atJsProperty: 'host_arch' ) = Process arch ].
!
