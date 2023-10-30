# Get Started

Arcadia consists of a seperate frontend and backend. Both are best served by nginx acting as a reverse proxy.

For easier use dockerfiles for all components and a docker-compose file is supplied.

## Start with prebuilt docker images

To bring up the whole arcadia stack you can use the prebuild docker containers.
Just run:

  ```
  docker-compose up
  ```

The frontend application should now be reachable through [http://localhost](http://localhost) and **Hello World** should be displayed.

## Build docker images locally

To build the docker images locally you need to run:

  ```
  docker compose -f docker-compose.yaml -f docker-compose-build.yaml build
  ```

## Run service components locally

If you want to debug or develop arcadia componentsyou can run backend and frontend directly on your machine.

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
