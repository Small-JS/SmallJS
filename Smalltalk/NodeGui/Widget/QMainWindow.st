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
show
	INLINE 'this.js.show()'.
!
