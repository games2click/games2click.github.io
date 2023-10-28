# Get Started

Arcadia consists of a seperate frontend and backend. Both are best served by nginx acting as a reverse proxy.

For easier use dockerfiles for all components and a docker-compose file is supplied.

## Get started using docker

The easiest way to get started is using Docker.

Please make sure you have a working Docker environment installed before proceeding.

To run the application using docker a docker-compose file is supplied in the repository. Either clone the whole repository or download the docker-compose.yaml to your disk.

The images are prebuilt, to start arcadia containers just run:

  ```
  docker-compose up
  ```

The frontend application should now be reachable through [http://localhost](http://localhost) and **Hello World** should be displayed..
