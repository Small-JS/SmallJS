CLASS TestCssComponent EXTENDS Test MODULE TestBrowserApp CLASSVARS '' VARS 'cssComponent'

async testGui
	cssComponent := MyBrowserApp default findComponent: CssComponent.

	"Click apply style button a see if result gets changed to italic bold."

	cssComponent applyButton click.
	await Timer timeout: 500.
	self assert: [ cssComponent resultParagraph className = 'italicBold' ].

	cssComponent removeButton click.
	await Timer timeout: 500.
	self assert: [ cssComponent resultParagraph className = '' ].
!
