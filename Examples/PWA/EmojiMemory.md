# EmojiMemory example application

This project is a SmallJS implementation of Progressive Web App (PWA),\
that implements the card pairing game memory,\
using emojis for the faces of the cards.

## Running

First run `./startWebServer.sh`.\
Then start the project in VSCode with `F5`.

Note that the app is running on port 3010 (not 3000).\
This is done to prevent PWA caching and the registered ServiceWorker\
to be activated when testing other websites.

## Installing

When the app page is open, the browser it can be saved to a local app:\
On PC's, click the "Install" button in the address bar.
On mobile, select the option "Add to phone" | "Install".

### Adapting

To create you own SmallJS PWA app, start by making a copy of this project.\
The file `web/pwa.webmanifest` describes the app version and files to be cached for offline use.\
The file `web/ServiceWorker.js` implements he mandatory service worker process for the PWA.\
If your app needs to communicate with a server (fetch) or use native features,\
this file will need te be expanded.

