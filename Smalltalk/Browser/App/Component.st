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
appendToElement: elementId then: block
	^ self new appendToElement: elementId then: block
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
loadIntoElement: elementId then: block
	self loadIntoElement: elementId append: false then: block.
!
appendToElement: elementId then: block
	self loadIntoElement: elementId append: true then: block.
!
loadIntoElement: elementId append: append then: block
	"Load self into the HTML element with argument id."
	| element |
	element := Document getElementById: elementId.
	self assert: [ element notNil ].

	Fetch text: self htmlPath
		then: [ :html |
			append
				ifTrue: [ element insertAdjacentHtml: html position: 'beforeEnd' ]
				ifFalse: [ element innerHtml: html ].
			self start.
			block value: self ]
		catch: [ :error |
			self log: 'Failed to fetch component HTML: ', self htmlPath, ': ', error message ].
!
