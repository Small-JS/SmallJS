CLASS AiChatRequest EXTENDS Object MODULE AiShared CLASSVARS '' VARS 'provider model messages'

"A chat request from the AI client to the AI server, sent as JSON body of a POST request.
 The messages are Strings that alternate user questions and AI answers,
 starting with a question, so the last message is the new question.
 This gives the AI the context of the whole conversation.

 A JSON example of the communication is:
	{ provider: 'openai', model: 'gpt-4o', messages: [ 'Hi', 'Hello, how can I help?', 'Say this is a test' ] }"

CLASSMETHODS

fromObject: object
	"Missing properties give nil."
	^ self new
		provider: ( object atProperty: 'provider' );
		model: ( object atProperty: 'model' );
		messages: ( object atProperty: 'messages' ).
!
METHODS

constructor
	messages := #().
!

"Accessing"

provider
	^ provider.
!
provider: aProvider
	provider := aProvider.
!
model
	^ model.
!
model: aModel
	model := aModel.
!
messages
	^ messages.
!
messages: aTexts
	messages := aTexts.
!

"Validating"

messagesError
	"Answer a description of what is wrong with the messages, or nil if they are valid:
	 a non-empty array of Strings with an odd number of elements, so it ends with a question."
	messages ifNil: [ ^ 'missing' ].
	( messages isKindOf: Array ) ifFalse: [ ^ 'not an array' ].
	( messages every: [ :message | message isKindOf: String ] ) ifFalse: [ ^ 'not an array of strings' ].
	messages length odd ifFalse: [ ^ 'not ending with a question' ].
	^ nil.
!

"Converting"

toObject
	"Converts self to a ST object that can be converted to JSON.
	 See example above for the format."
	^ Object new
		atProperty: 'provider' put: provider;
		atProperty: 'model' put: model;
		atProperty: 'messages' put: messages.
!
toString
	^ 'AiChatRequest( provider: ', provider toString, ', model: ', model toString, ', messages: "', messages toString, '" )'.
!
