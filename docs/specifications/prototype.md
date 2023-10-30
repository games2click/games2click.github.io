# Prototype

## Wireframe

[!["Wireframe of Arcadia"](wireframe/arcadia_wireframe.png "Wireframe of Arcadia")](wireframe/arcadia_wireframe.png)


## Frontend walkthroughs

* user visits homepage/dashboard. dashboard lists all playable games with a brief description
* user instantiates a new game by click on game card, user is redirect to game invite screen
* user gets a list of all possible player url and must 
  * must invite his participant (link can be shared per mail or any other messanger)
  * the link who is left is the player url for the user itself
* on click on his own player url, user is directed to the pla screen
* the game including the complete game state is rendered on the screen
* user play his move, if the move is valid the game state is rendered again
* if its no the turn of the user screen is rendered read-only and user must wait for the opponent
* if a user has won the game won or loose is rendered, the game is over

All operations are unauthenticated, meaning no login nor a username is required