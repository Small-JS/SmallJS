# Tic-tac-toe by Claude

How to create a Tic-tac-toe browser game in SmallJS using Claude AI.\
Link to video link and outline text.

## Video

Video: [https://www.youtube.com/watch?v=4_ir6h2MIRg](https://www.youtube.com/watch?v=4_ir6h2MIRg)

## Intro

This video is about using the AI Claude\
to create a browser game Tic-tac-toe in the language SmallJS.\
To do this yourself, you need a payed Claude Pro subscription form Anthropic.\
It currently costs about $20 per month, depending on where you live.\
So its affordable and currently the best AI for coding.

## Install SmallJS

- Goto official website: `https://small-js.org`
- Goto SmallJS repo: `https://github.com/small-js/smalljs`
- Goto and open `Installing.md`

## Setup VSCode with Claude

- In the SmallJS repo, create folder `./Private`.
- Copy folder `./Examples/Counter` to `./Private`.
- Navigate to folder `./Private`.
- Rename folder `Counter` to `Tictactoe`.
- Rename workspace file `Counter.code-workspace` to `Tictactoe.code-workspace`.
- Open workspace file `Tictactoe.code-workspace` in VSCode.
- Run the bash script `getAiContext.sh`.
- Notice there is now a file `smalljs.txt`.
- Notice the contents of `CLAUDE.md` also referring to `smalljs.txt`.
- Make sure the VSCode extension `Cloude Code` in stalled and you have an account.
- Open extension `Cloude Code` in the right pane in VSCode.
- Start the static web server by running the bash script `startWebServer.sh`.

## Convert Counter app to Tic-tac-toe game

- Open the app model file `./src/Counter.st`
- Prompt Claude with: `Convert SmallJS class Counter to class Tictactoe`.
- After a minute or so, Claude has completed the request.
- But now it notices that the model does not match the app and tests anymore.
- Cloud asks you how to proceed. Select `Convert the whole app now`.
- Notice Claude is quickly learning the SmallJS language and library parts.
- After a few minutes the app should be complete with running tests.
- Check if everything works.

## Improving the app

- Check the chosen computer strategy, random to best move.
- Switch to another strategy with by prompting Claude with e.g.:\
  `Change the method computerMove: to make the best move in stead of a random move`
