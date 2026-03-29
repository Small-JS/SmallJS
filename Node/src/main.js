// Invoke the start method on a new NodeApp ST object.
// This project is always in "test mode".
let nodeAppModuleName = "./NodeApp.js";
import(nodeAppModuleName)
    .then(module => { module.stNodeApp$class.$new().$start(); });
export {};
//# sourceMappingURL=main.js.map