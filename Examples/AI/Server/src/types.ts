// This file imports exports from npm modules that are wrapped in ST elsewhere.
// This is done to facilitate inspecting their TS types in VSCode.
// This file is not used when running this app.

// AI - Ollama
import * as Ollama from "ollama";
let ollamaOllama: Ollama.Ollama;
let ollamaChatRequest: Ollama.ChatRequest;
let ollamaChatResponse: Ollama.ChatResponse;
let ollamaMessage: Ollama.Message;
let ollamaEmbedRequest: Ollama.EmbedRequest;
let ollamaEmbedResponse: Ollama.EmbedResponse;

// AI - OpenAI
import Openai from "openai";
let openaiChatCompletion: Openai.ChatCompletion;
let openaiChatCompletionChoice: Openai.ChatCompletion.Choice;
let openaiChatCompletionMessage: Openai.ChatCompletionMessage;
let openaiChatCompletionUsage: Openai.CompletionUsage;
let openaiCompletionTokensDetails: Openai.CompletionUsage.CompletionTokensDetails;
let openaiPromptTokensDetails: Openai.CompletionUsage.PromptTokensDetails;

// AI - Google AI
import * as Googleai from "@google/generative-ai";
let googleaiGoogleAi: Googleai.GoogleGenerativeAI;
let googleaiGenerativeModel: Googleai.GenerativeModel;
let googleaiModelParams: Googleai.ModelParams;
let googleaiGenerateContentResult: Googleai.GenerateContentResult;
let googleaiGenerateContentResponse: Googleai.GenerateContentResponse;
let googleaiEnhancedGenerateContentResponse: Googleai.EnhancedGenerateContentResponse;

// AI - Anthropic
import * as Anthropic from "@anthropic-ai/sdk";
let anthropicAnthropic: Anthropic.Anthropic;
let anthropicClientOptions: Anthropic.ClientOptions;
import { MessageCreateParams } from '@anthropic-ai/sdk/resources/index.mjs';
import { Message } from '@anthropic-ai/sdk/resources/index.mjs';
import { TextBlock } from '@anthropic-ai/sdk/resources/index.mjs';
