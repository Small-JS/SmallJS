CLASS Test EXTENDS Object MODULE Core CLASSVARS 'globalAssertCount disabledModuleCount' VARS 'currentMethodName methodAssertCount'
	"Base class for all unit test classes.
	 Class method testAll calls all test* methods in subclasses.
	 test* methods should call assert: [...] with the block returning the result as a boolean expression of a specific test.
	 Example: 'self assert: [ 2 < 3 ]'
	 The tester throws an error: if a test fails and stops testing."

CLASSMETHODS

"Testing"

async all
	| aClass promises settling statuses failures |
	"Invokes all test* methods on new instances of all Test* subclasses loaded.
	 Returns the number of test passed.
	 Throws an error if any test fails.
	 Async test methods are awaited, up to asyncTimeout milliseconds."

	self log: 'Running unit tests...'.
	Test resetDisabledModuleCount.

	"Sync tests"
	Test resetAssertCount.
	promises := Array new.
	Class classes do: [ :aClass |
		( aClass inheritsFrom: Test ) ifTrue: [
			aClass new all do: [ :promise | promises add: promise ] ] ].
	self log: 'Successfully run sync tests: ', Test globalAssertCount.

	"Async tests. The minimum wait is for tests that do not return their promise, e.g. using Timer timeout:then:."
	"Settling starts before the wait, so rejections are handled, not reported as unhandled."
	Test resetAssertCount.
	settling := self settle: promises timeout: self asyncTimeout.
	await Timer timeout: 2000.
	statuses := await settling.
	statuses ifNil: [
		self log: 'Warning: Async tests not finished within milliseconds: ', self asyncTimeout toString ].
	statuses ifNotNil: [
		failures := statuses filter: [ :status | status status = 'rejected' ].
		failures do: [ :status |
			self log: 'Async test failed: ', ( String fromJs: INLINE 'String( status.js.reason )' ) ].
		failures isEmpty ifFalse: [
			self error: 'Async tests failed: ', failures length toString ] ].
	self log: 'Successfully run async tests: ', Test globalAssertCount.

	"Disabled modules"
	self log: 'Disabled test modules: ', Test disabledModuleCount.
!
asyncTimeout
	"Maximum time in milliseconds to wait for async tests, e.g. tests calling external APIs."
	^ 60000.
!
async settle: promises timeout: timeout
	"Answer the PromiseStatus of each promise when all have settled,
	 or nil if they have not all settled within timeout milliseconds."
	| jsStatuses |
	jsStatuses := INLINE 'await ( async () => {
		let timer;
		const timeoutPromise = new Promise( resolve => { timer = setTimeout( () => resolve( null ), timeout.js ) } );
		const result = await Promise.race( [ Promise.allSettled( promises.$toJs() ), timeoutPromise ] );
		clearTimeout( timer );
		return result } )()'.
	( Boolean fromJs: INLINE 'jsStatuses === null' ) ifTrue: [ ^ nil ].
	^ Array fromJs: jsStatuses elementClass: PromiseStatus.
!

"Accessing"

resetAssertCount
	globalAssertCount := 0.
!
resetDisabledModuleCount
	disabledModuleCount := 0.
!
globalAssertCount
	globalAssertCount isNil ifTrue: [ globalAssertCount := 0 ].
	^ globalAssertCount.
!
disabledModuleCount
	disabledModuleCount isNil ifTrue: [ disabledModuleCount := 0 ].
	^ disabledModuleCount.
!

METHODS

constructor
	currentMethodName := ''.
	methodAssertCount := 0.
!

disabled
	"Override this to conditionally disable tests."
	^ false.
!
all
	"Call all methods named 'test*' on self for tests not disabled.
	 Answer the promises returned by async test methods."
	| promises result |
	promises := Array new.
	self disabled
		ifTrue: [ Test disabledModuleCount increment ]
		ifFalse: [
			self class methodNames do: [ :methodName |
				 ( self isTestMethod: methodName ) ifTrue: [
					currentMethodName := methodName.
					methodAssertCount := 0.
					result := self perform: methodName.
					( Boolean fromJs: INLINE 'result instanceof Promise' ) ifTrue: [
						promises add: ( Promise fromJs: result ) ] ] ] ].
	^ promises.
!
isTestMethod: methodName
	^ ( methodName startsWith: 'test' ) and: [ ( methodName endsWith: ':' ) not ]
!
assert: block
	methodAssertCount increment.
	Test globalAssertCount increment.

	"If evaluation of block is not true, raise an error indicating the failed current test."
	block value = true ifFalse: [
		currentMethodName isNil ifTrue: [ currentMethodName := '<unknown>' ].
		self error: 'Test failed: ', self class name, '.', currentMethodName, ' #', methodAssertCount toString, ': ', block script ].
!
assertError: block
	"Evalute block expecting an error. If *no* error occurs, then raise an error."
	self assert: [ ( block tryCatch: [ :error | error ] ) class = Error ].
!
async assertAsync: asyncBlock
	methodAssertCount increment.
	Test globalAssertCount increment.

	( await asyncBlock value ) = true ifFalse: [
		currentMethodName isNil ifTrue: [ currentMethodName := '<unknown>' ].
		self error: 'Test failed: ', self class name, '.', currentMethodName, ' #', methodAssertCount toString, ': ', asyncBlock script ].
!
