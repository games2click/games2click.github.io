# Get Started

Arcadia consists of a seperate frontend and backend. Both are best served by nginx acting as a reverse proxy.

For easier use dockerfiles for all components and a docker-compose file is supplied.

## Get started using docker

To run the Arcadia using docker follow these steps:

- Build images locally

  ```
  docker-compose build
  ```

- Run application

  ```
  docker-compose up
  ```

  - The frontend application should now be reachable through [http://localhost](http://localhost) and **Hello World** should be displayed..
