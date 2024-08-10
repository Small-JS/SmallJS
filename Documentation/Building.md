# Building & running tests

Run main the bash script: `./build.sh`, that:
- Builds the Smalltalk to JS `./Compiler`.
- Builds all other ST projects and runs their unit, API and browser (GUI) tests\
  by calling the `build.sh` script in the project folders.

## Browser testing

To enable GUI testing of web browser based projects,\
you first need to copy the file `.env.example` to `.env`\
and then uncomment the browsers you want to test with on your OS.\

### NOTE 1: Browser testing on MacOS

MacOS will not quit a newly started browser process\
after tests have completed successfully, causing `build.sh` scripts to hang.\
A workaround is to open the browser(s) you want to test with,\
before running `build.sh`.\
Then the script will test in newly opened tabs and close them after success.

### NOTE 2: Debugging with Firefox

To be able to debug in VSCode with Firefox,
you have to install the VSCode extension "Debugger for Firefox".
When starting Firefox from VSCode it may not stop on breakpoints the first time.
This is a known issue that is noted in the Troubleshooting section
on the GitHub page of the debugger extension.
Reload the the page in Firefox to hit the breakpoint in a second try.

Also the Firefox debugger sometimes erroneously jumps to JS source instead of staying in the ST source.

On Ubuntu launching Firefox debugger from VSCode ye give the error:
"Your Firefox profile cannot be loaded".
This is because VSCode does not work with the snap sandbox.
It's recommended to change your Firefox installation from snap to deb with this procedure:
https://www.omgubuntu.co.uk/2022/04/how-to-install-firefox-deb-apt-ubuntu-22-04

Alternatively, you can use this VSCode workaround in `launch.json`.
(But you'll have to redo that every time you get the source from GitHub)
https://askubuntu.com/questions/1409069/unable-to-launch-firefox-debugger-from-vscode-your-firefox-profile-cannot-be-lo

It's recommended to first test/debug your app in Chrome or Edge
and then test on Firefox for any incompatibilities.
