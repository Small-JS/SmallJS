CLASS TestHtmlAudioElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"The inherited properties and methods are tested in TestHtmlMediaElement."

METHODS

test
	| audio |
	audio := Document default createElement: 'audio'.
	self assert: [ audio class = HtmlAudioElement ].
	self assert: [ audio isKindOf: HtmlMediaElement ].
	self assert: [ audio tagName = 'AUDIO' ].
!
testNew
	| audio |
	audio := HtmlAudioElement new.
	self assert: [ audio class = HtmlAudioElement ].
	self assert: [ audio src = '' ].
	"The constructor sets the preload attribute to 'auto'."
	self assert: [ audio preload = 'auto' ].
!
async testLoad
	"Only test loading, not playing, because Chrome does not allow playing audio
	 without user interaction, also not when muted."
	| audio loading |
	audio := HtmlAudioElement src: TestHtmlMediaElement silenceUrl.
	self assert: [ audio src startsWith: 'data:audio/wav' ].
	loading := Promise new: [ :resolve :reject |
		audio onLoadedMetadata: [ :event | resolve value: event ].
		audio addEventListener: 'error' then: [ :event | reject value: 'Audio error' ] ].
	await loading js.
	self assert: [ audio readyState >= HtmlMediaElement haveMetadata ].
	self assert: [ audio duration equals: 0.5 precision: 0.01 ].
	self assert: [ audio paused ].
!
