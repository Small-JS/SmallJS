CLASS TodoApp EXTENDS Object MODULE Todo CLASSVARS ''
	VARS 'tasks newTaskTitleInput newTaskDueInput newTaskAddButton taskTable'

start
	self bindElements.
	self loadTasks.
	self showTasks
!
bindElements
	"Bind HTML elements to vars, set defaults, set event listeners."

	newTaskTitleInput := Document default getElementById: 'newTaskTitleInput'.
	newTaskTitleInput value: 'New task'.

	newTaskDueInput := Document default getElementById: 'newTaskDueInput'.
	newTaskDueInput value: ( Date new toIsoString substring: 0 to: 10 ).

	newTaskAddButton := Document default getElementById: 'newTaskAddButton'.
	newTaskAddButton addEventListener: 'click' then: [ self addNewTask ].

	taskTable := Document default getElementById: 'taskTable'.
	taskTable addEventListener: 'click' then: [ :event | self taskTableClicked: event ].
!
loadTasks
	"Load some generated tasks into tasks array."

	| due task |
	tasks := Array new.
	due := Date new.
	#( 'Code' 'Test' 'Release' ) do: [ :title |
		due day: due day + title length.
		task := Task new title: title; due: due copy.
		tasks add: task ].
!
showTasks
	"Show tasks array on HTML page."

	| deleteString row |

	deleteString := String fromCharCode: 10005.

	taskTable tBody innerHtml: ''.
	tasks do: [ :task |
		row := taskTable tBody insertRow: -1.
		row insertCell textContent: task title.
		row insertCell textContent: task dueString.
		row insertCell textContent: task doneString.
		row insertCell textContent: deleteString.
	].
!
addNewTask
	"Create new task from its input elements,
	 add it to the tasks array and update the list in the page."

	| task |
	task := Task new
		title: newTaskTitleInput value;
		due: newTaskDueInput valueAsDate.

	tasks add: task.

	self showTasks.
!
taskTableClicked: event
	"Process task table click actions, which can be:
		- Done cell clicked > Toggle done value.
		- Delete cell clicked > Remove task."

	| cell position |
	cell := HtmlElement fromJsSubElement: event target js.
	cell class = HtmlTableCellElement ifTrue: [
		position := Point x: cell cellIndex y: cell parentElement rowIndex.
		cell cellIndex = 2 ifTrue: [ self toggleTaskDone: position cell: cell ].
		cell cellIndex = 3 ifTrue: [ self deleteTask: position ] ].
!
toggleTaskDone: position cell: cell
	"Toggle done value of task at position and update table."

	| task |
	task := tasks at: position y - 2.
	task done: task done not.
	cell textContent: task doneString.
!
deleteTask: position
	"Delete task at position and update table."

	tasks removeAt: position y - 2.
	taskTable deleteRow: position y.
!
