CLASS Test EXTENDS Object MODULE Core CLASSVARS 'globalAssertCount disabledModuleCount' VARS 'currentMethodName methodAssertCount'
	"Base class for all unit test classes.
	 Class method testAll calls all test* methods in subclasses.
	 test* methods should call assert: [...] with the block returning the result as a boolean expression of a specific test.
	 Example: 'self assert: [ 2 < 3 ]'
	 The tester throws an error: if a test fails and stops testing."

CLASSMETHODS

"Testing"

all
	self allThen: [].
!
allThen: block
	| aClass |
	"Invokes all test* methods on new instances of all Test* subclasses loaded.
	 Returns the number of test passed.
	 Throws an error if any test fails.
	 Evaluates block after async tests have run."

	self log: 'Running unit tests...'.

	Test resetAssertCount.
	Test resetDisabledModuleCount.

	Class classes do: [ :aClass |
		( aClass inheritsFrom: Test ) ifTrue: [
			aClass new all ] ].

	self log: 'Successfully run sync tests: ', Test globalAssertCount.

	Test resetAssertCount.
	Timer timeout: 2000 then: [
		self log: 'Successfully run async tests: ', Test globalAssertCount.
		self log: 'Disabled test modules: ', Test disabledModuleCount.
		block value ].
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
	"Call all methods named 'test*' on self for tests not disabled."
	self disabled
		ifTrue: [ Test disabledModuleCount increment ]
		ifFalse: [
			self class methodNames do: [ :methodName |
				 ( self isTestMethod: methodName ) ifTrue: [
					currentMethodName := methodName.
					methodAssertCount := 0.
					self perform: methodName ] ] ]
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
