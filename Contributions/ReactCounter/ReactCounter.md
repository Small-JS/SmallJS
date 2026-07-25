# ReactCounter - SmallJS counter in React component

The example project demonstrates how to use SmallJS within a React component.\
The idea is to use React componentes only as a GUI layer, in `*.tsx` files.\
And bind these componennts to Smalltalk objects that contain the data to be displayed\
and to perform any client side logic like fetching data from a server.

This example only implements a simple counter example using this setup:\
The React module in `Counter.tsx` contains the GUI, \
that is bound to the Smalltalk class in `Counter.st` containing counter logic.

## Use case

You could use this setup when you have a React code base already,\
and want to add Smalltalk for the logic, maybe even incrementally.

Of course, SmallJS does not *require* React to create a web app.\
The example app [Counter.md](../../Examples/Counter/Counter.md)
has the same functionality with minimal code and dependencies.\
And for creating more complex (SPA) web apps there is the leightweight `Component` class.\
Check out the example app  [ShopClientSpa.md](../../Examples/Shop/ClientSpa/ShopClientSpa.md) on how to use it.

## Running

This project is based on the standard Vite TypeScript template.\
It runs on the Vite server, but does not use any server-side React,\
so any static web server can host the web app.

It's assumed that your SmallJS setup is already operational.\
Otherwise see the `README.md` of this repo to install and build it.

First run `install.sh` to install React libraries and tools.\
Then open VSCode with the workspace `ReactCounter.code-workspace` .\
This will automatically start the Vite web server.\
Now press the `Run and Debug` button to start the counter app.\
A chrome browser should launch displaying a counter\
with working bottons to increment and reset it.

## Code

In VSCode, check out the file `Counter.tsx` to see how the React compoment\
binds to the Smalltalk class `CounterApp` in the file `CounterApp.st`.\
The class `CounterApp` contains model class `Counter` that holds the counter value.

## Evaluation

React is optimized for binding JS variables with basic values to HTML elements\
and then update the elements automatically when the values change.\
To automate this, React defines its own HTML template language (JSX, TSX),\
that invisibly turns variables into react-variables with event handlers attached.

This is not a good fit for complex OO objects,\
where possibly updated values are returned dynamically from methods\
and thus are not permanent variables under Reacts control.\
So you will have to tell React explicitly what changed when,\
which kind of defeats the purpose of React.

If you know a way to make this integration more smooth,\
like a simple way to bind React state to user defined getter and setter methods,\
please open an issue in this repo.

So use this project template only if you have a large React code base already.\
The recommended way for developing web apps in SmallJS\
is to use the lightweight `Component` class and explicit update methods.\
This is faster, leaner and makes it much easier to optimize partial updates.
