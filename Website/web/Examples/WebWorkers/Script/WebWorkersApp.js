import { BlockReturn } from './Runtime.js';
import { stNil, stTrue, stFalse } from './Core.js';
import { StObject, StObject$class, stObject$class } from './Core.js';
import { StClass, StClass$class, stClass$class } from './Core.js';
import { StString, StString$class, stString$class } from './Core.js';
import { StBrowserApp, StBrowserApp$class, stBrowserApp$class } from './Browser.js';
import { StArray, StArray$class, stArray$class } from './Core.js';
import { StTestWebWorkersApp, StTestWebWorkersApp$class, stTestWebWorkersApp$class } from './TestWebWorkers.js';
import { StBlock, StBlock$class, stBlock$class } from './Core.js';
import { StDocument, StDocument$class, stDocument$class } from './Browser.js';
import { StHtmlInputElement, StHtmlInputElement$class, stHtmlInputElement$class } from './Browser.js';
import { StHtmlTableElement, StHtmlTableElement$class, stHtmlTableElement$class } from './Browser.js';
import { StHtmlButtonElement, StHtmlButtonElement$class, stHtmlButtonElement$class } from './Browser.js';
import { StInteger, StInteger$class, stInteger$class } from './Core.js';
import { StDate, StDate$class, stDate$class } from './Core.js';
import { StWorker, StWorker$class, stWorker$class } from './Browser.js';
import { StWorkerOptions, StWorkerOptions$class, stWorkerOptions$class } from './Browser.js';

export class StMyMessage extends StObject
{
	id = stNil;
	size = stNil;

	$class()
	{
		return stMyMessage$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'WebWorkersApp' );
	}

	$id()
	{
		return this.id;
	}

	$id$( aId )
	{
		this.id = aId;
		return this;
	}

	$size()
	{
		return this.size;
	}

	$size$( aSize )
	{
		this.size = aSize;
		return this;
	}

	$toString()
	{
		return stString$class.$fromJs$( 'MyMessage( id: ' ).$$comma( this.id.$toString() ).$$comma( stString$class.$fromJs$( ', size: ' ) ).$$comma( this.size.$toString() ).$$comma( stString$class.$fromJs$( ' )' ) );
	}

}

export class StWebWorkersApp extends StBrowserApp
{
	workers = stNil;
	workSizeInput = stNil;
	workersInput = stNil;
	startButton = stNil;
	resultsTable = stNil;
	startTime = stNil;

	$class()
	{
		return stWebWorkersApp$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'WebWorkersApp' );
	}

	$start()
	{
		try {
		this.workers = stArray$class.$new();
		this.$bindElements();
		this.$testMode().$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stTestWebWorkersApp$class.$new().$test$( this ) );
			} ) );
		return this;
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

	$bindElements()
	{
		this.workSizeInput = stDocument$class.$getElementById$class$( stString$class.$fromJs$( 'workSizeInput' ), stHtmlInputElement$class );
		this.workersInput = stDocument$class.$getElementById$class$( stString$class.$fromJs$( 'workersInput' ), stHtmlInputElement$class );
		this.resultsTable = stDocument$class.$getElementById$class$( stString$class.$fromJs$( 'resultsTable' ), stHtmlTableElement$class );
		this.startButton = stDocument$class.$getElementById$class$( stString$class.$fromJs$( 'startButton' ), stHtmlButtonElement$class );
		this.startButton.$onClick$( stBlock$class.$fromJs$( (  ) => {
				return this.$onStart();
			} ) );
		return this;
	}

	$totalWorkSize()
	{
		return this.workSizeInput.$value().$toInteger();
	}

	$workerCount()
	{
		return this.workersInput.$value().$toInteger();
	}

	$workerSize()
	{
		return this.$totalWorkSize().$$sol( this.$workerCount() ).$toInteger();
	}

	$onStart()
	{
		this.$clearResults();
		this.$startWorkers();
		return this;
	}

	$clearResults()
	{
		let row = stNil;
		this.resultsTable.$tBody().$innerHtml$( stString$class.$fromJs$( '' ) );
		stInteger$class.$fromJs$( 1 ).$to$do$( this.$workerCount(), stBlock$class.$fromJs$( ( index ) => {
				row = this.resultsTable.$tBody().$insertRow$( stInteger$class.$fromJs$( -1 ) );
				row.$insertCell().$textContent$( index.$toString() );
				return row.$insertCell();
			} ) );
		return this;
	}

	$startWorkers()
	{
		this.$stopWorkers();
		this.startTime = stDate$class.$now();
		stInteger$class.$fromJs$( 1 ).$to$do$( this.$workerCount(), stBlock$class.$fromJs$( ( index ) => {
				return this.$startWorker$( index );
			} ) );
		return this;
	}

	$stopWorkers()
	{
		this.workers.$do$( stBlock$class.$fromJs$( ( worker ) => {
				return worker.$terminate();
			} ) );
		this.workers = stArray$class.$new();
		return this;
	}

	$startWorker$( index )
	{
		let worker = stNil;
		let message = stNil;
		worker = stWorker$class.$new$options$( stString$class.$fromJs$( 'Script/worker.js' ), stWorkerOptions$class.$new().$type$( stString$class.$fromJs$( 'module' ) ) );
		worker.$onMessage$( stBlock$class.$fromJs$( ( event ) => {
				return this.$onWorkerMessage$( event );
			} ) );
		message = ( () => { let $object$ = stMyMessage$class.$new();
			$object$.$id$( index );
			return $object$.$size$( this.$workerSize() );
		} ) ();
		worker.$postMessage$( message );
		this.workers.$add$( worker );
		return this;
	}

	$onWorkerMessage$( event )
	{
		let runTime = stNil;
		let workerId = stNil;
		let cell = stNil;
		runTime = stDate$class.$now().$$minus( this.startTime );
		workerId = stInteger$class.$fromJs$( event.$data().$js() );
		this.$log$( stString$class.$fromJs$( 'WebWorkersApp.onWorkerMessage: received id: ' ).$$comma( workerId.$toString() ) );
		this.workers.$at$( workerId.$$minus( stInteger$class.$fromJs$( 1 ) ) ).$terminate();
		cell = this.resultsTable.$rows().$at$( workerId ).$cells().$at$( stInteger$class.$fromJs$( 1 ) );
		cell.$textContent$( runTime.$toString() );
		return this;
	}

	$workSizeInput()
	{
		return this.workSizeInput;
	}

	$workersInput()
	{
		return this.workersInput;
	}

	$resultsTable()
	{
		return this.resultsTable;
	}

	$startButton()
	{
		return this.startButton;
	}

}

export class StMyMessage$class extends StObject$class
{
	$basicNew()
	{
		return new StMyMessage();
	}

	$jsClass()
	{
		return StMyMessage.prototype;
	}

	$fromJs$( jsObject )
	{
		return ( () => { let $object$ = this.$new();
			$object$.$id$( jsObject.$atJsProperty$( stString$class.$fromJs$( 'id' ) ) );
			return $object$.$size$( jsObject.$atJsProperty$( stString$class.$fromJs$( 'size' ) ) );
		} ) ();
	}

}

export class StWebWorkersApp$class extends StBrowserApp$class
{
	$basicNew()
	{
		return new StWebWorkersApp();
	}

	$jsClass()
	{
		return StWebWorkersApp.prototype;
	}

}

export let stMyMessage$class = new StMyMessage$class();
export let stWebWorkersApp$class = new StWebWorkersApp$class();

stMyMessage$class.$superclass$( stObject$class );
stWebWorkersApp$class.$superclass$( stBrowserApp$class );

stClass$class.$classes().$add$( stMyMessage$class );
stClass$class.$classes().$add$( stWebWorkersApp$class );


//# sourceMappingURL=WebWorkersApp.js.map
