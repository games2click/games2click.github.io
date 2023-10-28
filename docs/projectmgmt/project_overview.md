# Project overview

## Description

Arcadia is a web platform for simple multiplayer games. Players can either compete in an asynchronous fashion via shared links or directly via web sockets. For starters, we will implement the well-known game "Tic-Tac-Toe". 

## Team members

Stefan Sedelmaier, Walter Reiner, Martin Novak, Michael Czak

## Installation

- Get a working docker environment [get docker](http://docs.docker.com)
- Download Docker compose file [link](http://TODO:docker_compose_file)

## Must-have features

- Modular architecture that allows adding games
- Starting "Tic-Tac-Toe" without the necessity to create an account. Players should be able to anonymously start a game.
- Asynchronous gameplay via shared generated URLs
- Game state only held in server memory

## Nice-to-have features

- Synchronous gameplay via web sockets
- State persisted in file or database
- User account for rankings, statistics, friends, etc.
- Chat
- Record game moves and save to "history" file -> feature to review games
- 4-in-a-row, Chess, ...
- Backend admin interface (user and game management, statistics)

## Technical specifications

### Backend

- Python or JS

### Frontend

- React.js
- Material UI ([see mui.com](https://www.mui.com))

### Environment/Deployment

- Docker containers for
    - Backend (api calls)
    - Frontend (static resources)
        - NGINX Webserver
        - React.js Application
    - Database 

>[!Optional]
>- CI/CD pipeline over gitlab 
>- automated unit testing

## Philosophy

- enforce test driven development
