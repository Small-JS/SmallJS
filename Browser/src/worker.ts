// Worker script for the library Worker tests.

// Must statically import ES modules in worker script,
// so the message handler is set before messages arrive.
// This import does not exist yet for TS, but it will exist for JS.
// So let TS ignore the error:
// @ts-ignore
import { stMyTestWorker$class } from "./TestBrowser.js";

// Invoke the start method on a new MyTestWorker ST object.
stMyTestWorker$class.$new().$start();
