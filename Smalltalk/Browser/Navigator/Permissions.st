CLASS Permissions EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"This class encapsulates the JS class: Permissions.
 Get it with: Window default navigator permissions."

CLASSMETHODS

default
	"Return the permissions singleton."
	^ Window default navigator permissions.
!

METHODS

async query: name
	"Return the PermissionStatus for the permission name, e.g.: 'geolocation', 'notifications'.
	 Throws an error if the name is not supported by the browser."
	^ PermissionStatus fromJs: INLINE 'await this.js.query( { name: name.js } )'.
!
