CLASS MyBrowserApp EXTENDS BrowserApp MODULE BrowserApp CLASSVARS 'default' VARS 'components'

CLASSMETHODS

default
	^ default.
!

METHODS

start
	default := self.

	self bindElements.

	self testMode ifTrue: [
		TestMyBrowserApp new test: self ].
!
bindElements
	"Load components and add them to the components var."

	components := Array new.
	#( AnchorComponent ClipboardComponent CssComponent DialogsComponent EmbedComponent
		FieldSetComponent FormComponent IframeComponent ImageComponent
		InputComponent ListInputComponent RadioInputComponent CheckboxInputComponent
		ImageInputComponent FileInputComponent DateInputComponent SelectionComponent )
			do: [ :componentClass |
				components add: (
					componentClass new appendToElement: 'elementTesterTableBody' then: [] ) ].
!

"Accessing"

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
