CLASS FileRmOptions EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

force
	^ Boolean fromJs: INLINE 'this.js.force'.
!
force: force
	INLINE 'this.js.force = force.js'.
!
recursive
	^ Boolean fromJs: INLINE 'this.js.recursive'.
!
recursive: recursive
	INLINE 'this.js.recursive = recursive.js'.
!
retryDelay
	^ Integer fromJs: INLINE 'this.js.retryDelay'.
!
retryDelay: retryDelay
	INLINE 'this.js.retryDelay = retryDelay.js'.
!
maxRetries
	^ Integer fromJs: INLINE 'this.js.maxRetries'.
!
maxRetries: maxRetries
	INLINE 'this.js.maxRetries = maxRetries.js'.
!
