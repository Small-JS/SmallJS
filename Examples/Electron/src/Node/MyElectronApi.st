CLASS MyElectronApi EXTENDS ElectronApi MODULE MyElectronPreload CLASSVARS '' VARS ''

expose
	self apiName: 'myApi'.
	self addMethod: 'setTitle' block: [ :title | self setTitle: title ].
	self addMethod: 'ping' block: [ :data | self ping: data ].
	self addMethod: 'quit' block: [ self quit ].
	self addMethod: 'onWindowEvent' block: [ :callback | self on: 'windowEvent' then: callback ].
	self exposeInMainWorld.
!
setTitle: title
	self log: 'MyElectronApi: Sending "setTitle" to ipcRenderer with title: ', title.
	self send: 'setTitle' with: title.
!
async ping: data
	self log: 'MyElectronApi: Invoking "ping" on ipcRenderer with data: ', data.
	^ await self invoke: 'ping' with: data.
!
quit
	self log: 'MyElectronApi: Sending "quit" to ipcRenderer'.
	self send: 'quit'.
!
