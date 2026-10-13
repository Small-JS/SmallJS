CLASS TestGeolocationComponent EXTENDS Test MODULE TestMyBrowserApp CLASSVARS '' VARS ''

"Note: Clicking the current button requires user permission,
 so the display of a position and an error is tested with plain JS objects."

test
	| component |
	component := MyBrowserApp default findComponent: GeolocationComponent.
	self assert: [ component currentButton textContent = 'Current' ].
	self assert: [ component resultParagraph textContent = '[Output]' ].
!
testShowPosition
	| component position |
	component := MyBrowserApp default findComponent: GeolocationComponent.
	position := GeolocationPosition fromJs: INLINE '{ timestamp: 1000,
		coords: { latitude: 52.5, longitude: 4.25, accuracy: 10.4 } }'.
	component showPosition: position.
	self assert: [ component resultParagraph textContent
		= 'Latitude: 52.500000, longitude: 4.250000, accuracy: 10 m' ].

	component showError: ( GeolocationPositionError fromJs: INLINE '{ code: 1, message: "User denied Geolocation" }' ).
	self assert: [ component resultParagraph textContent = 'Error 1: User denied Geolocation' ].

	component resultParagraph textContent: '[Output]'.
!
