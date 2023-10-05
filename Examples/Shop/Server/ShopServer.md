
# Shop Server example application

This project is the server side of a very simple example web shop.
It has a static web server and a specific web API for the Shop Client.

## Running

First install npm dependencies by running `npm install` in a terminal.

Before running the server you need to set up a database.
See [../../Database/Database.md](../../Database/Database.md) on how to setup a supported database.
Copy the file `./env.example` to `.env` and edit the connection string of `SHOP_SERVER` to correctly connect to your database.
Now start the project and the application server will start on port 3000.

## Using

The server provides static file hosting and these 3 web APIs to the client:

	http://localhost:3000/api/login/?user=John&password=secret
	http://localhost:3000/api/orders
	http://localhost:3000/api/products

Start the Shop Client to access them from that application, see:
[../Client/ShopClient.md](../Client/ShopClient.md)
