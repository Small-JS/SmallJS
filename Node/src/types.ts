// This file imports exports from npm modules that are wrapped in ST elsewhere.
// This is done to facilitate inspecting their TS types in VSCode.
// This file is not used when running this app.

// Files
import * as fs$ from "fs";
let dir = new fs$.Dir();
let dirent = new fs$.Dirent();
import * as fsp$ from "fs/promises";
let fileHandle: fsp$.FileHandle;
let fsConstants = fs$.constants;
import * as path$ from "path";

// HTTP
import http from "http";
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

// Crypto
import crypto from "crypto";

// Workers
import { Worker } from "worker_threads";

