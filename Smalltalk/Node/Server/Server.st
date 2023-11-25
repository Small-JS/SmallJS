CLASS Server EXTENDS JsObject MODULE Server CLASSVARS '' VARS ''

"INLINE 'import http from 'http';'"
INLINE 'import { createHttpTerminator } from "http-terminator";'

close
	INLINE 'this.js.close()'.
!
closeAllConnections
	INLINE 'this.js.closeAllConnections()'.
!
terminate
	INLINE '
		let server = this.js;
		const httpTerminator = createHttpTerminator( { server, } );
		httpTerminator.terminate();'.
!
