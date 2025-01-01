CLASS MyElectronApi EXTENDS ElectronApi MODULE MyElectronPreload CLASSVARS ''
	VARS 'browserWindow'

expose
	self apiName: 'myApi'.
	self addMethod: 'setTitle' block: [ :title | self setTitle: title ].
	self addMethod: 'ping' block: [ :data :callback | self ping: data then: callback ].
	self addMethod: 'quit' block: [ self quit ].
	self exposeInMainWorld.
!
setTitle: title
	self log: 'MyElectronApi: Sending "setTitle" to ipcRenderer with title: ', title.
	self send: 'setTitle' with: title.
!
ping: data then: callback
	self log: 'MyElectronApi: Invoking "ping" on ipcRenderer with data: ', data.
	self invoke: 'ping' with: data then: callback.
!
quit
	self log: 'MyElectronApi: Sending "quit" to ipcRenderer'.
	self send: 'quit'.
!
