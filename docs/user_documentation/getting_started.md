# Get Started

Games2Click consists of a separate frontend and backend. Both are best served by nginx acting as a reverse proxy.

For easier use dockerfiles for all components and a docker-compose file is supplied.

## Start with prebuilt docker images

To bring up the whole Games2Click stack you can use the prebuild docker containers.
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

## Run and build local docker images

To run and build all the docker images run:

  ```
  docker compose -f docker-compose.yaml -f docker-compose-build.yaml up --build
  ```

This build and run all containers, including sphinx and the matomo stack. 
Games2Click should be reachable under https://localhost
The SSL-certificate for local development are self-signed, so you should accept the warning.

## Debug client aka fronted

If you want to debug or develop Games2Click frontend the best way to do so is 
to start only database and backend with docker compose and run the frontend 
server in your IDE.

  ```
  docker compose -f docker-compose.yaml -f docker-compose-build.yaml up --build database backend
  ```

Then start the frontend in a new terminal

  ```
  cd client
  npm install
  npm start
  ```
The browser will open the page at http://localhost:3000 and Games2Click should be displayed.

## Debug backend
If you want to debug or develop Games2Click backend the best way to do so is
to start only database  with docker compose and run the backend
server in your IDE.
First you need a .env file in the backend directory. copy or rename the 
existing '.env.example' to '.env'.

  ```
  cp backend/.env.example backend/.env
  ```

Start only the database.

  ```
  docker compose -f docker-compose.yaml -f docker-compose-build.yaml up --build database
  ```
Start the backend server

  ```
  cd backend
  npm install
  npm start
  ```
