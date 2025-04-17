// This file imports exports from npm modules that are wrapped in ST elsewhere.
// This is done to facilitate inspecting their TS types in VSCode.
// This file is not used when running this app.

// Files
import * as fs$ from "fs";
import * as path$ from "path";

// HTTP
import http from "http";
import { createHttpTerminator } from "http-terminator";

// Express
import express from "express";
import cors from "express";
import session from "express-session";

// AI - OpenAI
import OpenAI from "openai";
import { ChatCompletion } from "openai/resources/chat/completions.js";
type ChatCompletionChoice = ChatCompletion.Choice;
import { ChatCompletionMessage } from "openai/resources/chat/completions.js";
import { CompletionUsage } from "openai/resources/completions.js";
type CompletionUsageCompletionTokensDetails = CompletionUsage.CompletionTokensDetails;
type CompletionUsagePromptTokensDetails = CompletionUsage.PromptTokensDetails;

// AI - Google AI
import { GoogleGenerativeAI, ModelParams, GenerativeModel,
	GenerateContentResult, GenerateContentResponse } from "@google/generative-ai";

// AI - Anthropic
import { Anthropic, ClientOptions } from '@anthropic-ai/sdk';
import { MessageCreateParamsNonStreaming } from '@anthropic-ai/sdk/resources/index.mjs';
import { Message, TextBlock } from '@anthropic-ai/sdk/resources/index.mjs';
