CLASS TestAiProviders EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

test
	| providers providers2 |

	providers := AiProviders new.
	providers setProvider: 'openai' models: 'o3 o4'.
	self assert: [ providers size = 1 ].
	self assert: [ ( providers modelsFor: 'openai' ) = 'o3 o4' ].
	self assert: [ providers toString = 'AiProviders( openai )' ].

	providers2 := AiProviders fromObject: providers toObject.
	self assert: [ providers providers = providers2 providers ].
	self assert: [ ( providers modelsFor: 'openai' ) = ( providers2 modelsFor: 'openai' ) ].
	self assert: [ providers size = providers2 size ].
	self assert: [ providers toString = providers2 toString ].
!

