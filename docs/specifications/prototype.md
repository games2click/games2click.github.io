# Prototype

## Wireframe

[!["Wireframe of Arcadia"](wireframe/arcadia_wireframe.png "Wireframe of Arcadia")](wireframe/arcadia_wireframe.png)

## Frontend walkthroughs

* User visits homepage/dashboard. Dashboard lists all playable games with a brief description.
* User instantiates a new game by clicking on game card and is redirected to the game invite screen.
* User gets a list of two player URLs.
  * User can share one link with another player to join (typically through mail or messenger).
  * The second link is the URL for the user initiating the game themselve.
* On click on their own player URL, the user is redirected to the play screen.
* The game state and is rendered on the screen, the game state  including the complete game state is rendered on the screen.
* User makes their move. The move is validated and the game state gets updated.
* If its not the turn of the user, the play screen is rendered read-only and user must wait for the other player to finish their move.
* If a user has won the game, a notification of win or loose is rendered, the game is over.

All operations are unauthenticated, meaning neither a login nor a username is required.
