CLASS TestQSystemTrayIcon EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

"The icon is not shown, to keep the system tray of the test machine clean."

test
	| trayIcon |
	trayIcon := QSystemTrayIcon new.
	self assert: [ trayIcon jsClassName = 'QSystemTrayIcon' ].
	self assert: [ trayIcon isVisible not ].

	trayIcon setIcon: ( QIcon new: 'assets/logo.png' ).
	trayIcon setToolTip: 'My Tip'.
	self assert: [ trayIcon toolTip = 'My Tip' ].
	trayIcon setContextMenu: QMenu new.

	trayIcon hide.
	self assert: [ trayIcon isVisible not ].

	"The events are fired by user interaction only."
	trayIcon onActivate: [ :reason | self assert: [ false ] ].
	trayIcon onMessageClick: [ self assert: [ false ] ].
	self assert: [ QSystemTrayIcon trigger = 3 ].
!
