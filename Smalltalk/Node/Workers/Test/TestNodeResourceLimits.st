CLASS TestNodeResourceLimits EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

testNew
	| limits |
	limits := NodeResourceLimits new.
	self assert: [ limits class = NodeResourceLimits ].
	"Unset limits are nil, meaning: use the default."
	self assert: [ limits maxOldGenerationSizeMb isNil ].
	self assert: [ limits maxYoungGenerationSizeMb isNil ].
	self assert: [ limits codeRangeSizeMb isNil ].
	self assert: [ limits stackSizeMb isNil ].
!
testProperties
	| limits |
	limits := NodeResourceLimits new.

	limits maxOldGenerationSizeMb: 64.
	self assert: [ limits maxOldGenerationSizeMb = 64 ].
	limits maxYoungGenerationSizeMb: 16.
	self assert: [ limits maxYoungGenerationSizeMb = 16 ].
	limits codeRangeSizeMb: 32.
	self assert: [ limits codeRangeSizeMb = 32 ].
	limits stackSizeMb: 4.
	self assert: [ limits stackSizeMb = 4 ].

	"Fractional sizes are allowed."
	limits stackSizeMb: 0.5.
	self assert: [ limits stackSizeMb = 0.5 ].
!
async testWorker
	"A running worker reports its actual limits: set ones as given, others as defaults."
	| limits options worker actual exitCode |
	limits := NodeResourceLimits new.
	limits maxOldGenerationSizeMb: 48.
	limits stackSizeMb: 2.
	options := NodeWorkerOptions new.
	options eval: true; resourceLimits: limits.
	worker := NodeWorker new: 'setInterval( () => {}, 1000 );' options: options.
	await self online: worker.

	actual := worker resourceLimits.
	self assert: [ actual class = NodeResourceLimits ].
	self assert: [ actual maxOldGenerationSizeMb = 48 ].
	self assert: [ actual stackSizeMb = 2 ].
	self assert: [ actual maxYoungGenerationSizeMb > 0 ].
	self assert: [ actual codeRangeSizeMb >= 0 ].

	exitCode := await worker terminate.
	self assert: [ exitCode = 1 ].
	"After the worker has stopped, its limits are empty."
	self assert: [ worker resourceLimits maxOldGenerationSizeMb isNil ].
!
async online: worker
	INLINE 'await new Promise( ( resolve ) => worker.js.once( "online", resolve ) )'.
!
