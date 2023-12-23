# Shop client SPA example

This project is the shop client implemented as a Single Page Application (SPA).
Login, product and order views are based on the class `Component`.
A component has its own HTML fragment, optionally styled with its own CSS.
Components are dynamically loaded in the single HTML page.

This is a *very* lightweight equivalent of React or Angular components,\
with the diffrence that it strictly maintains the MVC design principle\
that controllers (components) should be implemented *separately* from views (HTML)\
and that controllers should have *full* control over views.

## Running

Set up  the server first, see: [../Server/ShopServer.md](../Server/ShopServer.md).\
Then start the server with `./startServer.sh` form this folder,
so that the correct client version is served.

You can select a supported browser in the VSCode debug configuration.
The default login is user "John" with password "secret", already filled in.
