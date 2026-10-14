CLASS TestAnimationComponent EXTENDS Test MODULE TestMyBrowserApp CLASSVARS '' VARS ''

test
	| component |
	component := MyBrowserApp default findComponent: AnimationComponent.
	self assert: [ component startButton textContent = 'Start' ].
	self assert: [ component pauseButton textContent = 'Pause' ].
	self assert: [ component cancelButton textContent = 'Cancel' ].
	self assert: [ component animationBox class = HtmlDivElement ].
	self assert: [ component animation isNil ].
!
async testGui
	| component first |
	component := MyBrowserApp default findComponent: AnimationComponent.

	component startButton click.
	first := component animation.
	self assert: [ first class = Animation ].
	self assert: [ first playState = 'running' ].
	self assert: [ component animationBox getAnimations first = first ].

	"Clicking start again restarts the animation."
	component startButton click.
	self assert: [ first playState = 'idle' ].
	self assert: [ component animation playState = 'running' ].

	component pauseButton click.
	self assert: [ component animation playState = 'paused' ].
	self assert: [ component pauseButton textContent = 'Resume' ].

	component pauseButton click.
	self assert: [ component animation playState = 'running' ].
	self assert: [ component pauseButton textContent = 'Pause' ].

	"Cancel while paused resets the pause button."
	component pauseButton click.
	self assert: [ component pauseButton textContent = 'Resume' ].

	component cancelButton click.
	self assert: [ component animation playState = 'idle' ].
	self assert: [ component pauseButton textContent = 'Pause' ].
	self assert: [ component animationBox getAnimations length = 0 ].

	component startButton click.
	component animation finish.
	await component animation finished.
	self assert: [ component animation playState = 'finished' ].
	self assert: [ component animationBox getAnimations length = 0 ].
!
