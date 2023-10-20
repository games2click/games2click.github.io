# User stories

## Frontend walkthroughs

### New game

- User connects to website
- [If multiple games, user is presented with list of game to choose]
- User optionally enters player name/logs in
- User starts game
  - User sees game screen, invite link for other players is easily copyable
    - if no player name is set, a random name will be generated
    - player name, game url stored in local storage/cookie

### Join game through game url

- User connects to website through game url
- User optionally enters player name/logs in
- User enters game
  - User sees game screen, invite link for other players is easily copyable
    - if no player name is set, a random name will be generated
    - player name, game url stored in local storage/cookie

### Join game through website

- User connects to website
- User optionally enters player name/logs in
- User can choose to start new game or join game with game-id
  - User enters game-id
    - User sees game screen, invite link for other players is easily copyable
    - if no player name is set, a random name will be generated
    - player name, game url stored in local storage/cookie

### Player movement

- User sees game screen
  - User makes move
    - move is valiated in the frontend to alert player of illegal move/display helpers
    - move is send to to backend for finale validation and storage/redistribution
  - User waits for other players moves
    - frontend polls api for game state changes
- If game state signals win/loss user is presented with game outcome
  - ? cookie reflects win/loss for game
  - ? game is removed from players cookies

### Return to previous game through website

- User connects to website
- User is shown all games stored in cookie and can choose which game to return to
- User can optionally start a new game

### Return to previous game through game url

- User connects to website through game url
- User sees game screen, invite link for other players is easily copyable