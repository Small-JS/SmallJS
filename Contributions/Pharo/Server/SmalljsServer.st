
Object subclass: #SmalljsServer
	instanceVariableNames: 'znServer'
	classVariableNames: ''
	package: 'SmallJS-Server'!
SmalljsServer class
	instanceVariableNames: ''!

!SmalljsServer methodsFor: 'event handling' stamp: '2025-10-31T00:21:30.082+01:00' prior: 0!
handleRequest: request
	| requestString |
	requestString := request uri asString.
	requestString = '/hello' ifTrue: [
		^ self onHello ].

	Transcript cr; show: 'SmalljsServer: Bad request: ', requestString.
	^ ZnResponse badRequest: request.! !

!SmalljsServer methodsFor: 'event handling' stamp: '2025-10-31T00:21:30.088+01:00' prior: 0!
onHello
	Transcript cr; show: 'SmalljsServer: Responding to hello request'.
	^ ZnResponse ok: (
		ZnEntity text: (
			STONJSON toString: { #message->'Hello from Pharo!!' } asDictionary ) ).! !

!SmalljsServer methodsFor: 'starting' stamp: '2025-10-31T00:21:30.094+01:00' prior: 0!
start
	self stop.

	Transcript cr; show: 'SmalljsServer: Starting on web folder: ', self webFolder.

	( ZnServer startDefaultOn: 3000 ) delegate:
	   	( ZnStaticFileDecoratorDelegate
			decorate: self class new
	  		servingFilesFrom: self webFolder ).

		! !

!SmalljsServer methodsFor: 'starting' stamp: '2025-10-31T00:21:30.099+01:00' prior: 0!
stop
	ZnServer default ifNotNil: [
		 ZnServer default stop.
		( Delay forSeconds: 2 ) wait. ].
! !

!SmalljsServer methodsFor: 'starting' stamp: '2025-10-31T00:21:30.103+01:00' prior: 0!
webFolder
	^ Smalltalk os environment at: 'pharoWeb'
		ifAbsent: [ self error: 'Environment variable "pharoWeb" not set' ].
! !
