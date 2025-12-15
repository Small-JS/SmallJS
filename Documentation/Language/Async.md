# async / await / promises

## async / await / promises in JS

Unfortunately in JS, the *called* method decides if it should (always) be executed async.\
It is not possible to circumvent this by just adding a `fork` method to the Block class,\
as is the ST standard.

In JS, it is possible to execute an 'async' method synchrounously by using the keyword `await`.\
Unfortunately the calling function using `await` *must* itself then become `async` too.\
So if there is a single async method deep down in a call stack, e.g. a file operation,\
it is common for all methods in the call stack to become `async` using `await`'s,\
to be table to execute the topmost method body sync.

An `async` JS function *alwas* returns a JS Promise, \
which resolves to the return value of that function when is it fulfilled.\
I.e.: when the async function was executed and produces a result.

## async / await / promises in SmallJS

So given the limitations above, how is async implemented in SmallJS?\
Well, it follows JS as closely as possible.\
If you know JS promises already, the following will be straightforward.

### Basic use of async / await

The `async` and `await` keywords are directly support in SmallJS.\
Here's a code example using the FS promises API:

```
	async logFileText: fileName
		| text |
		text := await Fsp readFile: fileName options: nil.
		Console log: text.
	!
```

Here, the async `readFile:options:` operation on class `Fsp` is awaited.\
Variable `text` will contain the final result of reading operation.\
Note that the funtion `logFileText:` containing `await` must now also be `async`.

### Async blocks

Next to methods, blocks can also be async by putting the `async` keyword before them:
```
	async [ object doSomething ]
```
The result of of an async block can also be awaited.\
And an async block can await internal async operations:
```
	result := await async [ await object doSometingAsync ] value.
```

Catching an error form an async block can ***only*** be done,\
if the block is awaited using the `tryAwaitCatch:` method:\
(The first `await` is optional for getting the error result)
```
	result := await async [ Object missingMethod ]
		tryAwaitCatch: [ :error | self onTryCatch: error ].
```
### Awaiting async blocks in while loops

To await the results of async funtions in `while` loops\
the special await versions should be called:\
(The first `await`'s are optional for awaiting the whole loop to finish)
```
	await async [ await object asyncBooleanMethod ] whileTrueAwait.
```
```
	await [ num < 3 ] whileTrueAwait:
		async [ await Timer timeout: 10. num := num + 1. ].
```

### Awaiting async blocks in counting loops

To await the execution of async funtions in counting loops\
their special await versions must be called:\
(The first `await`'s are optional for awaiting the whole loop to finish)
```
	await 1 to: 4 doAwait: async [ :num |
		await object asyncMethodWith: num ].
```
```
	await 4 to: 1 by: -1 doAwait: async [ :num |
		await object asyncMethodWith: num ].
```
```
	await 3 timesRepeatAwait: async [
		await object asyncMethod ].
```

### Using class Promise

If you do not want to `await` an `async` function right away,\
you can catch the JS promise it returns into an ST Promise.\
(So  return value of `async` funcitons is a *JS* `promise`, not a ST `Promise`.\
there is no way around that)

```
	async logFileText: fileName
		| promise |
		promise := Promise fromJs:
			( await Fetch: 'https://somesite.com/api` )
			then: [ :response | self handleFetch: response  ]
			catch: [ :error | self handleError: error ].
	!
```
So this code constructs a ST Promise from the JS one\
and then attaches handlers from it after completion and catches errors.
