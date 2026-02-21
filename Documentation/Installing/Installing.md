# Installing SmallJS

## Copying the SmallJS repo

First download a copy of the current repo: [SmallJS-main.zip](https://github.com/Small-JS/SmallJS/archive/refs/heads/main.zip)\
and unzip it to a working folder on your system.

You can also use your favorite Git tool to fork the repo.\
Then you have version control and can even contributute to SmallJS development.\
If you don't know Git yet, [GitHub Desktop](https://desktop.github.com/download/)
is user friendly way to use its functionality.

## Installing Prerequisites

To install all the prerequisite delopment tools, look at: [Prerequisites.md](Prerequisites.md)

## Install npm modules

Now run the bash script `./install.sh`.
On Windows, the `.sh` extension should be associated with Git Bash once.
Do this by clicking on the file in the explorer and then choose open with Git Bash always.

This script:
- Checks if the prerequisites are present.
- Installs the SmallJS language extension in VSCode.
- Installs npm modules for all Node.js projects.

### Build SmallJS compiler and core projects

Run the bash script: `./build.sh`, that:
- Builds the Smalltalk to JS `./Compiler`.
- Builds the core ST projects and runs their unit tests.

Notes:
- Browser GUI testing is disabled by default. To enable it, check out:
  > [Building.md](Building.md)

Check if everything builds tests successfully before going to the next step.
