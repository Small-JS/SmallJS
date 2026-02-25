CLASS TestTask EXTENDS Test MODULE TestTodoApp CLASSVARS '' VARS ''

test
	| task title due |

	task := Task new.
	self assert: [ task title = '' ].
	self assert: [ task done not ].

	title := 'New task'.
	task title: title.
	self assert: [ task title = title ].

	due := Date new.
	task due: due.
	self assert: [ task due = due ].
	self assert: [ task dueString includes: due year toString ].

	self assert: [ task doneString = ( String fromCharCode: 9634 ) ].
	task done: true.
	self assert: [ task done ].
	self assert: [ task doneString = ( String fromCharCode: 10004 ) ].
!
