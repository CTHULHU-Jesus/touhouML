# touhouML

## Legal Notes
- This repository does not come with a copy of the game **TOUHOU 6: Embodyment of Scarlet Devil**. So you must find your own 😉. 

## Installation Instructions
### Docker
To install docker and some other dependencies run.
```sh
$sudo apt-get install docker nvidia-container-runtime
$sudo usermod -a -G docker $USER
```
### Game Dependencies
- First find a legal copy of **TOUHOU 6: Embodyment of Scarlet Devil**
  * An un-patched iso file
- Then rename the iso to th06.iso
- Move that file to `./src/`
@TODO add setup instructions

## Operating Instructions
You must have an nvidia gpu to run this (sorry docker is hard).

### Running the simulation
@TODO

### Showing the Replay
@TODO

## The Outline

This is a project to try to get Machine leaning to play one of the touhou games (a bullet hell). This should be relatively simple because you don't need any off screen information.

## The Architecture
- Docker Ubuntu Container
  - Touhou Game 
    - (Optionally) Runs as a headless process (no window)
    - Window is stored in a buffer
  - Rust Program
    - loads Model from mounted folder (If available)
    - Accesses Touhou window
    - Gives window key presses
    - Tells the game to save all of the runs (Touhou has this functionality built in)
    - On Shutdown Saves model to mounted folder
  - Save Script
    - Upon a replay being saved move it from the image to a mounted folder
