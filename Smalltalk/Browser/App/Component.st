CLASS Component EXTENDS Object MODULE Browser CLASSVARS '' VARS 'app parent'
	"Base class for client (browser) components.
	 Instances can be thought of as lightweight React or Angular components.
	 A component has an HTML fragment, that may include a CSS file,
	 that can be dynamically loaded into the current page.

	 For communication between components:
	 	Var 'app' optionally holds the (root) BrowserApp instance.
	 	Var 'parent' optionally holds the parent Component instance."

CLASSMETHODS

loadIntoElement: elementId then: block
	^ self new loadIntoElement: elementId then: block
!

METHODS

"Accessing"

app
	^ app.
!
app: aApp
	app := aApp.
!
parent
	^ parent.
!
parent: aParent
	parent := aParent.
!

"Loading"

htmlPath
	"Answer the (relative) path of this components HTML file."
	self subclassReponsibility.
!
start
	"Startup code that is called after loading."
!
loadIntoElement: elementId then: block
	"Load self into the HTML element with argument id."
	| element |
	element := Document getElementById: elementId.
	self assert: [ element notNil ].

	Fetch file: self htmlPath
		then: [ :text |	element innerHtml: text.
			self start.
			block value ]
		catch: [ :error | self log: 'Failed to fetch component HTML: ', self htmlPath, ': ', error message ].
!
