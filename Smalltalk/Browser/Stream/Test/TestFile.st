CLASS TestFile EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''
	"Files can only be created (selected) by user action.
	 These tests are called from TestHtmlInputElement.testFile"

onTest: file
	| outputLabel |
	self assert: [ file class = File ].

	self assert: [ file lastModified > 0 ].
	self assert: [ file webkitRelativePath = '' ].

	outputLabel := Document default getElementById: 'fileInputOutputLabel'.
	outputLabel textContent: file name.
!

