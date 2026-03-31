"VERSION:1.0"!PackageManifest subclass: #ManifestSmallJSServer	instanceVariableNames: ''	classVariableNames: ''	package: 'SmallJS-Server-Manifest'!ManifestSmallJSServer class	instanceVariableNames: ''!!ManifestSmallJSServer commentStamp: '<historical>' prior: '0'!Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser!Object subclass: #SmalljsServer	instanceVariableNames: 'znServer'	classVariableNames: ''	package: 'SmallJS-Server'!SmalljsServer class	instanceVariableNames: ''!!ManifestSmallJSServer class methodsFor: 'code-critics' stamp: '2026-03-31T23:10:24.202+02:00' prior: 0!ruleMethodSourceContainsLinefeedsRuleV1FalsePositive	<ignoreForCoverage>	^ #(#(#(#RGPackageDefinition #(#'SmallJS-Server')) #'2026-03-31T23:03:49.17+02:00') )! !!SmalljsServer methodsFor: 'event handling' stamp: '2026-03-31T23:10:24.207+02:00' prior: 0!handleRequest: request
	| requestString |
	requestString := request uri asString.
	requestString = '/hello' ifTrue: [
		^ self onHello ].
 
	Transcript cr; show: 'SmalljsServer: Bad request: ', requestString.
	^ ZnResponse badRequest: request.! !!SmalljsServer methodsFor: 'event handling' stamp: '2026-03-31T23:10:24.211+02:00' prior: 0!onHello
	Transcript cr; show: 'SmalljsServer: Responding to hello request'.
	^ ZnResponse ok: (
		ZnEntity text: (
			STONJSON toString: { #message->'Hello from Pharo!!' } asDictionary ) ).! !!SmalljsServer methodsFor: 'starting' stamp: '2026-03-31T23:10:24.217+02:00' prior: 0!start
	self stop.

	Transcript cr; show: 'SmalljsServer: Starting on web folder: ', self webFolder.

	( ZnServer startDefaultOn: 3000 ) delegate:
	   	( ZnStaticFileDecoratorDelegate
			decorate: self class new
	  		servingFilesFrom: self webFolder ).

		! !!SmalljsServer methodsFor: 'starting' stamp: '2026-03-31T23:10:24.222+02:00' prior: 0!stop
	ZnServer default ifNotNil: [
		 ZnServer default stop.
		( Delay forSeconds: 2 ) wait. ].
! !!SmalljsServer methodsFor: 'starting' stamp: '2026-03-31T23:10:24.225+02:00' prior: 0!webFolder	^ OSEnvironment current at: 'pharoWeb' ifAbsent: [ self error: 'Environment variable "pharoWeb" not set' ]! !