// This file imports exports from npm modules that are wrapped in ST elsewhere.
// This is done to facilitate inspecting their TS types in VSCode.
// This file is not used when running this app.

let worker: Worker;
let workerOptions: WorkerOptions;
let sharedWorker: SharedWorker;
let messageEvent: MessageEvent;
let messagePort: MessagePort;
let workerGlobalScope: WindowOrWorkerGlobalScope;
