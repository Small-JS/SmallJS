// Must statically import ES modules in worker script.
// This import does not exist yet for TS, but it will exist for JS.
// So let TS ignore the error:
// @ts-ignore
import { stMyWorker$class } from "./MyWorker.js";
// Invoke the start method on a new MyWorker ST object.
stMyWorker$class.$new().$start();
//# sourceMappingURL=worker.js.map