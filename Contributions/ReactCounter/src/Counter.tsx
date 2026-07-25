import { useState } from 'react';
import './Counter.css';
import logo from "../assets/logo.png";

// Import the ST class singleton *object*; for calling class methods like: $new()
// as well as the JS class of ST object instances; for typechecking during TS development.
// Note: The project needs to be built first to generate this JS file from ST.
import { StCounterApp, StCounter } from '../st/CounterApp.js';

// React functional cannot pass user objects to compenents directly.
// They need to be wrapped in a JS object with named arguments.
type StCounterAppProps = {
	stCounterApp: StCounterApp;
};

function Counter( { stCounterApp }: StCounterAppProps )
{
	// Introduce component update forcing function bound to a number that is *not* stored in a variable.
	// The forceUpdate() function must be called with function returnig a unique number,
	// signalling a state change and forcing the entire component to update.
	// (Yes, this is really the way functional React requires this to be done when there are no setters :-)
	const [ , forceUpdate ] = useState( 0 );

	const increment = () =>
	{
		// This increment count does not trigger an update,
		// because it does not (cannot) use setter functionality.
		stCounterApp.$increment();

		// Force component update by incrementing the invisible variable
		// that the forceUpdate function's state is bound to.
		forceUpdate( n => n + 1 );
	};

	const reset = () =>
	{
		stCounterApp.$reset();
		forceUpdate( n => n + 1 );
	};

	return (
		<>
			<table id="formTable">
				<tbody>
					<tr>
						<td className="title">
							<div className="vertical-center" >
								<img id="logoImage" src={ logo } alt="Logo" height="40" ></img>
								<span id="titleMessage">React Counter</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<span id="counterSpan">
								{/* - Call the getter method `value$()` on the ST object.
								- Access the `.js` member on the returned `StNumber` instance.
								- Type-cast the result to the JS `number` type (optional). */}
								{ ( stCounterApp.$counter() as unknown as StCounter ).$value().js as number }
							</span>
						</td>
					</tr>
					<tr>
						<td>
							<button id="incrementButton"
								onClick={ () => increment() }>+</button>
							<button id="resetButton"
								onClick={ () => reset() }>0</button>
						</td>
					</tr>
				</tbody>
			</table>
		</>
	);
}

export default Counter;
