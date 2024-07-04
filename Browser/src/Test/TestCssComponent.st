CLASS TestCssComponent EXTENDS Test MODULE TestBrowserApp CLASSVARS '' VARS 'cssComponent'

testGui
	cssComponent := MyBrowserApp default findComponent: CssComponent.

	"Click apply style button a see if result gets changed to italic bold."

	cssComponent applyButton click.
	Timer timeout: 500 then: [
		self assert: [ cssComponent resultParagraph className = 'italicBold' ].
		cssComponent removeButton click.
		Timer timeout: 500 then: [
			self assert: [ cssComponent resultParagraph className = '' ] ] ].
!
