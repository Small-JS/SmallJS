CLASS AiFactory EXTENDS JsObject MODULE AiFactory CLASSVARS '' VARS ''

CLASSMETHODS

"Creation"

new: name
	^ ( self classNamed: name ) new.
!

"Providers"

aiClasses
	^ #( Ollama Openai Deepseek Googleai Anthropic ).
!
classNamed: name
	| class |
	name := name toLowerCase.
	class := self aiClasses find: [ :aClass | aClass name toLowerCase = name ].
	class ifNil: [
		self error: 'Unknown AI class name: ', name ].
	^ class.
!
providers
	"Return available AI providers as an instance of AiProviders,
	 loaded from environment variables."
	| providers |

	providers := AiProviders new.

	self aiClasses do: [ :class |
		class available ifTrue: [
			providers setProvider: class name toLowerCase models: class models  ] ].

	^ providers.
!
available: name
	"Return true if the API key is set for the named AI."
	^ ( self classNamed: name ) available.
!
