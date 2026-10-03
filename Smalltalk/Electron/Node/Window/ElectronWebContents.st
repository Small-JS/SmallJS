CLASS ElectronWebContents EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Implements Electron JS class: WebContents.
 Note: Platform specific funcionality is not implemented, keeping it standard.
 Not implemented: Functionality that needs not yet wrapped classes,
 like NativeImage, Session, Debugger, WebFrameMain, MessagePortMain and input events.
 Navigation uses the navigationHistory object, because the WebContents navigation methods are deprecated.
 Instances are obtained with ElectronBrowserWindow>>webContents or the class methods."

CLASSMETHODS

all
	^ Array fromJs: INLINE 'electron$.webContents.getAllWebContents()' elementClass: self.
!
focused
	"Returns nil if no web contents is focused."
	^ self fromJs: INLINE 'electron$.webContents.getFocusedWebContents()'.
!
fromId: id
	"Returns nil if no web contents with the id exists."
	^ self fromJs: INLINE 'electron$.webContents.fromId( id.js )'.
!

METHODS

"Events"

onWebContentsEvent: event then: block
	"Note: The block receives the JS arguments of the event."
	INLINE 'this.js.on( event.js, block.js )'.
!
onceWebContentsEvent: event then: block
	"Note: The block receives the JS arguments of the event."
	INLINE 'this.js.once( event.js, block.js )'.
!

"Information"

id
	^ Integer fromJs: INLINE 'this.js.id'.
!
type
	"One of: 'backgroundPage', 'window', 'browserView', 'remote', 'webview', 'offscreen'."
	^ String fromJs: INLINE 'this.js.getType()'.
!
url
	^ String fromJs: INLINE 'this.js.getURL()'.
!
title
	^ String fromJs: INLINE 'this.js.getTitle()'.
!
userAgent
	^ String fromJs: INLINE 'this.js.userAgent'.
!
userAgent: userAgent
	INLINE 'this.js.userAgent = userAgent.js'.
!
processId
	"The Chromium internal process id of the renderer."
	^ Integer fromJs: INLINE 'this.js.getProcessId()'.
!
osProcessId
	"The operating system process id of the renderer."
	^ Integer fromJs: INLINE 'this.js.getOSProcessId()'.
!
destroyed
	^ Boolean fromJs: INLINE 'this.js.isDestroyed()'.
!
crashed
	^ Boolean fromJs: INLINE 'this.js.isCrashed()'.
!
offscreen
	^ Boolean fromJs: INLINE 'this.js.isOffscreen()'.
!

"Focus"

focus
	INLINE 'this.js.focus()'.
!
focused
	^ Boolean fromJs: INLINE 'this.js.isFocused()'.
!

"Loading"

async loadURL: url
	"Throws an error if loading fails."
	INLINE 'await this.js.loadURL( url.js )'.
!
async loadFile: filePath
	"Throws an error if loading fails."
	INLINE 'await this.js.loadFile( filePath.js )'.
!
async loadFile: filePath options: options
	"Options is an ElectronLoadFileOptions. Throws an error if loading fails."
	INLINE 'await this.js.loadFile( filePath.js, options.js )'.
!
reload
	INLINE 'this.js.reload()'.
!
reloadIgnoringCache
	INLINE 'this.js.reloadIgnoringCache()'.
!
stop
	INLINE 'this.js.stop()'.
!
loading
	^ Boolean fromJs: INLINE 'this.js.isLoading()'.
!
loadingMainFrame
	^ Boolean fromJs: INLINE 'this.js.isLoadingMainFrame()'.
!
waitingForResponse
	^ Boolean fromJs: INLINE 'this.js.isWaitingForResponse()'.
!
downloadURL: url
	"Starts a download without navigating. The session will-download event is emitted."
	INLINE 'this.js.downloadURL( url.js )'.
!

"Navigation history"

canGoBack
	^ Boolean fromJs: INLINE 'this.js.navigationHistory.canGoBack()'.
!
canGoForward
	^ Boolean fromJs: INLINE 'this.js.navigationHistory.canGoForward()'.
!
canGoToOffset: offset
	^ Boolean fromJs: INLINE 'this.js.navigationHistory.canGoToOffset( offset.js )'.
!
goBack
	INLINE 'this.js.navigationHistory.goBack()'.
!
goForward
	INLINE 'this.js.navigationHistory.goForward()'.
!
goToIndex: index
	INLINE 'this.js.navigationHistory.goToIndex( index.js )'.
!
goToOffset: offset
	INLINE 'this.js.navigationHistory.goToOffset( offset.js )'.
!
historyLength
	^ Integer fromJs: INLINE 'this.js.navigationHistory.length()'.
!
historyActiveIndex
	^ Integer fromJs: INLINE 'this.js.navigationHistory.getActiveIndex()'.
!
clearHistory
	INLINE 'this.js.navigationHistory.clear()'.
!

"JavaScript & CSS"

async executeJavaScript: code
	"Evaluates code in the page and returns the result converted to a ST object.
	 Note: Waits until the page is loaded."
	^ Object fromJs: INLINE 'await this.js.executeJavaScript( code.js )'.
!
async executeJavaScript: code userGesture: userGesture
	"Like above. If userGesture is true, APIs that need a user action, like requestFullScreen, are allowed."
	^ Object fromJs: INLINE 'await this.js.executeJavaScript( code.js, userGesture.js )'.
!
async insertCSS: css
	"Returns a key that can be used to remove the CSS with removeInsertedCSS:."
	^ String fromJs: INLINE 'await this.js.insertCSS( css.js )'.
!
async removeInsertedCSS: key
	INLINE 'await this.js.removeInsertedCSS( key.js )'.
!

"Editing"

undo
	INLINE 'this.js.undo()'.
!
redo
	INLINE 'this.js.redo()'.
!
cut
	INLINE 'this.js.cut()'.
!
copySelection
	"Note: Not named copy, because that would override Object>>copy."
	INLINE 'this.js.copy()'.
!
paste
	INLINE 'this.js.paste()'.
!
pasteAndMatchStyle
	INLINE 'this.js.pasteAndMatchStyle()'.
!
delete
	INLINE 'this.js.delete()'.
!
selectAll
	INLINE 'this.js.selectAll()'.
!
unselect
	INLINE 'this.js.unselect()'.
!
replace: text
	"Replaces the selection with text."
	INLINE 'this.js.replace( text.js )'.
!
replaceMisspelling: text
	INLINE 'this.js.replaceMisspelling( text.js )'.
!
async insertText: text
	"Inserts text at the focused element."
	INLINE 'await this.js.insertText( text.js )'.
!

"Scrolling"

scrollToTop
	INLINE 'this.js.scrollToTop()'.
!
scrollToBottom
	INLINE 'this.js.scrollToBottom()'.
!

"Find"

findInPage: text
	"Starts a find request, the result is emitted with event 'found-in-page'.
	 Returns the request id."
	^ Integer fromJs: INLINE 'this.js.findInPage( text.js )'.
!
stopFindInPage: action
	"Action is one of: 'clearSelection', 'keepSelection', 'activateSelection'."
	INLINE 'this.js.stopFindInPage( action.js )'.
!

"Zoom"

zoomFactor
	^ Float fromJs: INLINE 'this.js.zoomFactor'.
!
zoomFactor: factor
	"Factor 1.0 is 100%, must be greater than 0.0."
	INLINE 'this.js.zoomFactor = factor.js'.
!
zoomLevel
	^ Float fromJs: INLINE 'this.js.zoomLevel'.
!
zoomLevel: level
	"Level 0 is the original size, each step up or down is 20% larger or smaller."
	INLINE 'this.js.zoomLevel = level.js'.
!
async visualZoomLevelLimitsMinimum: minimum maximum: maximum
	"Limits for pinch to zoom."
	INLINE 'await this.js.setVisualZoomLevelLimits( minimum.js, maximum.js )'.
!

"Audio"

audioMuted
	^ Boolean fromJs: INLINE 'this.js.audioMuted'.
!
audioMuted: muted
	INLINE 'this.js.audioMuted = muted.js'.
!
currentlyAudible
	^ Boolean fromJs: INLINE 'this.js.isCurrentlyAudible()'.
!

"Background throttling"

backgroundThrottling
	^ Boolean fromJs: INLINE 'this.js.backgroundThrottling'.
!
backgroundThrottling: allowed
	"If true, animations and timers are throttled when the page is in the background."
	INLINE 'this.js.backgroundThrottling = allowed.js'.
!

"Menu shortcuts"

ignoreMenuShortcuts: ignore
	"If true, application menu shortcuts are ignored while this web contents is focused."
	INLINE 'this.js.setIgnoreMenuShortcuts( ignore.js )'.
!

"Developer tools"

openDevTools
	INLINE 'this.js.openDevTools()'.
!
closeDevTools
	INLINE 'this.js.closeDevTools()'.
!
toggleDevTools
	INLINE 'this.js.toggleDevTools()'.
!
devToolsOpened
	^ Boolean fromJs: INLINE 'this.js.isDevToolsOpened()'.
!
devToolsFocused
	^ Boolean fromJs: INLINE 'this.js.isDevToolsFocused()'.
!
devToolsTitle
	^ String fromJs: INLINE 'this.js.getDevToolsTitle()'.
!
devToolsTitle: title
	INLINE 'this.js.setDevToolsTitle( title.js )'.
!
inspectElementX: x y: y
	"Opens the developer tools with the element at position x, y selected."
	INLINE 'this.js.inspectElement( x.js, y.js )'.
!

"Saving & printing"

async savePage: fullPath saveType: saveType
	"SaveType is one of: 'HTMLOnly', 'HTMLComplete', 'MHTML'. Throws an error if saving fails."
	INLINE 'await this.js.savePage( fullPath.js, saveType.js )'.
!
async printToPDF
	"Returns the PDF data as a Buffer, using the default print options."
	^ Buffer fromJs: INLINE 'await this.js.printToPDF( {} )'.
!

"IPC"

send: channel
	"Sends a message to the renderer, that can be received with ipcRenderer.on."
	INLINE 'this.js.send( channel.js )'.
!
send: channel with: data
	"Data is converted to JS with toJs."
	INLINE 'this.js.send( channel.js, data.$toJs() )'.
!

"Closing"

close
	"Closes the page, as if the user closed the window. The page can prevent this with beforeunload."
	INLINE 'this.js.close()'.
!
