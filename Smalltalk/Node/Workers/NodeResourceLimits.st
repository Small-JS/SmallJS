CLASS NodeResourceLimits EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"Resource limits of a Node.js worker thread JS engine.
 Used in NodeWorkerOptions and returned by NodeWorker resourceLimits.
 A value of 0 (or nil) means: use the default.
 Values are an Integer or a Float."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

maxOldGenerationSizeMb
	"Maximum size of the main heap in MB."
	^ Object fromJs: INLINE 'this.js.maxOldGenerationSizeMb'.
!
maxOldGenerationSizeMb: size
	INLINE 'this.js.maxOldGenerationSizeMb = size.js'.
!
maxYoungGenerationSizeMb
	"Maximum size of the heap space for recently created objects in MB."
	^ Object fromJs: INLINE 'this.js.maxYoungGenerationSizeMb'.
!
maxYoungGenerationSizeMb: size
	INLINE 'this.js.maxYoungGenerationSizeMb = size.js'.
!
codeRangeSizeMb
	"Size of the pre-allocated memory range for generated code in MB."
	^ Object fromJs: INLINE 'this.js.codeRangeSizeMb'.
!
codeRangeSizeMb: size
	INLINE 'this.js.codeRangeSizeMb = size.js'.
!
stackSizeMb
	"Default maximum stack size of the thread in MB."
	^ Object fromJs: INLINE 'this.js.stackSizeMb'.
!
stackSizeMb: size
	INLINE 'this.js.stackSizeMb = size.js'.
!
