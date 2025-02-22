CLASS OpenaiCompletionUsage EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

"This class also implements TS interfaces:
 CompletionTokensDetails, PromptTokensDetails"

completionTokens
 	^ Integer fromJs: INLINE 'this.js.completion_tokens'.
!
promptTokens
 	^ Integer fromJs: INLINE 'this.js.prompt_tokens'.
!
totalTokens
 	^ Integer fromJs: INLINE 'this.js.total_tokens'.
!

"CompletionTokensDetails"

completionAcceptedPredictionTokens
 	^ Integer fromJs: INLINE 'this.js.completion_tokens_details.accepted_prediction_tokens'.
!
completionAudioTokens
 	^ Integer fromJs: INLINE 'this.js.completion_tokens_details.audio_tokens'.
!
completionReasoningTokens
 	^ Integer fromJs: INLINE 'this.js.completion_tokens_details.reasoning_tokens'.
!
completionRejectedPredictionTokens
 	^ Integer fromJs: INLINE 'this.js.completion_tokens_details.rejected_prediction_tokens'.
!

"PromptTokensDetails"

promptAudioTokens
 	^ Integer fromJs: INLINE 'this.js.prompt_tokens_details.audio_tokens'.
!
promptCachedTokens
 	^ Integer fromJs: INLINE 'this.js.prompt_tokens_details.cached_tokens'.
!
