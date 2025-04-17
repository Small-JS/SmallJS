CLASS AiProviders EXTENDS Object MODULE AiShared CLASSVARS '' VARS 'map'

"Encapsulates a map of providers to models.
 Communicated by the AI server to the client.

 A JSON example of the communication is:
	[	{ provider: 'OpenAI', models: [ 'gpt-4o-mini', ' gpt-4o' ] }
		{ provider: 'Deepseek', models: [ 'deepseek-chat' 'deepseek-reasoner' ] } ]"

CLASSMETHODS

fromObject: array
	| result provider models |

	result := self new.

	self assert: [ array class = Array ].
	array do: [ :object |
		provider := object atProperty: 'provider'.
		models := object atProperty: 'models'.
		result setProvider: provider models: models ].

	^ result.
!

METHODS

constructor
	map := Map new.
!

"Accessing"

providers
	^ self map keys.
!
modelsFor: provider
	^ map get: provider.
!
map
	^ map.
!
map: aMap
	map := aMap.
!
size
	^ map size.
!

"Converting"

toObject
	"Converts self to a ST object that can be converted to JSON.
	 See example above for the format."

	| result object |

	result := Array new.
	map forEach: [ :key : value |
		object := Object new.
		object atProperty: 'provider' put: key.
		object atProperty: 'models' put: value.
		result add: object ].

	^ result.
!

"Changeing"

setProvider: name models: models
	map set: name value: models.
!

"Converting"

toString
	"Only give providers, not models."
	| providersString |
	providersString := map keys join: ', '.
	^ 'AiProviders( ', providersString, ' )'.
!
