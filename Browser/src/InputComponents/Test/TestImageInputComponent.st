CLASS TestImageInputComponent EXTENDS Test MODULE TestBrowserApp CLASSVARS '' VARS ''

test
	| imageInputComponent imageInput |
	imageInputComponent := MyBrowserApp default findComponent: ImageInputComponent.
	imageInput := imageInputComponent imageInput.

	self assert: [ imageInput type = 'image' ].
	self assert: [ imageInput src endsWith: 'SmallJS.png' ].
	self assert: [ imageInput imageSize = ( 50 @ 50 ) ].
	self assert: [ imageInput alt = 'SmallJS logo' ].
!
async testGui
	| imageInputComponent |
	imageInputComponent := MyBrowserApp default findComponent: ImageInputComponent.

	imageInputComponent imageInput click.
	await Timer timeout: 500.
	self assert: [ imageInputComponent outputParagraph textContent = 'Image clicked' ].
!
