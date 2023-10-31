# REST API resources and DTOs

## URL `/api/games` (get)

Determine all possible game names. Each game has a short unique string identifier. 

### DTO `games` (response) 

```json
{
  "games": [
    "tictactoe",
    "fourinarow",
    "chess"
    ]
}
```

## URL `/api/games/<game_name>` (get)

Construct a json representation of a single startable game. A game card contains a representative title, a brief 
description a url to a thumbnail or logo of the game

### DTO `game_card` (response)
```json
{
  "title": "Tic Tac Toe",
  "description": "Super colles Tic Taco Toe",
  "thumbnail": "url"
}
```

## URL `/api/games/<game_name>` (post)

Instantiate and starts a new game. When a game is started a unique game id is generated, also a unique player url is 
for each possible player generated. These player urls are returned to frontend. The backend can decide if the player 
url contains clear text information of the player slug (```<game_name>/<game_id>/<player_id>```) or hash representation of 
the player slug.

The frontend is responsible to send the player url to all participants.

The post contains not http body or payload.

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

## URL `/api/play/<player_slug>` (get)

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
