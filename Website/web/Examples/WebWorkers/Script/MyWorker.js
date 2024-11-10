import { BlockReturn } from './Runtime.js';
import { stNil, stTrue, stFalse } from './Core.js';
import { StObject, StObject$class, stObject$class } from './Core.js';
import { StClass, StClass$class, stClass$class } from './Core.js';
import { StString, StString$class, stString$class } from './Core.js';
import { StDedicatedWorkerGlobalScope, StDedicatedWorkerGlobalScope$class, stDedicatedWorkerGlobalScope$class } from './Browser.js';
import { StBlock, StBlock$class, stBlock$class } from './Core.js';
import { StMessageEvent, StMessageEvent$class, stMessageEvent$class } from './Browser.js';
import { StMyMessage, StMyMessage$class, stMyMessage$class } from './WebWorkersApp.js';
import { StInteger, StInteger$class, stInteger$class } from './Core.js';
import { StFloat, StFloat$class, stFloat$class } from './Core.js';

export class StMyWorker extends StObject
{
	$class()
	{
		return stMyWorker$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'MyWorker' );
	}

	$start()
	{
		stDedicatedWorkerGlobalScope$class.$default().$onMessage$( stBlock$class.$fromJs$( ( messageEvent ) => {
				return this.$onMessage$( messageEvent );
			} ) );
		return this;
	}

	$onMessage$( messageEvent )
	{
		let myMessage = stNil;
		stMessageEvent$class;
		myMessage = stMyMessage$class.$fromJs$( messageEvent.$data() );
		this.$log$( stString$class.$fromJs$( 'MyWorker received message form main: id: ' ).$$comma( myMessage.$toString() ) );
		this.$work$( myMessage.$size() );
		this.$log$( stString$class.$fromJs$( 'MyWorker: Posting message back to main with id: ' ).$$comma( myMessage.$id().$toString() ) );
		stDedicatedWorkerGlobalScope$class.$default().$postMessage$( myMessage.$id() );
		return this;
	}

	$work$( size )
	{
		let sum = stNil;
		sum = stInteger$class.$fromJs$( 0 );
		size.$timesRepeat$( stBlock$class.$fromJs$( (  ) => {
				return stInteger$class.$fromJs$( 10000 ).$timesRepeat$( stBlock$class.$fromJs$( (  ) => {
				return sum = sum.$$plus( stFloat$class.$random() );
			} ) );
			} ) );
		return this;
	}

}

export class StMyWorker$class extends StObject$class
{
	$basicNew()
	{
		return new StMyWorker();
	}

	$jsClass()
	{
		return StMyWorker.prototype;
	}

}

export let stMyWorker$class = new StMyWorker$class();

stMyWorker$class.$superclass$( stObject$class );

stClass$class.$classes().$add$( stMyWorker$class );


//# sourceMappingURL=MyWorker.js.map
