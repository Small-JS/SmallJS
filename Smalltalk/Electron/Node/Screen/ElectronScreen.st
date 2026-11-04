CLASS ElectronScreen EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Partially implements Electron JS object: screen.
 Note: Platform specific funcionality is not implemented, keeping it standard.
 Note: Can only be used after the app is ready.
 Bounds and work areas are returned as Rect, in screen coordinates.
 The work area is the bounds of a display without the taskbar or dock."

CLASSMETHODS

new
	^ self fromJs: INLINE 'electron$.screen'.
!

METHODS

"Displays"

displayCount
	^ Integer fromJs: INLINE 'this.js.getAllDisplays().length'.
!
primaryBounds
	^ Rect fromJs: INLINE 'this.js.getPrimaryDisplay().bounds'.
!
primaryWorkArea
	^ Rect fromJs: INLINE 'this.js.getPrimaryDisplay().workArea'.
!
workAreas
	"Returns the work areas of all displays."
	^ Array fromJs: INLINE 'this.js.getAllDisplays().map( display => display.workArea )' elementClass: Rect.
!
workAreaMatching: rect
	"Returns the work area of the display that overlaps rect the most,
	 or the nearest display if rect does not overlap any display."
	^ Rect fromJs: INLINE 'this.js.getDisplayMatching( {
		x: rect.$origin().$x().js, y: rect.$origin().$y().js,
		width: rect.$extent().$x().js, height: rect.$extent().$y().js } ).workArea'.
!

"Cursor"

cursorPoint
	^ Point jsX: INLINE 'this.js.getCursorScreenPoint().x' jsY: INLINE 'this.js.getCursorScreenPoint().y'.
!
