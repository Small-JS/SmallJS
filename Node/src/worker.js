// Invoke the start method on a new NodeApp ST object.
let nodeModuleName = "./TestNode.js";
import(nodeModuleName)
    .then(module => { module.stMyNodeWorker$class.$new().$start(); });
export {};
//# sourceMappingURL=worker.js.map