CLASS TestImageComponent EXTENDS Test MODULE TestBrowserApp CLASSVARS '' VARS ''

test
	| imageComponent imageElement |
	imageComponent := MyBrowserApp default findComponent: ImageComponent.
	imageElement := imageComponent imageElement.

	imageElement complete
		ifTrue: [ self onComplete: imageElement ]
		ifFalse: [ imageElement addEventListener: 'load' then: [ self onComplete: imageElement ] ].
!
onComplete: image
	self assert: [ image src endsWith: 'SmallJS.png' ].
	self assert: [ image currentSrc includes: 'SmallJS' ].
	self assert: [ image alt = 'SmallJS logo' ].

	self assert: [ image size = ( 50 @ 50 ) ].
	self assert: [ image naturalSize = ( 800 @ 800 ) ].

	image decodeThen: [ self assert: [ true ] ]
		catch: [ :error | self error: 'Image decode failed:' error toString ].
!
