CLASS OllamaChatResponse EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

model
	^ String fromJs: INLINE 'this.js.model'.
!
createdAt
	^ Date fromJs: INLINE 'new Date( this.js.created_at )'.
!
message
	^ OllamaMessage fromJs: INLINE 'this.js.message'.
!
done
	^ Boolean fromJs: INLINE 'this.js.done'.
!
doneReason
	^ String fromJs: INLINE 'this.js.done_reason'.
!
loadDuration
	^ String fromJs: INLINE 'this.js.load_duration'.
!
promptEvalCount
	^ Integer fromJs: INLINE 'this.js.prompt_eval_count'.
!
promptEvalDuration
	^ Integer fromJs: INLINE 'this.js.prompt_eval_duration'.
!
totalDuration
	^ Integer fromJs: INLINE 'this.js.total_duration'.
!
evalCount
	^ Integer fromJs: INLINE 'this.js.eval_count'.
!
evalDuration
	^ Integer fromJs: INLINE 'this.js.eval_duration'.
!
