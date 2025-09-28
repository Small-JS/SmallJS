CLASS ProcessConfig EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"Accessors from condig objects are not imlemented.
 Use 'atJsProperty:' to access their properties."

variables
	^ JsObject fromJs: INLINE 'this.js.variables'.
!
targetDefaults
	^ JsObject fromJs: INLINE 'this.js.target_defaults'.
!
