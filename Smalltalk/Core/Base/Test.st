CLASS Test EXTENDS Object MODULE Core CLASSVARS 'globalAssertCount' VARS 'currentMethodName methodAssertCount'
	"Base class for all unit test classes.
	 Class method testAll calls all test* methods in subclasses.
	 test* methods should call assert: [...] with the block returning the result as a boolean expression of a specific test.
	 Example: 'self assert: [ 2 < 3 ]'
	 The tester throws an error: if a test fails and stops testing."

CLASSMETHODS

"Testing"

all
	"Invokes all test* methods on new instances of all Test* subclasses.
	 Returns the number of test passed.
	 Throws an error if any test fails."

	Test globalAssertCount: 0.

	Class classes do: [ :aClass |
		( aClass inheritsFrom: Test ) ifTrue: [
			aClass new all ] ].

	self log: 'Successfully run sync tests: ', Test globalAssertCount.

	Test globalAssertCount: 0.
	Timer new timeout: 2000 then: [ self allAsync ].
!
allAsync
	self log: 'Successfully run async tests: ', Test globalAssertCount.
!

"Accessing"

globalAssertCount
	^ globalAssertCount.
!
globalAssertCount: aglobalAssertCount
	globalAssertCount := aglobalAssertCount.
!

METHODS

browserOnly
	"Override this with returning true in subclasses that can only run in a browser."
	^ false.
!
enabled
	"Override this to conditionally disable tests."
	^ true.
!
isBrowser
	"Return true of this calss is running in a browser."
	^ Boolean fromJs: INLINE 'typeof window !== `undefined`'.
!
all
	"self log: 'Testing class: ', self class name."

	self enabled & ( self browserOnly not | self isBrowser ) ifTrue: [
		"Call all methods named 'test*' on self."
		self class methodNames do: [ :methodName |
			( methodName startsWith: 'test' ) ifTrue: [
				currentMethodName := methodName.
				methodAssertCount := 0.
				self perform: methodName ] ] ].

!
assert: block
	methodAssertCount increment.
	Test globalAssertCount increment.

	"If evaluation of block is not true, raise an error indicating the failed current test."

	block value = true ifFalse: [
		currentMethodName isNil ifTrue: [ currentMethodName := '<none>' ].
		self error: 'Test failed: ', self class name, '.', currentMethodName, ' #', methodAssertCount toString, ': ', block script ].
!
assertError: block
	"Evalute block expecting an error. If *no* error occurs, then raise an error."
	self assert: [ ( block valueOnError: [ :error | error ] ) class = Error ].
!
