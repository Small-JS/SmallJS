CLASS AiChatRequest EXTENDS Object MODULE AiShared CLASSVARS '' VARS 'provider model text'

CLASSMETHODS

fromObject: object
	^ self new
		provider: ( object atProperty: 'provider' );
		model: ( object atProperty: 'model' );
		text: ( object atProperty: 'text' ).
!
METHODS

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
text
	^ text.
!
text: aText
	text := aText.
!

"Converting"

toUrlQuery
	^ '?provider=', provider toString, '&model=', model toString, '&text="', text toString, '"'.
!
toString
	^ 'AiChatRequest( provider: ', provider toString, ', model: ', model toString, ', text: "', text toString, '" )'.
!
