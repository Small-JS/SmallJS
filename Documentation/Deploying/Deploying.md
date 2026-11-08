# Deploying a SmallJS app

Which files you need to deploy depends on the type of project.\
Below are the general rules; a specific app may need more files.

## Web projects

For web (browser) projects, copy the `web` folder to your web server,\
including its subfolder `Script`, which contains the generated JavaScript code.

## Node.js projects

For Node.js projects, you will probably need these folders and files:
- `out`: the generated JavaScript code.
- `node_modules`: the npm packages used by the app.
- `package.json`: declares the generated code as ES modules (`"type": "module"`).\
  Without it, Node.js cannot load the generated code.
- `.env`: the settings of the app, e.g. database connection strings.
- `start.sh`: the script that loads the settings from `.env` and starts the app.
