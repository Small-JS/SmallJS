CLASS TestElectronWebPreferences EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

testUnset
	| webPreferences |

	webPreferences := ElectronWebPreferences new.
	self assert: [ webPreferences nodeIntegration isNil ].
	self assert: [ webPreferences preload isNil ].
	self assert: [ webPreferences webSecurity isNil ].
	self assert: [ webPreferences additionalArguments isNil ].
	self assert: [ webPreferences zoomFactor isNil ].
!
testNodeAndPreload
	| webPreferences |

	webPreferences := ElectronWebPreferences new.
	webPreferences nodeIntegration: true; nodeIntegrationInWorker: true; nodeIntegrationInSubFrames: true.
	self assert: [ webPreferences nodeIntegration ].
	self assert: [ webPreferences nodeIntegrationInWorker ].
	self assert: [ webPreferences nodeIntegrationInSubFrames ].

	webPreferences contextIsolation: true; sandbox: false.
	self assert: [ webPreferences contextIsolation ].
	self assert: [ webPreferences sandbox not ].

	webPreferences preload: ( Path resolve: 'preload.mjs' ).
	self assert: [ webPreferences preload endsWith: 'preload.mjs' ].
!
testSecurityAndFeatures
	| webPreferences |

	webPreferences := ElectronWebPreferences new.
	webPreferences webSecurity: false; allowRunningInsecureContent: true; webviewTag: true.
	self assert: [ webPreferences webSecurity not ].
	self assert: [ webPreferences allowRunningInsecureContent ].
	self assert: [ webPreferences webviewTag ].

	webPreferences javascript: false; images: false; webgl: false; plugins: true; experimentalFeatures: true.
	self assert: [ webPreferences javascript not ].
	self assert: [ webPreferences images not ].
	self assert: [ webPreferences webgl not ].
	self assert: [ webPreferences plugins ].
	self assert: [ webPreferences experimentalFeatures ].

	webPreferences enableBlinkFeatures: 'A,B'; disableBlinkFeatures: 'C'; enableWebSQL: false.
	self assert: [ webPreferences enableBlinkFeatures = 'A,B' ].
	self assert: [ webPreferences disableBlinkFeatures = 'C' ].
	self assert: [ webPreferences enableWebSQL not ].
!
testProcess
	| webPreferences |

	webPreferences := ElectronWebPreferences new.
	webPreferences additionalArguments: #( '--a' '--b=1' ).
	self assert: [ webPreferences additionalArguments = #( '--a' '--b=1' ) ].

	webPreferences partition: 'persist:test'; devTools: false; backgroundThrottling: false; offscreen: true.
	self assert: [ webPreferences partition = 'persist:test' ].
	self assert: [ webPreferences devTools not ].
	self assert: [ webPreferences backgroundThrottling not ].
	self assert: [ webPreferences offscreen ].
!
testDialogs
	| webPreferences |

	webPreferences := ElectronWebPreferences new.
	webPreferences disableDialogs: true; safeDialogs: true; safeDialogsMessage: 'Stop'.
	self assert: [ webPreferences disableDialogs ].
	self assert: [ webPreferences safeDialogs ].
	self assert: [ webPreferences safeDialogsMessage = 'Stop' ].
!
testPage
	| webPreferences |

	webPreferences := ElectronWebPreferences new.
	webPreferences zoomFactor: 1.5; zoomMode: 'default'; defaultEncoding: 'UTF-8'.
	self assert: [ webPreferences zoomFactor = 1.5 ].
	self assert: [ webPreferences zoomMode = 'default' ].
	self assert: [ webPreferences defaultEncoding = 'UTF-8' ].

	webPreferences defaultFontSize: 16; defaultMonospaceFontSize: 13; minimumFontSize: 8.
	self assert: [ webPreferences defaultFontSize = 16 ].
	self assert: [ webPreferences defaultMonospaceFontSize = 13 ].
	self assert: [ webPreferences minimumFontSize = 8 ].

	webPreferences spellcheck: false; textAreasAreResizable: false; transparent: false.
	self assert: [ webPreferences spellcheck not ].
	self assert: [ webPreferences textAreasAreResizable not ].
	self assert: [ webPreferences transparent not ].

	webPreferences autoplayPolicy: 'user-gesture-required'; imageAnimationPolicy: 'noAnimation'.
	self assert: [ webPreferences autoplayPolicy = 'user-gesture-required' ].
	self assert: [ webPreferences imageAnimationPolicy = 'noAnimation' ].

	webPreferences navigateOnDragDrop: true; focusOnNavigation: false;
		disableHtmlFullscreenWindowResize: true; enablePreferredSizeMode: true; accessibleTitle: 'Main'.
	self assert: [ webPreferences navigateOnDragDrop ].
	self assert: [ webPreferences focusOnNavigation not ].
	self assert: [ webPreferences disableHtmlFullscreenWindowResize ].
	self assert: [ webPreferences enablePreferredSizeMode ].
	self assert: [ webPreferences accessibleTitle = 'Main' ].
!
testAppliedToWindow
	"The preferences are applied to a created window. Windows can only be created after the app is ready.
	 Note: getLastWebPreferences only returns a subset of the preferences."
	| webPreferences window applied |

	ElectronApp new ready ifFalse: [ ^ self ].

	webPreferences := ElectronWebPreferences new javascript: false; safeDialogs: true; safeDialogsMessage: 'Stop'.
	window := ElectronBrowserWindow new: ( BrowserWindowOptions new show: false; webPreferences: webPreferences ).
	applied := ElectronWebPreferences fromJs: ( INLINE 'window.js.webContents.getLastWebPreferences()' ).
	self assert: [ applied javascript not ].
	self assert: [ applied safeDialogs ].
	self assert: [ applied safeDialogsMessage = 'Stop' ].
	window destroy.
!
