CLASS QMainWindow EXTENDS QWidget MODULE NodeGui CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QMainWindow()'.
!

METHODS

setMenuBar: menuBar
	INLINE 'this.js.setMenuBar( menuBar.js )'.
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
show
	INLINE 'this.js.show()'.
!
