// This file imports exports from npm modules that are wrapped in ST elsewhere.
// This is done to facilitate inspecting their TS types in VSCode.
// This file is not used when running this app.

// Files
import * as fs from "node:fs";
let dir = new fs.Dir();
let dirent = new fs.Dirent();
import * as fsp from "fs/promises";
let fileHandle: fsp.FileHandle;
let fsConstants = fs.constants;
import * as path$ from "path";

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
let worker = new workerThreads.Worker( "worker.js" );
let parentPort = workerThreads.parentPort;

// Crypto
import crypto from "node:crypto";

// HTTP
import http from "node:http";
import { createHttpTerminator } from "http-terminator";

// Express
import express from "express";
import cors from "express";
import session from "express-session";

// Databases
import { QueryResult, DatabaseError, Client, ClientConfig } from "pg";
import * as Mariadb from "mariadb";
import * as MySql from "mysql2";
import { DatabaseSync, DatabaseSyncOptions, StatementSync } from "node:sqlite";

