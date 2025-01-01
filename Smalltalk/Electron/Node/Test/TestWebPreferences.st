CLASS TestWebPreferences EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

test
	| webPreferences |

	webPreferences := WebPreferences new.

	webPreferences nodeIntegration: true.
	self assert: [ webPreferences nodeIntegration ].

	webPreferences nodeIntegrationInWorker: true.
	self assert: [ webPreferences nodeIntegrationInWorker ].

	webPreferences nodeIntegrationInSubFrames: true.
	self assert: [ webPreferences nodeIntegrationInSubFrames ].

	webPreferences contextIsolation: true.
	self assert: [ webPreferences contextIsolation ].

	webPreferences contextIsolation: true.
	self assert: [ webPreferences contextIsolation ].

	webPreferences sandbox: false.
	self assert: [ webPreferences sandbox not ].

	webPreferences preload: ( Path resolve: 'preload.mjs' ).
	self assert: [ webPreferences preload endsWith: 'preload.mjs' ].
!
