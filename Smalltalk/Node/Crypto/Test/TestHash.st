CLASS TestHash EXTENDS Test MODULE NodeTest CLASSVARS '' VARS ''

test
	| hash |

	hash := Hash create: 'sha256'.
	self assert: [ hash class = Hash ].

	hash update: 'secret'.
	self assert: [ ( hash digest: 'hex' ) = '2bb80d537b1da3e38bd30361aa855686bde0eacd7162fef6a25fe97bf527a25b' ].
!
