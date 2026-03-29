// This file imports exports from npm modules that are wrapped in ST elsewhere.
// This is done to facilitate inspecting their TS types in VSCode.
// This file is not used when running this app.
// Files
import * as fs from "node:fs";
let dir = new fs.Dir();
let dirent = new fs.Dirent();
let fileHandle;
let fsConstants = fs.constants;
// OS
import * as os from "node:os";
let osConstants = os.constants;
let cpus = os.cpus();
let networkInterfaces = os.networkInterfaces();
// Process
import * as process from "node:process";
let cpuUsage = process.cpuUsage();
let memoryUsage = process.memoryUsage();
let permission = process.permission;
let report = process.report;
let env = process.env;
let config = process.config;
// Workers
import * as workerThreads from "node:worker_threads";
let worker = new workerThreads.Worker("worker.js");
let parentPort = workerThreads.parentPort;
let sqDatabaseSync;
let sqDatabaseSyncOptions;
let sqtatementSync;
let pgClient;
let pgClientConfig;
let pgQueryResult;
let pgDatabaseError;
let msConnection;
let msResultSetHeader;
//# sourceMappingURL=types.js.map