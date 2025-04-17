CLASS OpenaiChatCompletionRequest EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

model: model
	INLINE 'this.js.model = model.js'.
!
addRole: role content: content
	INLINE 'if( ! this.js.messages ) this.js.messages = []'.
	INLINE 'this.js.messages.push( { role: role.js, content: content.js } )'.
!
