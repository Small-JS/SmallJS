CLASS TestTodoApp EXTENDS Object MODULE TestTodo CLASSVARS '' VARS 'todoApp'

"Test TodoApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

references
	"Prevent minimizing of unit tests."
	TestTask.
!
async test: aTodoApp
	todoApp := aTodoApp.

	"Run sync and async tests of all imported Test* classes and log results."
	await Test all.
	await self testGui.
!
async testGui
	"Click increase counter button 2 times then click reset.
	 For every click check if counter label is updated correctly.
	 Exit if all tests succeed."

	self testTasksLoaded.
	await self testAddNewTask.
	await self testCompleteTask.
	await self testDeleteTask.
	await self testSortTasks.
	await self testLanguage.

	await self stop.
!
testTasksLoaded
	self assert: [ todoApp taskTable tBody rows length = todoApp tasks length ].
!
async testAddNewTask
	| expectedTaskCount |
	expectedTaskCount := todoApp tasks length + 1.

	todoApp newTaskAddButton click.
	await Timer timeout: 1000.
	self assert: [ todoApp tasks length = expectedTaskCount ].
	self assert: [ todoApp taskTable tBody rows length = expectedTaskCount ].
	self assert: [ ( todoApp taskTable tBody rows last cells at: 0 ) textContent = todoApp tasks last title ].
!
async testCompleteTask
	self assert: [ todoApp tasks last done not ].
	self assert: [ ( todoApp taskTable tBody rows last cells at: 2 ) textContent = todoApp tasks last doneString ].

	( todoApp taskTable tBody rows last cells at: 2 ) click.
	await Timer timeout: 1000.
	self assert: [ todoApp tasks last done ].
	self assert: [ ( todoApp taskTable tBody rows last cells at: 2 ) textContent = todoApp tasks last doneString ].
!
async testDeleteTask
	| expectedTaskCount |
	expectedTaskCount := todoApp tasks length - 1.

	( todoApp taskTable tBody rows last cells at: 3 ) click.
	await Timer timeout: 1000.
	self assert: [ todoApp tasks length = expectedTaskCount ].
	self assert: [ todoApp taskTable tBody rows length = expectedTaskCount ].
!
async testSortTasks
	| lastTaskTitle |
	lastTaskTitle := todoApp tasks last title.

	( todoApp taskTable tHead rows at: 1 ) cells first click.
	await Timer timeout: 1000.
	self assert: [ todoApp tasks last title ~= lastTaskTitle ].
	self assert: [ todoApp taskTable tBody rows last cells first textContent ~= lastTaskTitle ].
	self assert: [ todoApp taskTable tBody rows last cells first textContent = todoApp tasks last title ].
!
async testLanguage
	"Select second language (Spanish) and check of GUI changed to it."

	| changeEvent titleSpan |

	todoApp languageSelect selectedIndex: 1.
	changeEvent := Event type: 'change'.
	todoApp languageSelect dispatchEvent: changeEvent.

	await Timer timeout: 1000.
	titleSpan := Document getElementById: 'titleSpan' class: HtmlSpanElement.
	self assert: [ titleSpan textContent = 'Hacer' ].
!
async stop
	await Timer timeout: 1000 then: [
		todoApp stop ].
!
