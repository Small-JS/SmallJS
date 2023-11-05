# Benchmark examples

The subfolders here contain SmallJS benchmarks to run in browsers.\
Note that NodeJS uses the V8 JavaScript engine, found in Chrome and Edge,\
so it should produce similar results.

Each benchmark is implemented in ST and in native JS, too see the difference.\
The results show then SmallJS runs quite a bit slower than native JS.\
For admnistative applications this should not be an issue.

For calculation intensive code it is advised to implement that in native TS,\
and then call it form ST. This project shows how to do that.

## Primes benchmark

Calculates the first n primes, using a fairly simple agorithm.

## Fibonacci benchmark

Calculates the first n fibonacci numbers.

