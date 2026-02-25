CLASS Playground EXTENDS Object MODULE PlaygroundApp CLASSVARS ''
	VARS 'resultBlock errorBlock'

INLINE 'import { Evaluator } from "./Evaluator.js";'

evaluate: expression onResult: aResultBlock onError: anErrorBlock
	resultBlock := aResultBlock.
	errorBlock := anErrorBlock.
	INLINE 'new Evaluator().evaluate( expression.js, this.$onResult$.bind( this ), this.$onError$.bind( this ) )'.
!
onResult: result
	"Result might be JS undefined, convert it to nil then."
	result := Nil fromJs: result.
	resultBlock value: result.
!
onError: jsError
	errorBlock value: ( Error fromJs: jsError ).
!
