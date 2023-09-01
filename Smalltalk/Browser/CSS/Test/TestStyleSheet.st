CLASS TestStyleSheet EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

browserOnly
	^ true.
!
test
	| styleSheet |
	styleSheet := Document default styleSheets first.

	"Note: The StyleSheet class is never used by itself, only CssStyleSheet."
	self assert: [ styleSheet class = CssStyleSheet ].

	self assert: [ styleSheet disabled not ].
	styleSheet disabled: true.
	self assert: [ styleSheet disabled ].
	styleSheet disabled: false.

	self assert: [ styleSheet href endsWith: 'App.css' ].
	self assert: [ styleSheet media class = MediaList ].
	self assert: [ styleSheet ownerNode class = HtmlLinkElement ].
	self assert: [ styleSheet title = 'App CSS title' ].
	self assert: [ styleSheet type = 'text/css' ].
!
