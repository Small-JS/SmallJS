# Building & running tests

Run the bash script: `./build.sh`, that:
- Builds the Smalltalk to JS `./Compiler`.
- Builds other core ST projects and runs their unit, API and browser (GUI) tests\
  by calling the `build.sh` script in the project folders.

Run the bash script: `./buildAll.sh`, to also build all examples.

## Browser testing

To enable GUI testing of web browser based projects,\
you first need to copy the file `.env.example` to `.env` in the project folder,\
e.g. `./Browser/.env.example` to `./Browser/.env`,\
and then uncomment the browsers you want to test with on your OS.\
Each browser based project and example has its own `.env.example` file.

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
Reload the page in Firefox to hit the breakpoint in a second try.

Also the Firefox debugger sometimes erroneously jumps to JS source instead of staying in the ST source.

On Ubuntu, launching the Firefox debugger from VSCode may give the error:
"Your Firefox profile cannot be loaded".
This is because the debugger extension does not work with the snap sandbox:
it does not have access to the `/tmp` folder.
It's recommended to change your Firefox installation from snap to deb with this procedure:
https://www.omgubuntu.co.uk/2022/04/how-to-install-firefox-deb-apt-ubuntu-22-04

Alternatively, you can add these lines to the Firefox configurations in `launch.json`
(but you'll have to redo that every time you get the source from GitHub):

        "timeout": 90000,
        "tmpDir": "/some/folder/of/yours/with/write/perms",

More information:
https://askubuntu.com/questions/1409069/unable-to-launch-firefox-debugger-from-vscode-your-firefox-profile-cannot-be-lo

It's recommended to first test/debug your app in Chrome or Edge
and then test on Firefox for any incompatibilities.
