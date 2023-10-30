 .. _ architecture:


.. toctree::
   :maxdepth: 4

Components
==========

.. uml:: components/components.puml


Gateway
-------

- nginx container

mainly reverse proxy for fronted and backend

Frontend
--------

- serves react pwa
- per game directory with game logic and assets

Backend
-------

- node.js container
- serves backend app through defined APIs
- imports games dynamically from games-plugin directory


Game Module
===========

Backend game-module
-------------------

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

Example
^^^^^^^

└── games-plugin
    └── TicTacToe
        └── TicTacToe.js

.. code-block:: javascript

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

