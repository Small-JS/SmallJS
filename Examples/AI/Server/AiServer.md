# AI Server example app

This project is the server side of a simple AI text chat app.\
It has a static web server and a specific web API for the AI Client.\
This server can route chat requests to supported AI providers in a unified manner.

## Running

First install npm dependencies by running `npm install` in a terminal.

Before running the server you need to set the AI providers to user.\
Copy the file `./env.example` to `.env` and uncomment the AI providers you want to use.\
You will have to put in your own secret API keys to be able to connect to paid models.

Start the AI Client to access them from that application, see:
[../Client/AiClient.md](../Client/AiClient.md)

## Using

The server provides static file web hosting plus these web APIs to the client:

### API: api/providers

#### Description

Returns all available providers and their suggested models to the client.

#### Example call

`http://localhost:3000/api/providers`

This request does not have any arguments.

#### Example response

`[ { "provider": "openai", "models": [ "gpt-4o", "gpt-4.1" ] } ,`\
`{ "provider": "deepseek", "models": [ "deepseek-chat", "deepseek-reasoner" ] } ]`

The response is implemented in the ST class: `AiProviders`

### API: api/chat

#### Description

Calls the specified AI provider and model with a single text question (prompt)\
and returns the single text answer.

#### Example call

`http://localhost:3000/api/chat/?text=Say+this+is+a+test`

The request is implemented in the ST class: `AiChatRequest`

#### Example response

`{ "success": true, "text": "This is a test. How can I assist you further?" }`

The response is implemented in the ST class: `AiChatResponse`

## Installing AI providers

The following AI providers are supported:

### Ollama with models Llama* and more

With Ollama you can run models locally, so you don't need API keys and buy tokens.\
The Ollama server software can be downloaded here: [ollama.com/download](https://ollama.com/download)\
Ollama supports open source models. A small 2 GB starter model is Llama 3.2.\
You can download, install and run it with: `ollama run llama3.2`

### OpenAI with models GTP*,  O*

A popular AI provider, also powering ChatGPT.

You can create an account here: [auth.openai.com/create-account](https://auth.openai.com/create-account)

### Deepseek with models R*

An opensource, free AI provider, rivaling OpenAI.

You can create an account here: [platform.deepseek.com/sign_up](https://platform.deepseek.com/sign_up)

### Deepseek with models R*

An opensource, free AI provider, rivaling OpenAI.\
It's API is compatible with that of OpenAI.

You can create an account here: [platform.deepseek.com/sign_up](https://platform.deepseek.com/sign_up)

### Google AI with models Gemini*

Google's AI offering, now with improved Gemini models.

You can create an account here: [aistudio.google.com](https://aistudio.google.com)

### Anthropic with models Claude*

Anthropic's Claude models are traditionally strong for development support.\
But competitors are growing fast.

You can create an account here: [console.anthropic.com](https://console.anthropic.com)
