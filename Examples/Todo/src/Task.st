CLASS Task EXTENDS Object MODULE Todo CLASSVARS '' VARS 'title due done'

constructor
	title := ''.
	done := false.
!

title
	^ title.
!
title: aTitle
	title := aTitle.
!

due
	^ due.
!
due: aDue
	due := aDue.
!
dueString
	^ due isNil
		ifTrue: [ '' ]
		ifFalse: [ due toLocaleDateString ].
!

done
	^ done = true.
!
done: aDone
	done := aDone = true.
!
doneString
	^ done
		ifTrue: [ String fromCharCode: 10004 ]
		ifFalse: [ String fromCharCode: 9634 ].
!
