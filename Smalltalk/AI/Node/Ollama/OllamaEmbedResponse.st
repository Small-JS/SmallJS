CLASS OllamaEmbedResponse EXTENDS JsObject MODULE AiOllama CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

model
	^ String fromJs: INLINE 'this.js.model'.
!
embedding
	^ Array fromJs: INLINE 'this.js.embeddings[ 0 ]' elementClass: Float.
!
totalDuration
	^ Integer fromJs: INLINE 'this.js.total_duration'.
!
loadDuration
	^ Integer fromJs: INLINE 'this.js.load_duration'.
!
promptEvalCount
	^ Integer fromJs: INLINE 'this.js.prompt_eval_count'.
!
