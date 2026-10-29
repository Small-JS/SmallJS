CLASS TestQProgressBar EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| progressBar count |
	progressBar := QProgressBar new.
	self assert: [ progressBar jsClassName = 'QProgressBar' ].
	self assert: [ progressBar minimum = 0 ].
	self assert: [ progressBar maximum = 100 ].
	self assert: [ progressBar value = -1 ].
	count := 0.
	progressBar onValueChange: [ count := count + 1 ].

	progressBar setValue: 30.
	self assert: [ progressBar value = 30 ].
	self assert: [ progressBar text = '30%' ].
	self assert: [ count = 1 ].
	"A value outside the range is ignored."
	progressBar setValue: 200.
	self assert: [ progressBar value = 30 ].

	"Reset does not fire a 'valueChanged' event."
	progressBar reset.
	self assert: [ progressBar value = -1 ].
	self assert: [ count = 1 ].
!
testRange
	| progressBar |
	progressBar := QProgressBar new.
	progressBar setMinimum: 10 maximum: 20.
	self assert: [ progressBar minimum = 10 ].
	self assert: [ progressBar maximum = 20 ].
	progressBar setValue: 15.
	self assert: [ progressBar text = '50%' ].

	progressBar setMinimum: 0.
	progressBar setMaximum: 30.
	self assert: [ progressBar minimum = 0 ].
	self assert: [ progressBar maximum = 30 ].
!
testFormat
	| progressBar |
	progressBar := QProgressBar new.
	self assert: [ progressBar format = '%p%' ].
	progressBar setValue: 30.
	progressBar setFormat: '%v of %m'.
	self assert: [ progressBar format = '%v of %m' ].
	self assert: [ progressBar text = '30 of 100' ].
	progressBar resetFormat.
	self assert: [ progressBar text = '30%' ].

	self assert: [ progressBar isTextVisible ].
	progressBar setTextVisible: false.
	self assert: [ progressBar isTextVisible not ].
	progressBar setTextDirection: QProgressBar bottomToTop.
	self assert: [ progressBar textDirection = QProgressBar bottomToTop ].
!
testAppearance
	| progressBar |
	progressBar := QProgressBar new.
	self assert: [ progressBar orientation = QProgressBar horizontal ].
	progressBar setOrientation: QProgressBar vertical.
	self assert: [ progressBar orientation = QProgressBar vertical ].

	self assert: [ progressBar invertedAppearance not ].
	progressBar setInvertedAppearance: true.
	self assert: [ progressBar invertedAppearance ].

	progressBar setAlignment: QLayout alignCenter.
	self assert: [ progressBar alignment = QLayout alignCenter ].
!
