# Installing SmallJS prerequisites

To install SmallJS prerequisites, see below.\
To update components, check [Updating](Updating.md)

### Visual Studio Code
Download the latest version here:
> [code.visualstudio.com/download](https://code.visualstudio.com/download)

### GIT
Download the latest version here:
> [https://git-scm.com/downloads](https://git-scm.com/downloads)

### SmallJS langage extension for Visual Studio Code
This VSCode extension provides syntax coloring and step debugging for the Smalltalk language.
To install it, in the folder ./Extension run the script:
> `deploy.sh`

Note: Strange behavior in Git Bash on Windows
The first time run, the working folder will be the Windows\System32. If that is the case exit the script and restart. Then the working folder will be the ./Extension folder.

### NodeJS
Download the latest version here:
> [nodejs.org/en/download](https://nodejs.org/en/download)

### TypeScript
To install TypeScript globally:
> `npm install -g typescript@latest`

### HTTP Server
A static HTTP server is installed globally with this command:
> `npm install -g http-server`

