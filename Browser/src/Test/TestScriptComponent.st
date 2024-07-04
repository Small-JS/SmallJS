CLASS TestScriptComponent EXTENDS Test MODULE TestBrowserApp CLASSVARS '' VARS ''

test
	| script |

	script := Document getElementById: 'script' class: HtmlScriptElement.

	self assert: [ script id = 'script' ].
	self assert: [ script src endsWith: 'ScriptFunction.js' ].
!
testGui
	| scriptComponent  |
	scriptComponent := MyBrowserApp default findComponent: ScriptComponent.

	scriptComponent countSpan textContent: '0'.
	scriptComponent runButton click.
	Timer timeout: 500 then: [
			self assert: [ scriptComponent countSpan textContent = '1' ]  ].
!
