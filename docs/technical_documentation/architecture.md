# Architecture

## Wireframe

[!["Wireframe of Arcadia"](wireframe/arcadia_wireframe.png "Wireframe of Arcadia")](wireframe/arcadia_wireframe.png)

Please click the wireframe diagram to get a high resolution of the diagram.

## UML sequence diagram

@plantuml

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
### Objects

#### games

```json
{
  "games": [
    "tictactoe",
    "fourinarow",
    "chess"
    ]
}
```

#### game_card 

```json
{
  "name": "Tic Tac Toe",
  "description": "Super colles Tic Taco Toe",
  "thumbnail": "url"
}
```

#### game_data 

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

#### player_url 
```
<game_name>/<game_id>/<player> -> hash
```

#### game_state

```json
{
  "game_state": {
    "turns": [
      {"row": 2, "col": 2, "value": "a"},
      {"row": 1, "col": 1, "value": "b"}
      ],
    "started_at": "Date",
    "expires": "Date"
  }
}
```



api/games -> {
  games: [
    tictactoe,
    fourinarow,
    chess,
    ]
  }
api/games/tictactoe -> {
  name: "Tic Tac Toe",
  description: "Super colles Tic Taco Toe",
  thumbnail: "url",
  }



## Frontend

- nginx container
- serves react pwa
- per game directory with game logic and assets

## Backend

- backend container
- serves backend app through defined APIs
- imports games dynamically from games-plugin directory

### Backend game-module

- per game directory in games-plugin
  - game logic as module
  - on every update-state a new instance of game module is initialized
    - calls import_state with the current game state
  - calls update_state() method with player-move json blob parameter
    - move is validated
      - move is illegal throw illegal-move exception
    - update game-state
  - returns new-state as json blob or throw illegal-move exception
  - new-state is stored in db
  - new-state is returned to the calling party through API response

#### Example

```
└── games-plugin
    └── TicTacToe
        └── TicTacToe.js
            ~~~
            class TicTacToe {
                constructor() {
                    // Initialize the object upon import
                    this.someProperty = 'Some initial property';
                }

                import_state(game_state) {
                    this.game_state = game_state;
                }

                update_state(player_move) {
                    // validate move
                    if (player_move != "valid") {
                        throw IllegalMoveException;
                    }

                    // Add your game move logic here
                    return (new_state);
                }
            }

            export default new TicTacToe();
```
