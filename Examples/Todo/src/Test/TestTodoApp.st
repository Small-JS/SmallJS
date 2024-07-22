CLASS TestTodoApp EXTENDS Object MODULE TestTodo CLASSVARS '' VARS 'todoApp'

"Test TodoApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

references
	"Prevent minimizing of unit tests."
	TestTask.
!
test: aTodoApp
	todoApp := aTodoApp.

	"Run sync and async tests of all imported Test* classes and log results."
	Test allThen: [
		self testGui ].
!
testGui
	"Click increase counter button 2 times then click reset.
	 For every click check if counter label is updated correctly.
	 Exit if all tests succeed."

	self testTasksLoaded.
	self testAddNewTaskThen: [
		self testCompleteTaskThen: [
			self testDeleteTaskThen: [
				self testSortTasksThen: [
					self testLanguageThen: [
						self stop ] ] ] ] ].
!
testTasksLoaded
	self assert: [ todoApp taskTable tBody rows length = todoApp tasks length ].
!
testAddNewTaskThen: block
	| expectedTaskCount |
	expectedTaskCount := todoApp tasks length + 1.

	todoApp newTaskAddButton click.
	Timer timeout: 1000 then: [
		self assert: [ todoApp tasks length = expectedTaskCount ].
		self assert: [ todoApp taskTable tBody rows length = expectedTaskCount ].
		self assert: [ ( todoApp taskTable tBody rows last cells at: 0 ) textContent = todoApp tasks last title ].

		block value ].
!
testCompleteTaskThen: block
	self assert: [ todoApp tasks last done not ].
	self assert: [ ( todoApp taskTable tBody rows last cells at: 2 ) textContent = todoApp tasks last doneString ].

	( todoApp taskTable tBody rows last cells at: 2 ) click.
	Timer timeout: 1000 then: [
		self assert: [ todoApp tasks last done ].
		self assert: [ ( todoApp taskTable tBody rows last cells at: 2 ) textContent = todoApp tasks last doneString ].

		block value ].
!
testDeleteTaskThen: block
	| expectedTaskCount |
	expectedTaskCount := todoApp tasks length - 1.

	( todoApp taskTable tBody rows last cells at: 3 ) click.
	Timer timeout: 1000 then: [
		self assert: [ todoApp tasks length = expectedTaskCount ].
		self assert: [ todoApp taskTable tBody rows length = expectedTaskCount ].

		block value ].
!
testSortTasksThen: block
	| lastTaskTitle |
	lastTaskTitle := todoApp tasks last title.

	( todoApp taskTable tHead rows at: 1 ) cells first click.
	Timer timeout: 1000 then: [
		self assert: [ todoApp tasks last title ~= lastTaskTitle ].
		self assert: [ todoApp taskTable tBody rows last cells first textContent ~= lastTaskTitle ].
		self assert: [ todoApp taskTable tBody rows last cells first textContent = todoApp tasks last title ].

		block value ].
!
testLanguageThen: block
	"Select second language (Spanish) and check of GUI changed to it."

	| languageName inputEvent titleSpan |

	languageName := ( todoApp languageDataList children at: 1 ) value.
	todoApp languageInput value: languageName.
	inputEvent := Event type: 'input'.
	todoApp languageInput dispatchEvent: inputEvent.

	Timer timeout: 1000 then: [
		titleSpan := Document getElementById: 'titleSpan' class: HtmlSpanElement.
		self assert: [ titleSpan textContent = 'Hacer' ].
		block value ].
!
stop
	Timer timeout: 1000 then: [
		todoApp stop ].
!
