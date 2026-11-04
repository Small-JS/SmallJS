CLASS MyElectronApi EXTENDS ElectronApi MODULE MyElectronPreload CLASSVARS '' VARS ''

expose
	self apiName: 'myApi'.
	self addMethod: 'setTitle' block: [ :title | self setTitle: title ].
	self addMethod: 'ping' block: [ :data | self ping: data ].
	self addMethod: 'quit' block: [ self quit ].
	self addMethod: 'onWindowEvent' block: [ :callback | self on: 'windowEvent' then: callback ].
	self exposeInMainWorld.
!
"The arguments and results are raw JS values, because they pass through the contextBridge and IPC."

setTitle: title
	self log: 'MyElectronApi: Sending "setTitle" to ipcRenderer with title: ', ( String fromJs: title ).

	self send: 'setTitle' with: title.
	^ nil.
!
async ping: data
	self log: 'MyElectronApi: Invoking "ping" on ipcRenderer with data: ', ( String fromJs: data ).
	^ await self invoke: 'ping' with: data.
!
quit
	self log: 'MyElectronApi: Sending "quit" to ipcRenderer'.
	self send: 'quit'.
	^ nil.
!
