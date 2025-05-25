CLASS AiChatRequest EXTENDS Object MODULE AiShared CLASSVARS '' VARS 'provider model messages'

CLASSMETHODS

fromObject: object
	^ self new
		provider: ( object atProperty: 'provider' );
		model: ( object atProperty: 'model' );
		messages: ( Object fromJson: ( object atProperty: 'messages' ) ).
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
	^ '?provider=', provider toString, '&model=', model toString, '&messages=', messages toJson.
!
toString
	^ 'AiChatRequest( provider: ', provider toString, ', model: ', model toString, ', messages: "', messages toString, '" )'.
!
