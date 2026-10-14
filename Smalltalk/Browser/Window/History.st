CLASS History EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: History, for the session history of the current window.
 Get the singleton with: History default, or: Window default history.
 State objects are converted to JS with toJs, and back to ST with Object fromJs:,
 so they should be values like Strings, Numbers, Booleans, Arrays and nil."

CLASSMETHODS

default
	"Return the history singleton of the current window."
	^ Window default history.
!

METHODS

"Properties."

length
	"Return the number of entries in the session history."
	^ Integer fromJs: INLINE 'this.js.length'.
!
scrollRestoration
	"Return one of: 'auto' 'manual'."
	^ String fromJs: INLINE 'this.js.scrollRestoration'.
!
scrollRestoration: scrollRestoration
	INLINE 'this.js.scrollRestoration = scrollRestoration.js'.
!
state
	"Return the state of the current history entry, or nil."
	^ Object fromJs: INLINE 'this.js.state'.
!

"Methods."

back
	"Go to the previous entry. This is asynchronous, the window receives a 'popstate' event."
	INLINE 'this.js.back()'.
!
forward
	"Go to the next entry. This is asynchronous, the window receives a 'popstate' event."
	INLINE 'this.js.forward()'.
!
go: delta
	"Go delta entries forward, or backward if negative. Zero reloads the page."
	INLINE 'this.js.go( delta.js )'.
!
pushState: state
	"Add an entry with state for the current URL."
	INLINE 'this.js.pushState( state.$toJs(), "" )'.
!
pushState: state url: url
	"Add an entry with state and URL. The URL must have the same origin as the current one."
	INLINE 'this.js.pushState( state.$toJs(), "", url.js )'.
!
replaceState: state
	"Replace the state of the current entry."
	INLINE 'this.js.replaceState( state.$toJs(), "" )'.
!
replaceState: state url: url
	"Replace the state and URL of the current entry.
	 The URL must have the same origin as the current one."
	INLINE 'this.js.replaceState( state.$toJs(), "", url.js )'.
!
