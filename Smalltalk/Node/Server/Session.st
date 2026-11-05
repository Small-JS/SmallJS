CLASS Session EXTENDS JsObject MODULE Server CLASSVARS '' VARS ''
	"Implements the Session class from Express."

"Getter and setter convenience methods."

get: name
	^ self atJsProperty: name.
!
set: name to: value
	^ self atJsProperty: name put: value.
!
id
	^ String fromJs: INLINE 'this.js.id'.
!

"Session management."

async regenerate
	"Replace the session with a new one, with a new ID and without data.
	 Call this on login, to prevent session fixation.
	 Afterwards, get the new session again with: IncomingMessage>>session."
	INLINE 'await new Promise( ( resolve, reject ) =>
		this.js.regenerate( error => error ? reject( error ) : resolve() ) )'.
!
