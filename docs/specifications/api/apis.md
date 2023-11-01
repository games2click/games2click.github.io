# REST API resources and DTOs

## URL `/api/games` (GET)

Get a list of playable games (property `active` of game instance is true).

Each game has an numerical id identifying the game and a name.

### DTO `games` (response)

```json
{
  "games": [
    {
      "id": 1,
      "name": "TicTacToe"
    },
    {
      "id": 2,
      "name": "FourInARow"
    },
    {
      "id": 3,
      "name": "Chess"
    }
  ]
}
```

## URL `/api/games/<game_id>` (GET)

Get a description of a single startable game in JSON representation.

The fields of the description is meant to be displayed to the user as game cards. A game card contains a representative title, a brief description a and an URL to a thumbnail or logo of the game.

### DTO `game_card` (response)

```json
{
  "title": "Tic Tac Toe",
  "description": "Super colles Tic Taco Toe",
  "thumbnail": "url"
}
```

## URL `/api/plays/start_game` (POST)

Instantiates and starts a new game.

When a game is started a unique play id is generated. For each player a unique identifier is generated which is used to join a play or make a move on a play. These player identifiers are returned to frontend.

The backend can decide if the player url contains clear text information of the player slug (```<game_name>/<game_id>/<player_id>```) or hash representation of 
the player slug.

The frontend generates a complete URL containing the player identifier. The player starting the game is responsible to distribute the generated URLs to other players.

The POST request contains a JSON payload with the numerical id of the game which should be started.

### DTO `start_game` (request)

```json
{
  "game_id": N
}
```

### DTO `game_data` (response)

```json
{
  "game_data": [
    {
      "player_slug":  "slug of player a",
      "symbol": "x"
    },{
      "player_slug":  "slug of player b",
      "symbol": "o"
    }
  ]
}
```

## URL `/api/play/<player_slug>` (GET)

Return the current state of the game data. Each game plugin is responsible to return the current state of its own game 
in a manner that frontend plugin can render all its information. "turns" represent all moves in sequential order, so 
the client can easily determine which player did the last move (the last entry in the turns array). The exact type of 
of the entries in turns depends on the game. The game plugin can decide wich data is needed to play or view the next 
move. The entries of turns array must contain player information so the frontend can decide if the current player can 
do the current move or the player can only watch the current state of the game.

For easier understanding of the dtos example data of the game tic tac toe is used.

### DTO `game_state` (response)

```json
{
  "game_state": {
    "my_symbol": "o",
    "turns": [
      {"row": 2, "col": 2, "symbol": "x"},
      {"row": 1, "col": 1, "symbol": "o"}
    ],
    "symbol_won": "x"
  }
}
```
Field `symbol_won` is optional, if the game isn't yet finished, the field is not set or is empty.


## URL `/api/play/<player_slug>` (put)
Player does its move. The data of the move is sent to the backend. The backend validates the move and the game state is 
updated. The frontend implementation is responsible to get the game state after this operation to determine the game 
state after that move, for example if the current player won or the game is finished.  
The frontend game plugin is responsible to send the data in a format the backend game plugin can understand.

For easier understanding of the dtos example data of the game tic tac toe is used.

### DTO `game_move` (request)

```json
{"row": 2, "col": 2}
```

**Happy playing!**
