CLASS Class EXTENDS Object MODULE Core CLASSVARS 'classes' VARS 'name superclass methods classMethods'

CLASSMETHODS

classes
	classes isNil ifTrue: [
		classes := Array new ].

	^ classes.
!

METHODS

name
	^ String fromJs: INLINE 'Naming.metaClassJsToSt( this.constructor.name )'.
!
toString
	^ 'class ' + self name.
!
superclass
	^ superclass.
!
superclass: aSuperclass
	"Should only be called by compiler generated code."
	superclass := aSuperclass.
!
classMethodNames
	^ Array fromJs: INLINE 'Object.getOwnPropertyNames( this.constructor.prototype )'
		elementConverter: [ :jsName | String fromJs: INLINE 'Naming.methodJsToSt( jsName )' ].
!
methodNames
	^ Array fromJs: INLINE 'Object.getOwnPropertyNames( this.$jsClass() )'
		elementConverter: [ :jsName | String fromJs: INLINE 'Naming.methodJsToSt( jsName )' ].
!
canUnderstand: methodName
	"Return true if this or a superclass implement the argument method."
	| class |
	class := self.
	[
		( class methodNames includes: methodName ) ifTrue: [ ^ true ].
		class := class superclass.
		class notNil.
	] whileTrue.
	^ false.
!
inheritsFrom: aClass
	| class |
	class := self.
	[
		class = aClass ifTrue: [ ^ true ].
		class := class superclass.
		class notNil.
	] whileTrue.
	^ false.
!
