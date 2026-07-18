// This file imports exports from npm modules that are wrapped in ST elsewhere.
// This is done to facilitate inspecting their TS types in VSCode.
// This file is not used when running this app.

// AI - Ollama
import * as ollama from "ollama";
let olOllama: ollama.Ollama;
let olChatRequest: ollama.ChatRequest;
let olChatResponse: ollama.ChatResponse;
let olMessage: ollama.Message;
let olEmbedRequest: ollama.EmbedRequest;
let olEmbedResponse: ollama.EmbedResponse;


// Postgres
import * as pg from "pg";
let pgClient: pg.Client;
let pgClientConfig: pg.ClientConfig;
let pgQueryResult: pg.QueryResult;
let pgDatabaseError: pg.DatabaseError;

