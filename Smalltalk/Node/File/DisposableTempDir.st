CLASS DisposableTempDir EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"A temporary directory created by: Fs mkdtempDisposableSync:options: or Fsp mkdtempDisposable:options:.
 Call remove to delete it with all its contents."

METHODS

path
	^ String fromJs: INLINE 'this.js.path'.
!
async remove
	"Remove the directory and its contents.
	 Sync for Fs created directories, async for Fsp created ones."
	INLINE 'await this.js.remove()'.
!
