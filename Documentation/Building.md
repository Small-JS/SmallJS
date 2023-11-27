# Building & running tests

Run main the bash script: `./build.sh`, that:
- Builds the Smalltalk to JS `./Compiler`.
- Builds all other ST projects and runs their unit, API and browser (GUI) tests\
  by calling the `build.sh` script in the project folders.

## Browser testing

To enable GUI testing of web browser based projects,\
you first need to copy the file `.env.example` to `.env`\
and then uncomment the browsers you want to test with on your OS.\

### NOTE 1: Enable browser popups for localhost

The browser tests in the `Browser` project need pop-ups to be enabled to succeed.
Enable pop-ups for host localhost:3000 and re-run the tests.

### NOTE 2: Browser testing on MacOS

MacOS will not quit a newly started browser process\
after tests have completed successfully, causing `build.sh` scripts to hang.\
A workaround is to open the browser(s) you want to test with,\
before running `build.sh`.\
Then the script will test in newly opened tabs and close them after success.
