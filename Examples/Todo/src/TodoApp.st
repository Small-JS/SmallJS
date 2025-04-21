CLASS TodoApp EXTENDS BrowserApp MODULE Todo CLASSVARS ''
	VARS 'language tasks
		languageSelect
		newTaskTitleInput newTaskDueInput newTaskAddButton
		taskTable sortColumn sortDescending'

start
	self bindElements.
	self loadDefaultLanguage.
	self loadTasks.
	self showTasks.

	self testMode ifTrue: [
		TestTodoApp new test: self ].
!
bindElements
	"Bind HTML elements to vars, set defaults, set event listeners."

	languageSelect := Document getElementById: 'languageSelect' class: HtmlSelectElement.
	languageSelect addEventListener: 'change' then: [ self loadLanguage ].

	newTaskTitleInput := Document getElementById: 'newTaskTitleInput' class: HtmlInputElement.
	newTaskTitleInput value: 'New task'.

	newTaskDueInput := Document getElementById: 'newTaskDueInput' class: HtmlInputElement.
	newTaskDueInput value: ( Date new toIsoString substring: 0 to: 10 ).

	newTaskAddButton := Document getElementById: 'newTaskAddButton' class: HtmlButtonElement.
	newTaskAddButton onClick: [ self addNewTask ].

	taskTable := Document getElementById: 'taskTable' class: HtmlTableElement.
	taskTable onClick: [ :event | self taskTableClicked: event ].
!
loadDefaultLanguage
	| languageId |
	language := Language supported: #( 'en-US' 'es' ).
	languageId := languageSelect selectedValue.
	language load: languageId.
!
loadLanguage
	| index |
	index := languageSelect selectedIndex.
	index >= 0 ifTrue: [
		language load: ( language supported at: index ) ].
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
	cell class ~= HtmlTableCellElement ifTrue: [
		cell := cell parentElement ].
	position := Point x: cell cellIndex y: cell parentElement rowIndex.

	"These actions check themselves if they should be activated, using position."
	self sortColumn: position.
	self toggleTaskDone: position cell: cell.
	self deleteTask: position.
!
sortColumn: position
	"Sort colums "

	| sortProperty sortBlock |

	"Check if a column header cell was clicked."
	( position x <= 2 ) & ( position y = 1 ) ifFalse: [ ^ nil ].

	sortProperty := #( 'title' 'due' 'done' ) at: position x.
	sortDescending := ( position x = sortColumn ) ifTrue: [ sortDescending not ] ifFalse: [ false ].
	sortBlock := sortDescending
		ifTrue: [ [ :task1 :task2 | ( task2 atProperty: sortProperty ) compare: ( task1 atProperty: sortProperty ) ] ]
		ifFalse: [ [ :task1 :task2 | ( task1 atProperty: sortProperty ) compare: ( task2 atProperty: sortProperty ) ] ].
	tasks sortWith: sortBlock.
	sortColumn := position x.

	self showTasks.
!
toggleTaskDone: position cell: cell
	"Toggle done value of task at position and update table."

	| task |

	"Check if done cell was clicked."
	( position x = 2 ) & ( position y >= 2 ) ifFalse: [ ^ nil ].

	task := tasks at: position y - 2.
	task done: task done not.
	cell textContent: task doneString.
!
deleteTask: position
	"Delete task at position and update table."

	"Check if delete cell was clicked."
	( position x = 3 ) & ( position y >= 2 ) ifFalse: [ ^ nil ].

	tasks removeAt: position y - 2.
	taskTable deleteRow: position y.
!

"Accessing (used by tests)"

tasks
	^ tasks.
!
languageSelect
	^ languageSelect.
!
newTaskTitleInput
	^ newTaskTitleInput.
!
newTaskDueInput
	^ newTaskDueInput.
!
newTaskAddButton
	^ newTaskAddButton.
!
taskTable
	^ taskTable.
!
