CLASS TestPermissions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Note: Changing a permission state requires user interaction,
 so only the current state is tested, not a specific value."

METHODS

test
	| permissions |
	permissions := Window default navigator permissions.
	self assert: [ permissions class = Permissions ].
	self assert: [ Permissions default = permissions ].
!
async testQuery
	| status |
	status := await Permissions default query: 'geolocation'.
	self assert: [ status class = PermissionStatus ].
	self assert: [ status name = 'geolocation' ].
	self assert: [ #( 'granted' 'denied' 'prompt' ) includes: status state ].
	self assert: [ status isGranted = ( status state = 'granted' ) ].
	self assert: [ status isDenied = ( status state = 'denied' ) ].
	self assert: [ status isPrompt = ( status state = 'prompt' ) ].
!
async testQueryInvalid
	| result |
	result := await async [ await Permissions default query: 'invalid-permission' ]
		tryAwaitCatch: [ :error | error ].
	self assert: [ result class = Error ].
	self assert: [ result name = 'TypeError' ].
!
async testEvents
	"The change event can only be fired by actually changing the permission,
	 so only test that listeners can be set and that dispatching works."
	| status received |
	status := await Permissions default query: 'geolocation'.
	status onChange: [ :event | received := event ].
	status dispatchEvent: ( Event type: 'change' ).
	self assert: [ received type = 'change' ].
!
