CLASS AiChatRequest EXTENDS Object MODULE AiShared CLASSVARS '' VARS 'provider model messages'

CLASSMETHODS

fromObject: object
	"Messages are nil when missing. Invalid messages JSON raises an error."
	| messagesJson |
	messagesJson := object atProperty: 'messages'.
	^ self new
		provider: ( object atProperty: 'provider' );
		model: ( object atProperty: 'model' );
		messages: ( messagesJson ifNotNil: [ Object fromJson: messagesJson ] ).
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

"Converting"

toUrlQuery
	^ '?provider=', ( self encode: provider toString ),
		'&model=', ( self encode: model toString ),
		'&messages=', ( self encode: messages toJson ).
!
encode: string
	"URL-encode string for use as a query parameter value."
	^ String fromJs: INLINE 'encodeURIComponent( string.js )'.
!
toString
	^ 'AiChatRequest( provider: ', provider toString, ', model: ', model toString, ', messages: "', messages toString, '" )'.
!
