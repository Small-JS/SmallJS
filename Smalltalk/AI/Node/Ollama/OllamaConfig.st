CLASS OllamaConfig EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty
		host: ( Environment at: 'OLLAMA_BASE_URL' ).
!

METHODS

host
	^ String fromJs: INLINE 'this.js.host'.
!
host: host
	INLINE 'this.js.host = host.js'.
!
