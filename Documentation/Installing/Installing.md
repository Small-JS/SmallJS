# Installing SmallJS

## Installing Prerequisites

To install all the prerequisite delopment tools, look at:
>[./Documentation/Prerequisites.md](./Documentation/Prerequisites.md)

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
  > [./Documentation/Building.md](./Documentation/Building.md)

Check if everything builds tests successfully before going to the next step.

