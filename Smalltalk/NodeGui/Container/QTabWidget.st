CLASS QTabWidget EXTENDS QWidget MODULE NodeGui CLASSVARS '' VARS ''

"A stack of pages, with a tab bar to select the visible page. Indexes are 0-based.
 Note: JS addTab() and insertTab() do nothing with a string label (they test 'instanceof String'),
 so those methods call the native object directly."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QTabWidget()'.
!

"Tab position enums"

north
	^ 0.
!
south
	^ 1.
!
west
	^ 2.
!
east
	^ 3.
!

METHODS

"Tabs"

addTab: page label: label
	"Answer the index of the new tab."
	^ Integer fromJs: INLINE '( () => {
		const index = this.js.native.addTab_2( page.js.native, label.js );
		page.js.setFlexNodeSizeControlled( true );
		return index } )()'.
!
addTab: page icon: icon label: label
	"Answer the index of the new tab."
	^ Integer fromJs: INLINE 'this.js.addTab( page.js, icon.js, label.js )'.
!
insertTab: page at: index label: label
	"Answer the index of the new tab."
	^ Integer fromJs: INLINE 'this.js.native.insertTab_3( index.js, page.js.native, label.js )'.
!
removeTab: index
	"Remove the tab at index. The page widget is not deleted.
	 JS removeTab() resets the page after the removed one, so do it here."
	INLINE '
		const page = this.js.widget( index.js );
		this.js.native.removeTab( index.js );
		page?.setFlexNodeSizeControlled( false )'.
!
count
	^ Integer fromJs: INLINE 'this.js.property( "count" ).toInt()'.
!
widget: index
	"Answer the page at index, or nil if there is none."
	^ QWidget fromJs: INLINE 'this.js.widget( index.js )'.
!
indexOf: page
	"Answer the index of page, or -1 if it is not in this tab widget."
	^ Integer fromJs: INLINE 'this.js.indexOf( page.js )'.
!
setTabText: text at: index
	INLINE 'this.js.setTabText( index.js, text.js )'.
!
setTabIcon: icon at: index
	INLINE 'this.js.setTabIcon( index.js, icon.js )'.
!
setTabPosition: tabPosition
	INLINE 'this.js.setTabPosition( tabPosition.js )'.
!
setTabsClosable: closable
	"Closable tabs have a close button, see onTabCloseRequest:."
	INLINE 'this.js.setTabsClosable( closable.js )'.
!

"Current tab"

setCurrentIndex: index
	INLINE 'this.js.setCurrentIndex( index.js )'.
!
currentIndex
	"Answer -1 if there are no tabs."
	^ Integer fromJs: INLINE 'this.js.currentIndex()'.
!

"Events"

onCurrentChange: block
	self addEventListener: 'currentChanged' then: [ block value ].
!
onTabCloseRequest: block
	"Block is called with the index of the tab whose close button was clicked."
	INLINE 'this.js.addEventListener( "tabCloseRequested", index => block.$value$( stInteger$class.$fromJs$( index ) ) )'.
!
