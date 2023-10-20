# APIs

## new-game API

- Frontend calls new-game endpoint
  - Parameters: game-name, player-name
  - Returns: game-id (wordlist, uuid?)

### Functionality

- creates game-id
- stores game-id, game, player-name in db

## join-game API

- Frontned calls join-game endpoint
  - Parameters: game-id, player-name
  - Returns: ok/nok/not-found

### Functionality

- checks if game-id exists
- adds player-name to game-id in db

## update-state API

- Frontend calls update-state endpoint
  - Parameters: game-id, player-name, player-move
  - Returns: ok/nok/not-found/illegal-move

### Functionality

- see backend game module

## poll-state API

- Frontend calls poll-state endpoint
  - Parameters: game-id, player-name
  - Returns: game-state/not-found

### Functionality

- checks if game-id exists
- returns game-state stored in db
