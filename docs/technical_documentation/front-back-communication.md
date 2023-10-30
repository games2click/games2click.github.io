# Frontend to Backend Communication

The sequence diagram describes mainly the communication between any frontend and the backend service. Arcadia is 
using http://react.dev ,for this reason the interaction between the actor "User" and the frontend is from a "react" 
centered point of view.

```plantuml
!pragma teoz true
skinparam sequenceMessageAlign center

actor User
boundary "React\nFrontend"
participant Backend

== Dashboard ==
User -> "React\nFrontend" : GET /
"React\nFrontend" -> Backend++ : GET /api/games
Backend -> Backend: get games
Backend -> "React\nFrontend"--: <back:plum>games</back>

loop games.length
  "React\nFrontend" -> Backend++ : GET /api/games/<game_name>
  Backend -> Backend: construct\ngame card
  Backend -> "React\nFrontend"--: <back:plum>game_card</back>
end
rnote over "React\nFrontend": render dashboard

== Start Game ==
rnote over User: clicks on game_card
User -> "React\nFrontend" : GET /new/<game_name>
"React\nFrontend" -> Backend++: POST /api/games/<game_name>
Backend -> Backend: instantiate\nnew game\n\n+ game url/hash
Backend -> "React\nFrontend"--:  <back:plum>game_data</back>

rnote over "React\nFrontend": render invite screen

rnote over User
  - sends second <player_url> to
  second participant
  - clicks "Start Game"
end note

== Play Game ==

User -> "React\nFrontend" : GET /play/<player_url>
loop while game not finished
"React\nFrontend" -> Backend++: GET /api/games/<player_url>
  Backend -> Backend: get game\nstate
  Backend --> "React\nFrontend"--:  <back:plum>game_state</back>
  alt#Gold #LightBlue your_turn
    rnote over "React\nFrontend": enable interaction
    User -> "React\nFrontend": Interaction
    "React\nFrontend" --> Backend++: PUT /api/games/<player_url>
    Backend -> Backend: valid move?
    Backend --> "React\nFrontend"--: HTTP reponse move ok?
  else #Pink !your_turn
    rnote over "React\nFrontend": render watch-only
  end
end
```
## REST API resources and DTOs

### URL `/api/games` (get)

Determine all possible game names. Each game has a short unique string identifier. 

#### DTO `games` (response) 

```json
{
  "games": [
    "tictactoe",
    "fourinarow",
    "chess"
    ]
}
```

### URL `/api/games/<game_name>` (get)

Construct a json representation of a single startable game. A game card contains a representative name, a brief 
description a url to a thumbnail or logo of the game

#### DTO `game_card` (response)
```json
{
  "name": "Tic Tac Toe",
  "description": "Super colles Tic Taco Toe",
  "thumbnail": "url"
}
```

### URL `/api/games/<game_name>` (post)

Instantiate and starts a new game. When a game is started a unique game id is generated, also a unique player url is 
for each possible player generated. These player urls are returned to frontend. The backend can decide if the player 
url contains clear text information of the player slug (```<game_name>/<game_id>/<player_id>```) or hash representation of 
the player slug.

The frontend is responsible to send the player url to all participants.

The post contains not http body or payload.

#### DTO `game_data` (response)

```json
{
  "game_data": [
    {
      "player_url":  "url player a",
      "symbol": "x"
    },{
      "player_url":  "url player b",
      "symbol": "o"
    }
  ]
}
```

### URL `/api/games/<player_url>` (get)

Return the current state of the game data. Each game plugin is responsible to return the current state of its own game 
in a manner that frontend plugin can render all its information. "turns" represent all moves in sequential order, so 
the client can easily determine which player did the last move (the last entry in the turns array). The exact type of 
of the entries in turns depends on the game. The game plugin can decide wich data is needed to play or view the next 
move. The entries of turns array must contain player information so the frontend can decide if the current player can 
do the current move or the player can only watch the current state of the game.

For easier understanding of the dtos example data of the game tic tac toe is used.

#### DTO `game_state` (response)

```json
{
  "game_state": {
    "turns": [
      {"row": 2, "col": 2, "value": "a"},
      {"row": 1, "col": 1, "value": "b"}
    ],
    "player_won": "b"
  }
}
```
Field `won` is optional, if the game isn't yet finished, the field is not set or is empty.


### URL `/api/games/<player_url>` (put)
Player does its move. The data of the move is sent to the backend. The backend validates the move and the game state is 
updated. The frontend implementation is responsible to get the game state after this operation to determine the game 
state after that move, for example if the current player won or the game is finished.  
The frontend game plugin is responsible to send the data in a format the backend game plugin can understand.

For easier understanding of the dtos example data of the game tic tac toe is used.

#### DTO `game_move` (request)

```json
{"row": 2, "col": 2}
```

**Happy playing!**
