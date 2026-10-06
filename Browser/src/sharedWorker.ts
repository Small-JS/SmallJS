// Shared worker script for the library SharedWorker tests.

// Must statically import ES modules in worker script,
// so the connect handler is set before connections arrive.
// This import does not exist yet for TS, but it will exist for JS.
// So let TS ignore the error:
// @ts-ignore
import { stMyTestSharedWorker$class } from "./TestBrowser.js";

// Invoke the start method on a new MyTestSharedWorker ST object.
stMyTestSharedWorker$class.$new().$start();
