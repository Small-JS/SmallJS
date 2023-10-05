// Invoke the start method on a new TodoApp ST object.

let todoAppModuleName: string = "./Smalltalk/Todo.js";
import( todoAppModuleName )
	.then( module => { module.stTodoApp$class.$new().$start() } );
