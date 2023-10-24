# APIs

## User

### register-user API

- Register a new username
  - Parameters: user-name
  - Returns: ok/nok/already-taken

#### Functionality

- stores user-name in the db

### username-taken API

- Checks if a username is already taken
  - Parameters: user-name
  - Returns: already-taken/free/error

#### Functionality

- checks db if a username is already taken

## Game

### new-game API

- Frontend calls new-game endpoint
  - Parameters: game-name, player-name
  - Returns: game-id (wordlist, uuid?)

#### Functionality

- creates game-id
- stores game-id, game, player-name in db

### join-game API

- Frontned calls join-game endpoint
  - Parameters: game-id, player-name
  - Returns: ok/nok/not-found

#### Functionality

- checks if game-id exists
- adds player-name to game-id in db

### update-state API

- Frontend calls update-state endpoint
  - Parameters: game-id, player-name, player-move
  - Returns: ok/nok/not-found/illegal-move

#### Functionality

- see backend game module

### poll-state API

- Frontend calls poll-state endpoint
  - Parameters: game-id, player-name
  - Returns: game-state/not-found

#### Functionality

- checks if game-id exists
- returns game-state stored in db
