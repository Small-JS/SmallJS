CLASS Component EXTENDS Object MODULE Browser CLASSVARS '' VARS 'app parent'

"Base class for client (browser) components.
Instances can be thought of as lightweight React or Angular components.
A component has an HTML fragment, that may include a CSS file,
that can be dynamically loaded into the current page.

For communication between components:
 	Var 'app' optionally holds the (root) BrowserApp instance.
 	Var 'parent' optionally holds the parent Component instance."

CLASSMETHODS

async loadIntoElement: elementId
	^ await self new loadIntoElement: elementId
!
async appendToElement: elementId
	^ await self new appendToElement: elementId
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
	"Optional startup code that is called after loading self."
!
async loadIntoElement: elementId
	await self loadIntoElement: elementId append: false.
!
async appendToElement: elementId
	await self loadIntoElement: elementId append: true.
!
async loadIntoElement: elementId append: append
	"Load self into the HTML element with argument id."
	| element html |
	element := Document getElementById: elementId.
	self assert: [ element notNil ].

	html := await Fetch text: self htmlPath.
	append
		ifTrue: [ element insertAdjacentHtml: html position: 'beforeEnd' ]
		ifFalse: [ element innerHtml: html ].

	self start.
!
