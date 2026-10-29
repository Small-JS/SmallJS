CLASS QSizePolicy EXTENDS Object MODULE NodeGui CLASSVARS '' VARS ''

"Size policy enums, used with QWidget setSizePolicy:vertical:
 to control how a widget grows and shrinks in a layout.
 NodeGui has no JS class QSizePolicy, only these enums."

CLASSMETHODS

"Policy enums"

fixed
	"Always use the size hint."
	^ 0.
!
minimum
	"The size hint is the minimum size, the widget can grow."
	^ 1.
!
maximum
	"The size hint is the maximum size, the widget can shrink."
	^ 4.
!
preferred
	"The size hint is the best size, the widget can grow and shrink."
	^ 5.
!
expanding
	"Like preferred, but the widget gets as much space as possible."
	^ 7.
!
minimumExpanding
	"Like minimum, but the widget gets as much space as possible."
	^ 3.
!
ignored
	"The size hint is ignored, the widget gets as much space as possible."
	^ 13.
!
