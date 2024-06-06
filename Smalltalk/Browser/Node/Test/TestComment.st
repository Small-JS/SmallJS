CLASS TestComment EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| comment |

	comment := Comment new: 'New comment.'.
	self assert: [ comment data = 'New comment.' ].

	comment := Document default createComment: 'Comment in document.'.
	Document default head appendChild: comment.
	self assert: [ Document default head lastChild class = Comment ].
!
