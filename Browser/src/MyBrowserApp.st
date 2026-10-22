CLASS MyBrowserApp EXTENDS BrowserApp MODULE MyBrowserApp CLASSVARS 'default' VARS 'components'

CLASSMETHODS

default
	^ default.
!

METHODS

async start
	default := self.

	await self bindElements.
!
async bindElements
	"Load components one by one, in the order of componentClasses,
	 and add them to the components var."

	components := Array new.
	await self componentClasses doAwait: async [ :componentClass |
		components add:
			await componentClass new appendToElement: 'elementTesterTableBody' ].
!

"Accessing"

componentClasses
	^ #( AnchorComponent AnimationComponent CanvasComponent OffscreenCanvasComponent ClipboardComponent ClipboardImageComponent CssComponent DialogsComponent EmbedComponent
		FieldSetComponent FormComponent GeolocationComponent
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
	result isNil ifTrue: [ Error throw: 'Component class not found: ', componentClass name ].
	^ result.
!
