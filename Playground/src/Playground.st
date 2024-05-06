CLASS Playground EXTENDS Object MODULE Browser CLASSVARS '' VARS 'resultBlock errorBlock'

INLINE 'import { Evaluator } from "../Evaluator.js";'

evaluate: expression onResult: aResultBlock onError: anErrorBlock
	resultBlock := aResultBlock.
	errorBlock := anErrorBlock.
	INLINE 'new Evaluator().evaluate( expression.js, this.$onResult$.bind( this ), this.$onError$.bind( this ) )'.
!
onResult: result
	resultBlock value: result.
!
onError: jsError
	errorBlock value: ( Error fromJs: jsError ).
!
