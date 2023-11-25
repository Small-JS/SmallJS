CLASS ClientApp EXTENDS Object MODULE ShopClient CLASSVARS '' VARS ''
	"Base class for client (browser) applications.
	 Use of this class is optional."

testMode
	^ Window default location search toLowerCase = '?test'.
!
navigateTo: url
	"Navigate to url page, preserving test mode."

	Window default location replace: url, Window default location search.
!
stop
	Window default close.
!
url
	"Return url of this app."
	^ Window default location hostPath.
!
