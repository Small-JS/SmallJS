CLASS TestMyNodeGuiBase EXTENDS Object MODULE TestMyNodeGuiApp CLASSVARS ''
	VARS 'app'

"GUI tests of the NodeGui Base classes, for methods that need the running Qt event loop.
 Exits the app as the last test."

async test: aApp
	app := aApp.

	await self testTimer.
	await self testDeleteLater.
	self testProcessEvents.
	self testExit.
!
async testTimer
	"Timer events are fired by the event loop, until the timer is killed."
	| object count timerId countAfterKill |
	object := QObject new.
	count := 0.
	object addEventListener: 'Timer' then: [ count := count + 1 ].

	timerId := object startTimer: 50.
	await Timer timeout: 500.
	self assert: [ count > 0 ].

	object killTimer: timerId.
	countAfterKill := count.
	await Timer timeout: 300.
	self assert: [ count = countAfterKill ].
!
async testDeleteLater
	"The object is deleted when control returns to the event loop."
	| parent child |
	parent := QObject new.
	child := QObject new.
	child setParent: parent.

	child deleteLater.
	self assert: [ parent children length = 1 ].
	await Timer timeout: 100.
	self assert: [ parent children isEmpty ].
!
testProcessEvents
	"Without returning to the event loop, timer events are only fired by processEvents."
	| object count timerId loops |
	object := QObject new.
	count := 0.
	object addEventListener: 'Timer' then: [ count := count + 1 ].
	timerId := object startTimer: 0 type: QObject preciseTimer.

	self assert: [ count = 0 ].
	loops := 0.
	[ ( count = 0 ) & ( loops < 1000 ) ] whileTrue: [
		app processEvents.
		loops := loops + 1 ].
	self assert: [ count > 0 ].
	object killTimer: timerId.
!
testExit
	"Exit code 0 ends the test run without error."
	app exit: 0.
!
