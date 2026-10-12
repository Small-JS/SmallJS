// Worker script for the OffscreenCanvasComponent.

// Must statically import ES modules in worker script,
// so the message handler is set before messages arrive.
// This import does not exist yet for TS, but it will exist for JS.
// So let TS ignore the error:
// @ts-ignore
import { stMyCanvasWorker$class } from "./MyBrowserApp.js";

// Invoke the start method on a new MyCanvasWorker ST object.
stMyCanvasWorker$class.$new().$start();
