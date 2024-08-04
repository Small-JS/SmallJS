CLASS TestFileInputComponent EXTENDS Test MODULE TestBrowserApp CLASSVARS '' VARS ''

test
	| fileInputComponent fileInput |
	fileInputComponent := MyBrowserApp default findComponent: FileInputComponent.
	fileInput := fileInputComponent fileInput.

	self assert: [ fileInput type = 'file' ].
	self assert: [ fileInput accept = 'image/png, image/jpeg' ].
	self assert: [ fileInput value = '' ].
	self assert: [ fileInput files isEmpty ].
!
