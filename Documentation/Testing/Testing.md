# Testing in SmallJS

## Unit tests

### Naming test classes and methods

The convention is to create a `./Test` folder for *every* folder within `./Smalltalk`.
In this folder, there should be a test class for every class in the parent folder,
named `Test<classname>`, e.g.: `TestInteger`. A test class should extend the base class `Test`.
The module name should be `Test` followed by the module name of the class being tested, e.g.: `TestCore`.
Testing methods should be named `test<method>`, e.g.: `testAddition`.
Other methods can be added as utility methods, and will not be called automatically.

### Writing tests

In a test* method there are 2 main functions to call:

#### True assertions
For these standard tests, the argument block must evaluate to true for a succesful test, e.g.:
> `self assert: [ 1 + 2 = 3 ].`

Any other result will throw an error.

#### Error assertions
In these tests, the argument block intentionally triggers an error.
If an error occurs the test succeeds, e.g.:
> `self assertError: [ 'a' * 2 ].`

If no error occurs, an error with be thrown...

### Running tests

To run all tests (all test* methods) of a test class instance call the 'all' method, e.g.:
> `TestInteger new all`

To run *all* tests on *all* test classes call:
> `Test all`

This will automatcally find all classes named Test* and call their methods named test*.
To be able to 'see' the classes within a test module, that module needs te be loaded.
This can be forced by referencing any class within the test module, e.g. by this code line:
> `TestInteger.`
