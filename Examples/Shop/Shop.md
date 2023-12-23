# Shop example

The skeleton of a webshop app with users, products and orders.\
Consists of a client (browser) and a server (NodeJS) part.\

## Shop Server

The server serves users, products and orders tot the client.
It uses the NodeJS frameworks Server and Express.
Shop data is retrieved from a SQL database, that has to be set-up first.

>[./Server/ShopServer.md](./Server/ShopServer.md)

## Shop Client

The client access the server through a JSON web API.
A login is required before accessing other pages.

>[./Client/ShopClient.md](./Client/ShopClient.md)

## Shop Client Single Page Application (SPA)

Shop client with same functionality as above,
but implemented as a Single Page Application (SPA).

>[./Client/ShopClient.md](./Client/ShopClientSpa.md)
