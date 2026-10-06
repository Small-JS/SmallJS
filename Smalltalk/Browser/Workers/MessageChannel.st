CLASS MessageChannel EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"Implements JS MessageChannel: a channel with 2 entangled MessagePorts.
 A message posted on one port is received on the other port."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new MessageChannel()'.
!

METHODS

port1
	^ MessagePort fromJs: INLINE 'this.js.port1'.
!
port2
	^ MessagePort fromJs: INLINE 'this.js.port2'.
!
