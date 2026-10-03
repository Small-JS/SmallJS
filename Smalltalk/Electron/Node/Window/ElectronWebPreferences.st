CLASS ElectronWebPreferences EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Implements JS object: WebPreferences."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

"Node & preload"

nodeIntegration
	^ Boolean fromJs: INLINE 'this.js.nodeIntegration'.
!
nodeIntegration: nodeIntegration
	INLINE 'this.js.nodeIntegration = nodeIntegration.js'.
!
nodeIntegrationInWorker
	^ Boolean fromJs: INLINE 'this.js.nodeIntegrationInWorker'.
!
nodeIntegrationInWorker: nodeIntegrationInWorker
	INLINE 'this.js.nodeIntegrationInWorker = nodeIntegrationInWorker.js'.
!
nodeIntegrationInSubFrames
	^ Boolean fromJs: INLINE 'this.js.nodeIntegrationInSubFrames'.
!
nodeIntegrationInSubFrames: nodeIntegrationInSubFrames
	INLINE 'this.js.nodeIntegrationInSubFrames = nodeIntegrationInSubFrames.js'.
!
contextIsolation
	^ Boolean fromJs: INLINE 'this.js.contextIsolation'.
!
contextIsolation: contextIsolation
	INLINE 'this.js.contextIsolation = contextIsolation.js'.
!
sandbox
	^ Boolean fromJs: INLINE 'this.js.sandbox'.
!
sandbox: sandbox
	INLINE 'this.js.sandbox = sandbox.js'.
!
preload
	^ String fromJs: INLINE 'this.js.preload'.
!
preload: preload
	INLINE 'this.js.preload = preload.js'.
!

"Security & features"

webSecurity
	^ Boolean fromJs: INLINE 'this.js.webSecurity'.
!
webSecurity: webSecurity
	"If false, disables the same-origin policy."
	INLINE 'this.js.webSecurity = webSecurity.js'.
!
allowRunningInsecureContent
	^ Boolean fromJs: INLINE 'this.js.allowRunningInsecureContent'.
!
allowRunningInsecureContent: allowRunningInsecureContent
	"Allows an https page to run content from http URLs."
	INLINE 'this.js.allowRunningInsecureContent = allowRunningInsecureContent.js'.
!
webviewTag
	^ Boolean fromJs: INLINE 'this.js.webviewTag'.
!
webviewTag: webviewTag
	INLINE 'this.js.webviewTag = webviewTag.js'.
!
javascript
	^ Boolean fromJs: INLINE 'this.js.javascript'.
!
javascript: javascript
	INLINE 'this.js.javascript = javascript.js'.
!
images
	^ Boolean fromJs: INLINE 'this.js.images'.
!
images: images
	INLINE 'this.js.images = images.js'.
!
webgl
	^ Boolean fromJs: INLINE 'this.js.webgl'.
!
webgl: webgl
	INLINE 'this.js.webgl = webgl.js'.
!
plugins
	^ Boolean fromJs: INLINE 'this.js.plugins'.
!
plugins: plugins
	INLINE 'this.js.plugins = plugins.js'.
!
experimentalFeatures
	^ Boolean fromJs: INLINE 'this.js.experimentalFeatures'.
!
experimentalFeatures: experimentalFeatures
	INLINE 'this.js.experimentalFeatures = experimentalFeatures.js'.
!
enableBlinkFeatures
	^ String fromJs: INLINE 'this.js.enableBlinkFeatures'.
!
enableBlinkFeatures: enableBlinkFeatures
	"Feature names separated by commas."
	INLINE 'this.js.enableBlinkFeatures = enableBlinkFeatures.js'.
!
disableBlinkFeatures
	^ String fromJs: INLINE 'this.js.disableBlinkFeatures'.
!
disableBlinkFeatures: disableBlinkFeatures
	"Feature names separated by commas."
	INLINE 'this.js.disableBlinkFeatures = disableBlinkFeatures.js'.
!
enableWebSQL
	^ Boolean fromJs: INLINE 'this.js.enableWebSQL'.
!
enableWebSQL: enableWebSQL
	INLINE 'this.js.enableWebSQL = enableWebSQL.js'.
!

"Process"

additionalArguments
	^ Array fromJsStrings: INLINE 'this.js.additionalArguments'.
!
additionalArguments: additionalArguments
	"Array of strings appended to process.argv in the renderer."
	INLINE 'this.js.additionalArguments = additionalArguments.$toJs()'.
!
partition
	^ String fromJs: INLINE 'this.js.partition'.
!
partition: partition
	"Session partition. Prefix with 'persist:' for a persistent session."
	INLINE 'this.js.partition = partition.js'.
!
devTools
	^ Boolean fromJs: INLINE 'this.js.devTools'.
!
devTools: devTools
	INLINE 'this.js.devTools = devTools.js'.
!
backgroundThrottling
	^ Boolean fromJs: INLINE 'this.js.backgroundThrottling'.
!
backgroundThrottling: backgroundThrottling
	INLINE 'this.js.backgroundThrottling = backgroundThrottling.js'.
!
offscreen
	^ Boolean fromJs: INLINE 'this.js.offscreen'.
!
offscreen: offscreen
	"Note: Only the boolean form is supported."
	INLINE 'this.js.offscreen = offscreen.js'.
!

"Dialogs"

disableDialogs
	^ Boolean fromJs: INLINE 'this.js.disableDialogs'.
!
disableDialogs: disableDialogs
	INLINE 'this.js.disableDialogs = disableDialogs.js'.
!
safeDialogs
	^ Boolean fromJs: INLINE 'this.js.safeDialogs'.
!
safeDialogs: safeDialogs
	INLINE 'this.js.safeDialogs = safeDialogs.js'.
!
safeDialogsMessage
	^ String fromJs: INLINE 'this.js.safeDialogsMessage'.
!
safeDialogsMessage: safeDialogsMessage
	INLINE 'this.js.safeDialogsMessage = safeDialogsMessage.js'.
!

"Page"

zoomFactor
	^ Float fromJs: INLINE 'this.js.zoomFactor'.
!
zoomFactor: zoomFactor
	"E.g. 3.0 for 300%."
	INLINE 'this.js.zoomFactor = zoomFactor.js'.
!
zoomMode
	^ String fromJs: INLINE 'this.js.zoomMode'.
!
zoomMode: zoomMode
	INLINE 'this.js.zoomMode = zoomMode.js'.
!
defaultEncoding
	^ String fromJs: INLINE 'this.js.defaultEncoding'.
!
defaultEncoding: defaultEncoding
	INLINE 'this.js.defaultEncoding = defaultEncoding.js'.
!
defaultFontSize
	^ Integer fromJs: INLINE 'this.js.defaultFontSize'.
!
defaultFontSize: defaultFontSize
	INLINE 'this.js.defaultFontSize = defaultFontSize.js'.
!
defaultMonospaceFontSize
	^ Integer fromJs: INLINE 'this.js.defaultMonospaceFontSize'.
!
defaultMonospaceFontSize: defaultMonospaceFontSize
	INLINE 'this.js.defaultMonospaceFontSize = defaultMonospaceFontSize.js'.
!
minimumFontSize
	^ Integer fromJs: INLINE 'this.js.minimumFontSize'.
!
minimumFontSize: minimumFontSize
	INLINE 'this.js.minimumFontSize = minimumFontSize.js'.
!
spellcheck
	^ Boolean fromJs: INLINE 'this.js.spellcheck'.
!
spellcheck: spellcheck
	INLINE 'this.js.spellcheck = spellcheck.js'.
!
textAreasAreResizable
	^ Boolean fromJs: INLINE 'this.js.textAreasAreResizable'.
!
textAreasAreResizable: textAreasAreResizable
	INLINE 'this.js.textAreasAreResizable = textAreasAreResizable.js'.
!
transparent
	^ Boolean fromJs: INLINE 'this.js.transparent'.
!
transparent: transparent
	INLINE 'this.js.transparent = transparent.js'.
!
autoplayPolicy
	^ String fromJs: INLINE 'this.js.autoplayPolicy'.
!
autoplayPolicy: autoplayPolicy
	"One of: 'no-user-gesture-required', 'user-gesture-required', 'document-user-activation-required'."
	INLINE 'this.js.autoplayPolicy = autoplayPolicy.js'.
!
imageAnimationPolicy
	^ String fromJs: INLINE 'this.js.imageAnimationPolicy'.
!
imageAnimationPolicy: imageAnimationPolicy
	"One of: 'animate', 'animateOnce', 'noAnimation'."
	INLINE 'this.js.imageAnimationPolicy = imageAnimationPolicy.js'.
!
navigateOnDragDrop
	^ Boolean fromJs: INLINE 'this.js.navigateOnDragDrop'.
!
navigateOnDragDrop: navigateOnDragDrop
	INLINE 'this.js.navigateOnDragDrop = navigateOnDragDrop.js'.
!
focusOnNavigation
	^ Boolean fromJs: INLINE 'this.js.focusOnNavigation'.
!
focusOnNavigation: focusOnNavigation
	INLINE 'this.js.focusOnNavigation = focusOnNavigation.js'.
!
disableHtmlFullscreenWindowResize
	^ Boolean fromJs: INLINE 'this.js.disableHtmlFullscreenWindowResize'.
!
disableHtmlFullscreenWindowResize: disableHtmlFullscreenWindowResize
	INLINE 'this.js.disableHtmlFullscreenWindowResize = disableHtmlFullscreenWindowResize.js'.
!
enablePreferredSizeMode
	^ Boolean fromJs: INLINE 'this.js.enablePreferredSizeMode'.
!
enablePreferredSizeMode: enablePreferredSizeMode
	INLINE 'this.js.enablePreferredSizeMode = enablePreferredSizeMode.js'.
!
accessibleTitle
	^ String fromJs: INLINE 'this.js.accessibleTitle'.
!
accessibleTitle: accessibleTitle
	"Title for accessibility tools such as screen readers."
	INLINE 'this.js.accessibleTitle = accessibleTitle.js'.
!
