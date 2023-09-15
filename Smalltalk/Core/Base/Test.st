CLASS Test EXTENDS Object MODULE Core CLASSVARS 'assertCount disabledModuleCount' VARS 'currentMethodName methodAssertCount'
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

	Test resetAssertCount.
	Test resetDisabledModuleCount.

	Class classes do: [ :aClass |
		( aClass inheritsFrom: Test ) ifTrue: [
			aClass new all ] ].

	self log: 'Successfully run sync tests: ', Test assertCount.

	Test resetAssertCount.
	Timer new timeout: 2000 then: [
		self log: 'Successfully run async tests: ', Test assertCount.
		self log: 'Disabled test modules: ', Test disabledModuleCount ].
!

"Accessing"

resetAssertCount
	assertCount := 0.
!
resetDisabledModuleCount
	disabledModuleCount := 0.
!
assertCount
	^ assertCount.
!
disabledModuleCount
	^ disabledModuleCount.
!

METHODS

enabled
	"Override this to conditionally disable tests."
	^ true.
!
all
	"Call all methods named 'test*' on self for enabled tests."
	self enabled
		ifFalse: [ Test disabledModuleCount increment ]
		ifTrue: [
			self class methodNames do: [ :methodName |
				( methodName startsWith: 'test' ) ifTrue: [
					currentMethodName := methodName.
					methodAssertCount := 0.
					self perform: methodName ] ] ]
!
assert: block
	methodAssertCount increment.
	Test assertCount increment.

	"If evaluation of block is not true, raise an error indicating the failed current test."

	block value = true ifFalse: [
		currentMethodName isNil ifTrue: [ currentMethodName := '<none>' ].
		self error: 'Test failed: ', self class name, '.', currentMethodName, ' #', methodAssertCount toString, ': ', block script ].
!
assertError: block
	"Evalute block expecting an error. If *no* error occurs, then raise an error."
	self assert: [ ( block valueOnError: [ :error | error ] ) class = Error ].
!
