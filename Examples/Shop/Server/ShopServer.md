
# Shop Server example application

This project is the server side of a very simple example web shop.
It has a static web server and a specific web API for the Shop Client.

## Running

First install npm dependencies by running `./install.sh` in a terminal.

Before running the server you need to set up a database.
See [../../../Database/Database.md](../../../Database/Database.md) on how to setup a supported database.
Copy the file `.env.example` to `.env` and edit the connection string of `SHOP_DATABASE` to correctly connect to your database.
In `.env`, `SHOP_CLIENT` selects the client app to serve and `SHOP_PORT` the server port.
Now build and test the project with `./build.sh` and start the server with `./start.sh`.
With the default settings, the server starts on port 3000.

## Using

The server provides static file hosting and these 3 web APIs to the client:

	http://localhost:3000/api/login?name=John&password=secret
	http://localhost:3000/api/orders
	http://localhost:3000/api/products

Start the Shop Client to access them from that application, see:
[../Client/ShopClient.md](../Client/ShopClient.md)
