CLASS LoginResult EXTENDS Object MODULE ShopServer CLASSVARS '' VARS 'success message'

CLASSMETHODS

success: success message: message
	^ self new success: success; message: message.
!
fromObject: object
	^ self new
		success: ( object atProperty: 'success' );
		message: ( object atProperty: 'message' ).
!

METHODS

success
	^ success.
!
success: aSuccess
	success := aSuccess.
!
message
	^ message.
!
message: aMessage
	message := aMessage.
!
