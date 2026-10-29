CLASS QLabel EXTENDS QFrame MODULE NodeGui CLASSVARS '' VARS ''

"Shows text, a number, a pixmap or a movie. Text can be plain text or rich text (a subset of HTML)."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QLabel()'.
!

"Text format enums"

plainText
	^ 0.
!
richText
	^ 1.
!
autoText
	"Rich text if the text looks like HTML, else plain text. The default."
	^ 2.
!
markdownText
	^ 3.
!

"Text interaction flag enums. Combine flags by adding them."

noTextInteraction
	^ 0.
!
textSelectableByMouse
	^ 1.
!
textSelectableByKeyboard
	^ 2.
!
linksAccessibleByMouse
	"The default for rich text."
	^ 4.
!
linksAccessibleByKeyboard
	^ 8.
!

METHODS

"Content"

setText: text
	INLINE 'this.js.setText( text.js )'.
!
text
	^ String fromJs: INLINE 'this.js.text()'.
!
setNumInt: integer
	"Show integer as text."
	INLINE 'this.js.setNumInt( integer.js )'.
!
setNumDouble: float
	"Show float as text."
	INLINE 'this.js.setNumDouble( float.js )'.
!
setPixmap: pixmap
	INLINE 'this.js.setPixmap( pixmap.js )'.
!
setMovie: movie
	"Show the frames of movie. Start the movie to animate it."
	INLINE 'this.js.setMovie( movie.js )'.
!
movie
	"Answer nil if there is no movie."
	^ QMovie fromJs: INLINE 'this.js.movie()'.
!
clear
	"Remove the text, pixmap or movie."
	INLINE 'this.js.clear()'.
!

"Text format"

setTextFormat: textFormat
	"Use the text format enums."
	INLINE 'this.js.setTextFormat( textFormat.js )'.
!
textFormat
	^ Integer fromJs: INLINE 'this.js.textFormat()'.
!
setWordWrap: wordWrap
	INLINE 'this.js.setWordWrap( wordWrap.js )'.
!
wordWrap
	^ Boolean fromJs: INLINE 'this.js.wordWrap()'.
!
setOpenExternalLinks: open
	"If open, clicking a link in rich text opens it in the browser, instead of firing a 'linkActivated' event."
	INLINE 'this.js.setOpenExternalLinks( open.js )'.
!
openExternalLinks
	^ Boolean fromJs: INLINE 'this.js.openExternalLinks()'.
!

"Layout"

setAlignment: alignment
	"Use the QLayout alignment enums. Combine a horizontal and a vertical one by adding them."
	INLINE 'this.js.setAlignment( alignment.js )'.
!
alignment
	^ Integer fromJs: INLINE 'this.js.alignment()'.
!
setIndent: indent
	"Indent of the text in pixels, or -1 for the default."
	INLINE 'this.js.setIndent( indent.js )'.
!
indent
	^ Integer fromJs: INLINE 'this.js.indent()'.
!
setMargin: margin
	"Margin between the frame and the content, in pixels."
	INLINE 'this.js.setMargin( margin.js )'.
!
margin
	^ Integer fromJs: INLINE 'this.js.margin()'.
!
setScaledContents: scaled
	"If scaled, a pixmap is scaled to fill the label."
	INLINE 'this.js.setScaledContents( scaled.js )'.
!
hasScaledContents
	^ Boolean fromJs: INLINE 'this.js.hasScaledContents()'.
!

"Buddy"

setBuddy: widget
	"Pressing the shortcut of the label text, e.g. '&Name' for Alt+N, gives focus to widget."
	INLINE 'this.js.setBuddy( widget.js )'.
!
buddy
	"Answer nil if there is no buddy.
	 JS buddy() calls the misspelled native method budd(), so call the native object directly."
	^ QWidget fromJs: INLINE 'nodegui$.wrapperCache.getWrapper( this.js.native.buddy() )'.
!

"Selection"

setTextInteractionFlags: flags
	"Use the text interaction flag enums, e.g. to make the text selectable."
	INLINE 'this.js.setTextInteractionFlags( flags.js )'.
!
textInteractionFlags
	^ Integer fromJs: INLINE 'this.js.textInteractionFlags()'.
!
setSelection: start length: length
	"Only has effect if the text is selectable."
	INLINE 'this.js.setSelection( start.js, length.js )'.
!
selectionStart
	"Answer -1 if there is no selection."
	^ Integer fromJs: INLINE 'this.js.selectionStart()'.
!
selectedText
	^ String fromJs: INLINE 'this.js.selectedText()'.
!
hasSelectedText
	^ Boolean fromJs: INLINE 'this.js.hasSelectedText()'.
!

"Events"

onLinkActivate: block
	"Block is called with the URL of the link the user clicked in rich text."
	INLINE 'this.js.addEventListener( "linkActivated", link => block.$value$( stString$class.$fromJs$( link ) ) )'.
!
onLinkHover: block
	"Block is called with the URL of the link under the mouse, or an empty string when it leaves the link."
	INLINE 'this.js.addEventListener( "linkHovered", link => block.$value$( stString$class.$fromJs$( link ) ) )'.
!
