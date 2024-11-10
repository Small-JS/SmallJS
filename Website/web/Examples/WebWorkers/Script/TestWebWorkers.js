import { BlockReturn } from './Runtime.js';
import { stNil, stTrue, stFalse } from './Core.js';
import { StObject, StObject$class, stObject$class } from './Core.js';
import { StClass, StClass$class, stClass$class } from './Core.js';
import { StString, StString$class, stString$class } from './Core.js';
import { StTest, StTest$class, stTest$class } from './Core.js';
import { StBlock, StBlock$class, stBlock$class } from './Core.js';
import { StTimer, StTimer$class, stTimer$class } from './Core.js';
import { StInteger, StInteger$class, stInteger$class } from './Core.js';

export class StTestWebWorkersApp extends StObject
{
	webWorkersApp = stNil;

	$class()
	{
		return stTestWebWorkersApp$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'TestWebWorkers' );
	}

	$test$( aWebWorkersApp )
	{
		this.webWorkersApp = aWebWorkersApp;
		stTest$class.$allThen$( stBlock$class.$fromJs$( (  ) => {
				return this.$testGui();
			} ) );
		return this;
	}

	$testGui()
	{
		this.webWorkersApp.$workSizeInput().$value$( stString$class.$fromJs$( '100' ) );
		this.webWorkersApp.$workersInput().$value$( stString$class.$fromJs$( '2' ) );
		stTimer$class.$timeout$then$( stInteger$class.$fromJs$( 1000 ), stBlock$class.$fromJs$( (  ) => {
				this.webWorkersApp.$startButton().$click();
				return stTimer$class.$timeout$then$( stInteger$class.$fromJs$( 4000 ), stBlock$class.$fromJs$( (  ) => {
				this.$checkResults();
				return this.webWorkersApp.$stop();
			} ) );
			} ) );
		return this;
	}

	$checkResults()
	{
		let rows = stNil;
		rows = this.webWorkersApp.$resultsTable().$tBody().$rows();
		this.$assert$( stBlock$class.$fromJs$( (  ) => {
				return rows.$length().$$equeals( stInteger$class.$fromJs$( 2 ) );
			} ) );
		rows.$do$( stBlock$class.$fromJs$( ( row ) => {
				this.$assert$( stBlock$class.$fromJs$( (  ) => {
				return row.$cells().$at$( stInteger$class.$fromJs$( 1 ) ).$textContent().$toInteger().$$gt$equeals( stInteger$class.$fromJs$( 1 ) );
			} ) );
				return this.$assert$( stBlock$class.$fromJs$( (  ) => {
				return row.$cells().$at$( stInteger$class.$fromJs$( 1 ) ).$textContent().$toInteger().$$gt$equeals( stInteger$class.$fromJs$( 10 ) );
			} ) );
			} ) );
		return this;
	}

}

export class StTestWebWorkersApp$class extends StObject$class
{
	$basicNew()
	{
		return new StTestWebWorkersApp();
	}

	$jsClass()
	{
		return StTestWebWorkersApp.prototype;
	}

}

export let stTestWebWorkersApp$class = new StTestWebWorkersApp$class();

stTestWebWorkersApp$class.$superclass$( stObject$class );

stClass$class.$classes().$add$( stTestWebWorkersApp$class );


//# sourceMappingURL=TestWebWorkers.js.map
