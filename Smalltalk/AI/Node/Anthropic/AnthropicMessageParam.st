CLASS AnthropicMessageParam EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

content
 	^ String fromJs: INLINE 'this.js.content'.
!
content: content
 	INLINE 'this.js.content = content.js'.
!
role
 	^ String fromJs: INLINE 'this.js.role'.
!
role: role
 	INLINE 'this.js.role = role.js'.
!
