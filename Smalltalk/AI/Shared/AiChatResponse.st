CLASS AiChatResponse EXTENDS Object MODULE AiShared CLASSVARS '' VARS 'success text'

CLASSMETHODS

fromObject: object
	^ self new
		success: ( object atProperty: 'success' );
		text: ( object atProperty: 'text' ).
!

METHODS

"Accessing"

success
	^ success.
!
success: aSuccess
	success := aSuccess.
!
text
	^ text.
!
text: aText
	text := aText.
!

"Converting"

toString
	^ 'AiChatResponse( success: ', success toString, ', text: "', text toString, '" )'.
!
