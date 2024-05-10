# Run development using containers

## Database

### Postgresql container

In the root directory of the cloned repository start the database instance:

  ```
  docker run --rm --name games2click_postgres -p 5432:5432 -v `pwd`/pgdata:/var/lib/postgresql/data -e POSTGRES_USER=games2click -e POSTGRES_DB=games2click -e POSTGRES_PASSWORD=games2click -d postgres:15.4
  ```

**Note for Windows user:** In powershell use ```${PWD}``` instead of ``` `pwd` ```e.g.:
  ``` 
docker run --rm --name games2click_postgres -p 5432:5432 -v ${PWD}/pgdata:/var/lib/postgresql/data -e POSTGRES_USER=games2click -e POSTGRES_DB=games2click -e POSTGRES_PASSWORD=games2click -d postgres:15.4
  ```


The env file for database connection for the backend must be named .env and be placed in root of backend, `backend/.env`.

For the above example it could look like the following:

  ```
  $ cat backend/.env
  export POSTGRES_USER=games2click
  export POSTGRES_PASSWORD=games2click
  export POSTGRES_DB=games2click
  export POSTGRES_PORT=5432
  export POSTGRES_HOST=127.0.0.1
  ```

## Backend

Please make sure that the database container is running before proceeding and the database environment file is present.

To run the backend use the basic node container image `node:lts-alpine3.18`:

  ```
  $ cd backend
  $ docker run --rm -it --entrypoint sh -v `pwd`:/work -w /work -p 3099:3099 node:lts-alpine3.18
  npm install
  npm run start:dev
  ```

Every time the container is started with `docker run` the `npm install` command must be run.

With `start:dev` NodeJS will look for changes in the filesystem and recompile/reload the application
when changes are made.

The backend is now available under <http://127.0.0.1:3099>.



Please note that you don't need to preface the API urls with `/api/`. This is only necessary when running
with nginx, so nginx knows to which reverse proxy backend it needs to forward the request.

## Activate games

On the first run of the database and the backend the database structure is created.

For games to be active they need to be created in the database. This can be done through API calls:

  ```
  curl -XPOST http://127.0.0.1:3099/games/ -H 'Content-Type: application/json' -d '{"name": "TicTacToe", "active": true, "number_of_players": 2}'
  ```

This is only necessary todo once!
