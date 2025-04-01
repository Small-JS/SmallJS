CLASS AnthropicUsage EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

cacheCreationInputTokens
 	^ Integer fromJs: INLINE 'this.js.cache_creation_input_tokens'.
!
cacheReadInputTokens
 	^ Integer fromJs: INLINE 'this.js.cache_read_input_tokens'.
!
inputTokens
 	^ Integer fromJs: INLINE 'this.js.input_tokens'.
!
outputTokens
 	^ Integer fromJs: INLINE 'this.js.output_tokens'.
!

