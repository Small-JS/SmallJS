CLASS TestAnthropicMessageCreateParams EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

"Tests setting and getting params, without calling the Anthropic API."

test
	| params object system tools |

	params := AnthropicMessageCreateParams new.
	self assert: [ params class = AnthropicMessageCreateParams ].
	self assert: [ params stream not ].

	params maxTokens: 1024.
	self assert: [ params maxTokens = 1024 ].

	params model: 'claude-haiku-5-5'.
	self assert: [ params model = 'claude-haiku-5-5' ].

	params temperature: 0.5.
	self assert: [ params temperature = 0.5 ].

	params cacheControl: ( Object new atProperty: 'type' put: 'ephemeral' ).
	self assert: [ ( params cacheControl atProperty: 'type' ) = 'ephemeral' ].

	params container: 'container_123'.
	self assert: [ params container = 'container_123' ].

	params diagnostics: ( Object new atProperty: 'enabled' put: true ).
	self assert: [ params diagnostics atProperty: 'enabled' ].

	params inferenceGeo: 'us'.
	self assert: [ params inferenceGeo = 'us' ].

	params metadata: ( Object new atProperty: 'user_id' put: 'my-user-id' ).
	self assert: [ ( params metadata atProperty: 'user_id' ) = 'my-user-id' ].

	params outputConfig: ( Object new atProperty: 'effort' put: 'low' ).
	self assert: [ ( params outputConfig atProperty: 'effort' ) = 'low' ].

	params serviceTier: 'standard_only'.
	self assert: [ params serviceTier = 'standard_only' ].

	params stopSequences: #( 'STOP' 'END' ).
	self assert: [ params stopSequences = #( 'STOP' 'END' ) ].

	params system: 'You are a helpful assistant.'.
	self assert: [ params system = 'You are a helpful assistant.' ].

	object := Object new.
	object atProperty: 'type' put: 'text'.
	object atProperty: 'text' put: 'You are a helpful assistant.'.
	params system: ( Array with: object ).
	system := params system.
	self assert: [ system length = 1 ].
	self assert: [ ( system first atProperty: 'text' ) = 'You are a helpful assistant.' ].

	object := Object new.
	object atProperty: 'type' put: 'enabled'.
	object atProperty: 'budget_tokens' put: 2048.
	params thinking: object.
	self assert: [ ( params thinking atProperty: 'type' ) = 'enabled' ].
	self assert: [ ( params thinking atProperty: 'budget_tokens' ) = 2048 ].

	params toolChoice: ( Object new atProperty: 'type' put: 'auto' ).
	self assert: [ ( params toolChoice atProperty: 'type' ) = 'auto' ].

	object := Object new.
	object atProperty: 'name' put: 'get_weather'.
	object atProperty: 'description' put: 'Get the weather for a city.'.
	params tools: ( Array with: object ).
	tools := params tools.
	self assert: [ tools length = 1 ].
	self assert: [ ( tools first atProperty: 'name' ) = 'get_weather' ].

	params topK: 10.
	self assert: [ params topK = 10 ].

	params topP: 0.9.
	self assert: [ params topP = 0.9 ].

	params userProfileId: 'my-user-profile-id'.
	self assert: [ params userProfileId = 'my-user-profile-id' ].

	params workspaceId: 'wrkspc_123'.
	self assert: [ params workspaceId = 'wrkspc_123' ].
!
