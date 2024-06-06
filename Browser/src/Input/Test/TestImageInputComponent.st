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
testGui
	| imageInputComponent |
	imageInputComponent := MyBrowserApp default findComponent: ImageInputComponent.

	imageInputComponent imageInput click.
	Timer timeout: 500 then: [
			self assert: [ imageInputComponent outputLabel textContent = 'Image clicked' ] ]."
!
