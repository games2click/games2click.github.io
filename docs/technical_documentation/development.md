# Development

## Development environment

[Node.js](http://node.js) must be installed, at least version 18. 

- Clone this repository

  `git clone git@git-iit.fh-joanneum.at:swd22-hackathon/arcadia.git`

- open a terminal and change to the _service_ directory install all node modules and start the backend server.

  ```
  cd service
  npm install
  npm start
  ```

  The backend server should listen on localhost on port 8080.

- _Optional:_ to run tests execute `npm test`

- open a new terminal change to _client_ directory install all node module and start the frontend service.

  ```
  cd client
  npm install
  npm start
  ```

  The frontend server should listen on localhost on port 3000.
  The browser will open the page at http://localhost:3000 and **Hello World** should be displayed.

- _Optional:_ to run tests execute `npm test`

## Build docker images

There are two ways to build Arcadias docker images, ```docker-compose``` and ```docker build```.

### docker-compose

To build all containers simply run

```
docker compose -f docker-compose.yaml -f docker-compose-build.yaml build
```

### docker build

To build the images seperately invoke the following command in the repository root directory.

This is an example to build the backend image:

```
docker build -f dockerfiles/backend/Dockerfile -t arcadia-backend:0.0.1alpha .
```

Replace all occurences of _backend_ with the names of the other containers.
