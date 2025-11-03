// This file imports exports from npm modules that are wrapped in ST elsewhere.
// This is done to facilitate inspecting their TS types in VSCode.
// This file is not used when running this app.

// AI - Ollama
import * as ollama from "ollama";
let olOllama: ollama.Ollama;
let olChatRequest: ollama.ChatRequest;
let olChatResponse: ollama.ChatResponse;
let olMessage: ollama.Message;

// AI - OpenAI
import Openai from "openai";
let oaiChatCompletion: Openai.ChatCompletion;
let oaiChatCompletionChoice: Openai.ChatCompletion.Choice;
let oaiChatCompletionMessage: Openai.ChatCompletionMessage;
let oaiChatCompletionUsage: Openai.CompletionUsage;
let oaiCompletionTokensDetails: Openai.CompletionUsage.CompletionTokensDetails;
let oaiPromptTokensDetails: Openai.CompletionUsage.PromptTokensDetails;

// AI - Google AI
import * as googleai from "@google/generative-ai";
let gaiGoogleAi: googleai.GoogleGenerativeAI;
let gaiModelParams: googleai.ModelParams;
let gaiGenerativeModel: googleai.GenerativeModel;
let gaiGenerateContentResult: googleai.GenerateContentResult;
let gaiGenerateContentResponse: googleai.GenerateContentResponse;

// AI - Anthropic
import * as anthropic from "@anthropic-ai/sdk";
let antAnthropic: anthropic.Anthropic;
let antClientOptions: anthropic.ClientOptions;
import { MessageCreateParams } from '@anthropic-ai/sdk/resources/index.mjs';
import { Message } from '@anthropic-ai/sdk/resources/index.mjs';
import { TextBlock } from '@anthropic-ai/sdk/resources/index.mjs';
