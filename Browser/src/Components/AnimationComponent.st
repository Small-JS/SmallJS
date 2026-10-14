CLASS AnimationComponent EXTENDS Component MODULE MyBrowserApp CLASSVARS ''
	VARS 'startButton pauseButton cancelButton animationBox animation'

htmlPath
	^ 'Components/AnimationComponent.html'.
!
start
	self bindElements.
!
bindElements
	startButton := Document getElementById: 'animationStartButton' class: HtmlButtonElement.
	startButton onClick: [ self onStart ].

	pauseButton := Document getElementById: 'animationPauseButton' class: HtmlButtonElement.
	pauseButton onClick: [ self onPause ].

	cancelButton := Document getElementById: 'animationCancelButton' class: HtmlButtonElement.
	cancelButton onClick: [ self onCancel ].

	animationBox := Document getElementById: 'animationBox' class: HtmlDivElement.
!
onStart
	"Restart the animation: move the box to the right while rotating it, and back."
	animation notNil ifTrue: [ animation cancel ].
	animation := animationBox animate: self keyframes options: self options.
	pauseButton textContent: 'Pause'.
!
onPause
	"Pause the animation, or resume it when it is paused."
	animation isNil ifTrue: [ ^ self ].
	animation playState = 'paused'
		ifTrue: [
			animation play.
			pauseButton textContent: 'Pause' ]
		ifFalse: [
			animation playState = 'running' ifTrue: [
				animation pause.
				pauseButton textContent: 'Resume' ] ].
!
onCancel
	"Stop the animation and return the box to its start position."
	animation notNil ifTrue: [ animation cancel ].
	pauseButton textContent: 'Pause'.
!
keyframes
	| keyframes |
	keyframes := Array new.
	keyframes add: ( JsObject newEmpty
		atJsProperty: 'transform' put: 'translateX(0px) rotate(0deg)';
		atJsProperty: 'backgroundColor' put: 'blue' ).
	keyframes add: ( JsObject newEmpty
		atJsProperty: 'transform' put: 'translateX(200px) rotate(360deg)';
		atJsProperty: 'backgroundColor' put: 'orange' ).
	^ keyframes.
!
options
	^ JsObject newEmpty
		atJsProperty: 'duration' put: 1000;
		atJsProperty: 'iterations' put: 2;
		atJsProperty: 'direction' put: 'alternate';
		atJsProperty: 'easing' put: 'ease-in-out'.
!

"Accessing"

startButton
	^ startButton.
!
pauseButton
	^ pauseButton.
!
cancelButton
	^ cancelButton.
!
animationBox
	^ animationBox.
!
animation
	^ animation.
!
