# Architecture

## Wireframe

[!["Wireframe of Arcadia"](wireframe/arcadia_wireframe.png "Wireframe of Arcadia")](wireframe/arcadia_wireframe.png)

Please click the wireframe diagram to get a high resolution of the diagram.

## UML sequence diagram

```plantuml

skinparam sequenceMessageAlign center

actor User
boundary Frontend
participant Backend

== Dashboard ==
User -> Frontend : GET /
Frontend -> Backend : GET /api/games
return <back:plum>games</back>

loop games.length
  Frontend -> Backend : GET /api/games/<game_name>
  return <back:plum>game_card</back>
end
rnote over Frontend: render dashboard

== Start Game ==
rnote over User: clicks on game_card
Frontend -> Backend: POST /api/games/<game_name>
return <back:plum>game_id</back>

rnote over Frontend: render invite screen

note left of User
  - sends <player_url>/b to
  second participant
  - clicks "Start Game"
end note

== Play Game ==

Frontend -> Backend: GET /api/games/<game_name>/<game_id>/{a|b}
return <back:plum>game_data</back>
alt#Gold #LightBlue your_turn
  Frontend --> User: enable POST
else #Pink !your_turn
  Frontend --> User: render watch-only
end

```
### Objects

#### games

```json
{
  "games": [
    "tictactoe",
    "fourinarow",
    "chess",
    ]
}
```

#### game_card 

```json
{
  "name": "Tic Tac Toe",
  "description": "Super colles Tic Taco Toe",
  "thumbnail": "url",
}
```

#### game_id 

```int
unique int id
```

#### game_url 
```
/api/games/<game_name>/<game_id>
```

#### game_data

```json
{
  "game_data": {
    "game_state": [
      ["", "x", ""],
      ["o", "x", ""],
      ["x", "o", "o"]
      ],
    "your_turn": bool,
    "game_history": [
      {"row": 2, "col": 2, "value": "x"},
      {"row": 1, "col": 1, "value": "o"},
      ],
    "started_at": dataTime,
    "expires": dateTime,
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
