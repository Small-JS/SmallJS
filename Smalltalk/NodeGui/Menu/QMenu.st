CLASS QMenu EXTENDS QWidget MODULE NodeGui CLASSVARS '' VARS ''

"A popup menu of actions, added with QWidget addAction:.
 Some NodeGui JS methods are broken, so these methods call the native object directly:
 addSeparator() answers an unusable object, addMenu( title ) and insertSection( before, text ) ignore the text,
 setIcon() and icon() mix up JS and native objects and isTearOffEnabled() reads a wrong property.
 Not wrapped: exec(), popup(), actionAt() and actionGeometry(), because QPoint and QRect are not wrapped (yet)."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QMenu()'.
!

METHODS

"Title"

setTitle: title
	INLINE 'this.js.setTitle( title.js )'.
!
title
	^ String fromJs: INLINE 'this.js.title()'.
!
setIcon: icon
	INLINE 'this.js.native.setIcon( icon.js.native )'.
!
icon
	^ QIcon fromJs: INLINE 'new nodegui$.QIcon( this.js.native.icon() )'.
!
menuAction
	"Answer the action of this menu, used to add it to another menu or menu bar."
	^ QAction fromJs: INLINE 'this.js.menuAction()'.
!

"Adding"

addSeparator
	"Add a separator line and answer its action."
	| action |
	action := QAction new.
	action setSeparator: true.
	self addAction: action.
	^ action.
!
addSection: text
	"Add a section, a separator with text (shown depending on the style), and answer its action."
	^ QAction fromJs: INLINE 'nodegui$.wrapperCache.getWrapper( this.js.native.addSection_1( text.js ) )'.
!
addMenu: menu
	"Add menu as a submenu and answer its action."
	self addAction: menu menuAction.
	^ menu menuAction.
!
addMenuWithTitle: title
	"Add a new submenu with title and answer it."
	^ QMenu fromJs: INLINE 'nodegui$.wrapperCache.getWrapper( this.js.native.addMenu_1( title.js ) )'.
!

"Inserting before an action"

insertSeparator: beforeAction
	"Answer the action of the separator."
	^ QAction fromJs: INLINE 'this.js.insertSeparator( beforeAction.js )'.
!
insertSection: text before: beforeAction
	"Answer the action of the section."
	^ QAction fromJs: INLINE 'nodegui$.wrapperCache.getWrapper( this.js.native.insertSection_2( beforeAction.js.native, text.js ) )'.
!
insertMenu: menu before: beforeAction
	"Answer the action of menu."
	^ QAction fromJs: INLINE 'this.js.insertMenu( beforeAction.js, menu.js )'.
!

"Actions"

clear
	"Remove all actions."
	INLINE 'this.js.clear()'.
!
isEmpty
	^ Boolean fromJs: INLINE 'this.js.isEmpty()'.
!
setDefaultAction: action
	"The default action is shown in bold."
	INLINE 'this.js.setDefaultAction( action.js )'.
!
defaultAction
	"Answer nil if there is none."
	^ QAction fromJs: INLINE 'this.js.defaultAction()'.
!
setActiveAction: action
	"Highlight action."
	INLINE 'this.js.setActiveAction( action.js )'.
!
activeAction
	"Answer the highlighted action, or nil if there is none."
	^ QAction fromJs: INLINE 'this.js.activeAction()'.
!

"Options"

setToolTipsVisible: visible
	INLINE 'this.js.setToolTipsVisible( visible.js )'.
!
toolTipsVisible
	^ Boolean fromJs: INLINE 'this.js.toolTipsVisible()'.
!
setSeparatorsCollapsible: collapsible
	"If collapsible, consecutive separators are shown as one, and separators at the start or end are hidden."
	INLINE 'this.js.setSeparatorsCollapsible( collapsible.js )'.
!
separatorsCollapsible
	^ Boolean fromJs: INLINE 'this.js.separatorsCollapsible()'.
!
setTearOffEnabled: enabled
	"A tear-off menu can be detached into a separate window."
	INLINE 'this.js.setTearOffEnabled( enabled.js )'.
!
isTearOffEnabled
	^ Boolean fromJs: INLINE 'this.js.property( "tearOffEnabled" ).toBool()'.
!

"Events"

onAboutToShow: block
	self addEventListener: 'aboutToShow' then: [ block value ].
!
onAboutToHide: block
	self addEventListener: 'aboutToHide' then: [ block value ].
!
onTrigger: block
	"Block is called with the QAction the user triggered in this menu or its submenus."
	INLINE 'this.js.addEventListener( "triggered", native => block.$value$( stQAction$class.$fromJs$( nodegui$.wrapperCache.getWrapper( native ) ) ) )'.
!
onHover: block
	"Block is called with the QAction the user highlighted."
	INLINE 'this.js.addEventListener( "hovered", native => block.$value$( stQAction$class.$fromJs$( nodegui$.wrapperCache.getWrapper( native ) ) ) )'.
!
