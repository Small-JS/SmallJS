CLASS TestQApplication EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

"These tests run while the app is running, so they restore the settings they change."

test
	| qApplication |
	qApplication := QApplication instance.
	self assert: [ qApplication jsClassName = 'QApplication' ].
	self assert: [ qApplication testMode ].
	self assert: [ QApplication new = qApplication ].
	self assert: [ qApplication inherits: 'QApplication' ].
!
testApplicationDisplayName
	| qApplication oldName count block |
	qApplication := QApplication instance.
	oldName := QApplication applicationDisplayName.
	count := 0.
	block := [ count := count + 1 ].
	qApplication addEventListener: 'applicationDisplayNameChanged' then: block.

	QApplication setApplicationDisplayName: 'My Test App'.
	self assert: [ QApplication applicationDisplayName = 'My Test App' ].
	self assert: [ count = 1 ].

	qApplication removeEventListener: 'applicationDisplayNameChanged' then: block.
	QApplication setApplicationDisplayName: oldName.
	self assert: [ QApplication applicationDisplayName = oldName ].
	self assert: [ count = 1 ].
!
testDesktopFileName
	| oldName |
	oldName := QApplication desktopFileName.
	QApplication setDesktopFileName: 'my-test-app'.
	self assert: [ QApplication desktopFileName = 'my-test-app' ].
	QApplication setDesktopFileName: oldName.
	self assert: [ QApplication desktopFileName = oldName ].
!
testDesktopSettingsAware
	| aware |
	aware := QApplication desktopSettingsAware.
	self assert: [ aware class = Boolean ].
	"Changing it only has effect before creating widgets, so set the same value."
	QApplication setDesktopSettingsAware: aware.
	self assert: [ QApplication desktopSettingsAware = aware ].
!
testWindowIcon
	| oldIcon icon |
	oldIcon := QApplication windowIcon.
	self assert: [ oldIcon class = QIcon ].
	icon := QIcon new: 'missing.ico'.
	QApplication setWindowIcon: icon.
	self assert: [ QApplication windowIcon class = QIcon ].
	QApplication setWindowIcon: oldIcon.
!
testPlatformName
	self assert: [ QApplication platformName isEmpty not ].
!
testQuitOnLastWindowClosed
	| qApplication quit |
	qApplication := QApplication instance.
	quit := qApplication quitOnLastWindowClosed.
	qApplication setQuitOnLastWindowClosed: quit not.
	self assert: [ qApplication quitOnLastWindowClosed = quit not ].
	qApplication setQuitOnLastWindowClosed: quit.
	self assert: [ qApplication quitOnLastWindowClosed = quit ].
!
testAppearance
	| qApplication |
	qApplication := QApplication instance.
	self assert: [ qApplication devicePixelRatio > 0 ].
	"The app sets its style sheet on its window, so the app wide style sheet can be cleared."
	qApplication setStyleSheet: ''.
	qApplication processEvents.
!
