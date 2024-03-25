# Getting started

Games2Click uses Node.js for backend and for the frontend.

## Requirements

There are multiple ways to develop Games2Click. You can use a plain Node.js 
installation or you can use docker to run Node.js.

* [Node.js](http://node.js) at least version 18.
* _Optional_: [Docker](http://docker.com).

## Get the source

- Clone this repository and change to root directory of the repository

  ```shell
  git clone git@github.com:games2click/platform.git
  cd platform
  ```

## Plain Node.js environment

Games2Click backend needs a database to store the game state. For local development 
the backend uses sqlite as in memory database. So there is no need to start an 
extra database, but you can if you want to do so.

### Backend
To start the backend service change to the backend directory, install all 
node modules and start the backend service.
  ```shell
  cd backend
  npm install
  npm start
  ```
This starts the sqlite in-memory database and the backend service.

If you want to execute the tests run:
  ```shell
  npm test
  ```

If you want to the functional tests run: 
  ```shell
  npm test:e2e
  ```
The functional test are also executed with the sqlite database.

#### Optional: use a postgres database

You can also use a postgres database as storage for the backend. You have to
 export the database configuration as environment variables before you can start 
the backend.

```shell  
  DB_TYPE=postgres \
  POSTGRES_USER=arcadiabe \
  POSTGRES_PASSWORD=arcadiabe \
  POSTGRES_DB=arcadiabe \
  POSTGRES_PORT=5432 \
  POSTGRES_HOST=database \
  npm start 
  ```

### Frontend

If the backend is running you can start the frontend.

  ```shell
  cd client
  npm install
  npm start
  ```

If you want to execute the tests run:
  ```shell
  npm test
  ```


## docker environment

To start the complete stack you can use docker compose.

  ```shell
  docker compose -f docker-compose.yaml -f docker-compose-build.yaml up --build 
  ```

Games2Click is now available at http://localhost/ you can read the docs at http://localhost/docs/

### Frontend

It's possible to start a new react server for the frontend development, whilst the docker compose stack is running.

  ```
  cd client
  npm install
  npm start
  ```
Cause port 3000 is already blocked, React asks if you want to switch to another port. Say yes and point your browser to
http://localhost:3001/ .

### Database and Backend

It's possible to run only the database or the database with the frontend 
  ```shell
  docker compose -f docker-compose.yaml -f docker-compose-build.yaml up --build database backend 
  ```

## Build docker images

### docker build

To build the images seperately invoke the following command in the repository root directory.

This is an example to build the backend image:

```
docker build -f dockerfiles/backend/Dockerfile -t arcadia-backend:0.0.1alpha .
```

Replace all occurences of _backend_ with the names of the other containers.
