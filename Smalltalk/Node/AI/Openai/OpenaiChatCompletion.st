CLASS OpenaiChatCompletion EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

id
	^ String fromJs: INLINE 'this.js.id'.
!
choices
	^ Array fromJs: INLINE 'this.js.choices' elementClass: OpenaiChatCompletionChoice.
!
created
	"Note: This converts the OpenAI seconds integer to a Date object."
	^ Date fromSeconds: ( Integer fromJs: INLINE 'this.js.created' ).
!
model
	^ String fromJs: INLINE 'this.js.model'.
!
object
	^ String fromJs: INLINE 'this.js.object'.
!
serviceTier
	^ String fromJs: INLINE 'this.js.service_tier'.
!
systemFingerprint
	^ String fromJs: INLINE 'this.js.system_fingerprint'.
!
usage
	^ OpenaiCompletionUsage fromJs: INLINE 'this.js.usage'.
!
