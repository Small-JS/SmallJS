// React libraries.
import React from 'react';
import { createRoot } from 'react-dom/client';

// Local HTML and components.
import './index.css';
import Counter from './Counter.tsx';

// Local logic.
// import { TestCounter } from './TestCounter';
import { stCounterApp$class, StCounterApp } from '../st/CounterApp.js';
import { stTestCounterApp$class, StTestCounterApp } from '../st/TestCounterApp.js';

startApp();

export function startApp()
{
	let stCounterApp = stCounterApp$class.$new() as StCounterApp;
	stCounterApp.$start();

	const rootHtmlElement = document.getElementById( 'root' ) as HTMLDivElement;
	const reactRoot = createRoot( rootHtmlElement );
	const reactElement = React.createElement( Counter, { stCounterApp: stCounterApp } );
	reactRoot.render( reactElement );

	if( window.location.search.toLowerCase() == '?test' ) {
		let stTestCounterApp = stTestCounterApp$class.$new() as StTestCounterApp;
		stTestCounterApp.$startOn$( stCounterApp );
	}
}

