CLASS OsUserInfo EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''


username
	^ String fromJs: INLINE 'this.js.username'.
!
uid
	^ Integer fromJs: INLINE 'this.js.uid'.
!
gid
	^ Integer fromJs: INLINE 'this.js.gid'.
!
shell
	^ String fromJs: INLINE 'this.js.shell'.
!
homedir
	^ String fromJs: INLINE 'this.js.homedir'.
!
