CLASS QMainWindow EXTENDS QWidget MODULE NodeGui CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QMainWindow()'.
!

METHODS

setMenuBar: menuBar
	INLINE 'this.js.setMenuBar( menuBar.js )'.
!
setMenuWidget: widget
	"Show any widget in the place of the menu bar."
	INLINE 'this.js.setMenuWidget( widget.js )'.
!
menuBar
	^ QMenuBar fromJs: INLINE 'this.js.menuBar()'.
!
setCentralWidget: widget
	INLINE 'this.js.setCentralWidget( widget.js )'.
!
centralWidget
	^ QWidget fromJs: INLINE 'this.js.centralWidget()'.
!
takeCentralWidget
	"Remove the central widget, so it is not deleted with the window. Answer it, or nil if there is none.
	 JS takeCentralWidget() replaces its method centralWidget() by null, so do it here."
	^ QWidget fromJs: INLINE '( () => {
		const widget = this.js.centralWidget();
		if( widget == null ) return null;
		widget.setFlexNodeSizeControlled( false );
		return nodegui$.wrapperCache.getWrapper( this.js.native.takeCentralWidget() ) } )()'.
!
setStatusBar: statusBar
	"StatusBar can be nil to remove the status bar."
	statusBar isNil
		ifTrue: [ INLINE 'this.js.setStatusBar( null )' ]
		ifFalse: [ INLINE 'this.js.setStatusBar( statusBar.js )' ].
!
statusBar
	"Answer the status bar. If there is none, an empty one is created."
	^ QStatusBar fromJs: INLINE 'this.js.statusBar()'.
!
