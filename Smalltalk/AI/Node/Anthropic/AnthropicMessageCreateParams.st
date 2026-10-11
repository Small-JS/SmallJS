CLASS AnthropicMessageCreateParams EXTENDS JsObject MODULE AiAnthropic CLASSVARS '' VARS ''

"This class implements JS interfaces: MessageCreateParamsNonStreaming, MessageCreateParamsStreaming"

CLASSMETHODS

new
	^ self newEmpty
		stream: false.
!

METHODS

maxTokens: maxTokens
	INLINE 'this.js.max_tokens = maxTokens.js'.
!
maxTokens
 	^ Integer fromJs: INLINE 'this.js.max_tokens'.
!
messages: messages
	INLINE 'this.js.messages = messages.$toJs()'.
!
messages
	^ Array fromJs: INLINE 'this.js.messages' elementClass: AnthropicMessageParam.
!
model: model
	INLINE 'this.js.model = model.js'.
!
model
 	^ String fromJs: INLINE 'this.js.model'.
!
stream: stream
	INLINE 'this.js.stream = stream.js'.
!
stream
 	^ Boolean fromJs: INLINE 'this.js.stream'.
!
temperature: temperature
	INLINE 'this.js.temperature = temperature.js'.
!
temperature
 	^ Float fromJs: INLINE 'this.js.temperature'.
!

cacheControl: cacheControl
	"Object, e.g. type: 'ephemeral', ttl: '5m'"
	INLINE 'this.js.cache_control = cacheControl.$toJs()'.
!
cacheControl
 	^ Object fromJs: INLINE 'this.js.cache_control'.
!
container: container
	"Container id String, or Object with id and skills"
	INLINE 'this.js.container = container.$toJs()'.
!
container
 	^ Object fromJs: INLINE 'this.js.container'.
!
diagnostics: diagnostics
	"Object with diagnostics settings"
	INLINE 'this.js.diagnostics = diagnostics.$toJs()'.
!
diagnostics
 	^ Object fromJs: INLINE 'this.js.diagnostics'.
!
inferenceGeo: inferenceGeo
	INLINE 'this.js.inference_geo = inferenceGeo.js'.
!
inferenceGeo
 	^ String fromJs: INLINE 'this.js.inference_geo'.
!
metadata: metadata
	"Object, e.g. user_id: 'my-user-id'"
	INLINE 'this.js.metadata = metadata.$toJs()'.
!
metadata
 	^ Object fromJs: INLINE 'this.js.metadata'.
!
outputConfig: outputConfig
	"Object, e.g. effort: 'low'"
	INLINE 'this.js.output_config = outputConfig.$toJs()'.
!
outputConfig
 	^ Object fromJs: INLINE 'this.js.output_config'.
!
serviceTier: serviceTier
	"One of: 'auto', 'standard_only'"
	INLINE 'this.js.service_tier = serviceTier.js'.
!
serviceTier
 	^ String fromJs: INLINE 'this.js.service_tier'.
!
stopSequences: stopSequences
	"Array of Strings"
	INLINE 'this.js.stop_sequences = stopSequences.$toJs()'.
!
stopSequences
 	^ Array fromJs: INLINE 'this.js.stop_sequences' elementClass: String.
!
system: system
	"String, or Array of text block Objects"
	INLINE 'this.js.system = system.$toJs()'.
!
system
 	^ Object fromJs: INLINE 'this.js.system'.
!
thinking: thinking
	"Object, e.g. type: 'adaptive' or type: 'enabled', budget_tokens: 2048"
	INLINE 'this.js.thinking = thinking.$toJs()'.
!
thinking
 	^ Object fromJs: INLINE 'this.js.thinking'.
!
toolChoice: toolChoice
	"Object, e.g. type: 'auto'"
	INLINE 'this.js.tool_choice = toolChoice.$toJs()'.
!
toolChoice
 	^ Object fromJs: INLINE 'this.js.tool_choice'.
!
tools: tools
	"Array of tool definition Objects"
	INLINE 'this.js.tools = tools.$toJs()'.
!
tools
 	^ Object fromJs: INLINE 'this.js.tools'.
!
topK: topK
	INLINE 'this.js.top_k = topK.js'.
!
topK
 	^ Integer fromJs: INLINE 'this.js.top_k'.
!
topP: topP
	INLINE 'this.js.top_p = topP.js'.
!
topP
 	^ Float fromJs: INLINE 'this.js.top_p'.
!
userProfileId: userProfileId
	INLINE 'this.js.user_profile_id = userProfileId.js'.
!
userProfileId
 	^ String fromJs: INLINE 'this.js.user_profile_id'.
!
workspaceId: workspaceId
	INLINE 'this.js.workspace_id = workspaceId.js'.
!
workspaceId
 	^ String fromJs: INLINE 'this.js.workspace_id'.
!
