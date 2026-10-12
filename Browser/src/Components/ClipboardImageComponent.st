CLASS ClipboardImageComponent EXTENDS Component MODULE MyBrowserApp CLASSVARS ''
	VARS 'resultCanvas writeButton readButton resultParagraph'

"Writes the PNG image SmallJS.png, resized to 48 x 48 pixels, to the clipboard,
 and reads it back. Both images are displayed at 48 x 48 pixels.
 Note: This component cannot be GUI tested automatically,
	because the clipboard may require user permission first."

htmlPath
	^ 'Components/ClipboardImageComponent.html'.
!
start
	self bindElements.
!
bindElements
	resultCanvas := Document getElementById: 'clipboardImageResultCanvas' class: HtmlCanvasElement.

	writeButton := Document getElementById: 'clipboardImageWriteButton' class: HtmlButtonElement.
	writeButton onClick: [ self onWriteButton ].

	readButton := Document getElementById: 'clipboardImageReadButton' class: HtmlButtonElement.
	readButton onClick: [ self onReadButton ].

	resultParagraph := Document getElementById: 'clipboardImageResultParagraph' class: HtmlParagraphElement.
!

"Event handling"

async onWriteButton
	| blob |
	blob := await self resizedImageBlob.
	await Clipboard default write: ( Array with: ( ClipboardItem type: 'image/png' data: blob ) ).
	resultParagraph textContent: '[written]'.
!
async resizedImageBlob
	"Return SmallJS.png resized to the size of the result canvas, as a PNG Blob."
	| imageBitmap canvas |
	imageBitmap := await ImageBitmap create: ( await ( await Fetch request: 'SmallJS.png' ) blob ).
	canvas := OffscreenCanvas new: resultCanvas size.
	canvas getContext2d drawImage: imageBitmap destRect: ( Rect origin: 0 @ 0 extent: canvas size ).
	imageBitmap close.
	^ await canvas convertToBlob.
!
async onReadButton
	| items item blob imageBitmap context |
	items := await Clipboard default read.
	item := items find: [ :each | each types includes: 'image/png' ].
	context := resultCanvas getContext2d.
	context clearRect: ( Rect origin: 0 @ 0 extent: resultCanvas size ).
	item isNil ifTrue: [
		resultParagraph textContent: '[no PNG image on clipboard]'.
		^ self ].

	blob := await item getType: 'image/png'.
	imageBitmap := await ImageBitmap create: blob.
	context drawImage: imageBitmap destRect: ( Rect origin: 0 @ 0 extent: resultCanvas size ).
	resultParagraph textContent: '[read ', imageBitmap width toString, ' x ', imageBitmap height toString, ' PNG]'.
	imageBitmap close.
!
