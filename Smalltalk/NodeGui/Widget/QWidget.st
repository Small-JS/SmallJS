CLASS QWidget EXTENDS QObject MODULE NodeGui CLASSVARS '' VARS ''

INLINE 'import { QWidget } from "@nodegui/nodegui";'

CLASSMETHODS

"Creation"

new
	^ self fromJs: INLINE 'new QWidget()'.
!

METHODS

addAction: action
	INLINE 'this.js.addAction( action.js )'.
!
setLayout: layout
	INLINE 'this.js.setLayout( layout.js )'.
!
setInlineStyle: style
	INLINE 'this.js.setInlineStyle( style.js )'.
!
setStyleSheet: styleSheet
	"Note: styleSheet should be string."
	INLINE 'this.js.setStyleSheet( styleSheet.js )'.
!
styleSheet
	^ String fromJs: INLINE 'this.js.styleSheet()'.
!
setWindowTitle: title
	INLINE 'this.js.setWindowTitle( title.js )'.
!
windowTitle
	^ String fromJs: INLINE 'this.js.windowTitle()'.
!
setWindowIcon: icon
	INLINE 'this.js.setWindowIcon( icon.js )'.
!
windowIcon
	^ QIcon fromJs: INLINE 'this.js.windowIcon()'.
!
