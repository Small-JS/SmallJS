# Updating SmallJS components

## Visual Studio Code
In VSCode click the menu: Help > Check for updates...

## Node.js
Install an updated version from:
> [nodejs.org/en/download](https://nodejs.org/en/download)

## Global Node.js packages
To check for outdated global npm packages:
> `npm outdated -g`

To update all global packages:
> `npm update -g`

For updating a specific global package, e.g. TypeScript:
> `npm update -g typescript`

The packages `http-server` and `kill-port` are not installed globally.\
They are run with `npx`, which downloads them on first use.

## npm packages of SmallJS projects
To update the npm dependencies of the Compiler, Node and all examples to their latest versions,\
run this bash script in the root folder:
> `./update.sh -y`

It uses the "npm Check Updates" package (via `npx`) and then reinstalls the npm modules.\
Each of these projects also has its own `update.sh` script, to update only that project.
