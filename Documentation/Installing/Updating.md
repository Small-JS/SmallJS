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

For updating specific global packages:

### TypeScript
> `npm update -g typescript`

### HTTP server
> `npm update -g http-server`

## npm packages with the "npm Check Updates" package
To install the npm global package updater (once):
> `npm i -g npm-check-updates`

To force update of dependencies in Node.js based projects (Node, Shop/Server), \
type these lines in a terminal:
> `ncu -u`\
> `npm install`
