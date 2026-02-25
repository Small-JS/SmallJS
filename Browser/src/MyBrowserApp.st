CLASS MyBrowserApp EXTENDS BrowserApp MODULE MyBrowserApp CLASSVARS 'default' VARS 'components'

CLASSMETHODS

default
	^ default.
!

METHODS

start
	default := self.

	self bindElements.
!
async bindElements
	"Load components and add them to the components var."

	components := Array new.
	self componentClasses do: async [ :componentClass |
		components add:
			await componentClass new appendToElement: 'elementTesterTableBody' ].
!

"Accessing"

componentClasses
	^ #( AnchorComponent CanvasComponent ClipboardComponent CssComponent DialogsComponent EmbedComponent
		FieldSetComponent FormComponent
		InputComponent ListInputComponent SelectComponent RadioInputComponent CheckboxInputComponent
		ImageInputComponent FileInputComponent DateInputComponent SelectionComponent
		ScriptComponent TextAreaComponent )
!
components
	^ components.
!
findComponent: componentClass
	"Find instance of componentClass in my components.
	 Raise error if not found."
	| result |
	result := components find: [ :component | component class = componentClass ].
	result isNil ifTrue: [ Error throw: 'Component class not found: ', componentClass className ].
	^ result.
!
