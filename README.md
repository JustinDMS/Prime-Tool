# Prime Tool

Prime Tool is a multi-use tool for Metroid Prime. It has many functions:

Segment Timer:

- Can add or subtract segment times
- Provides results in seconds and HH:MM:SS.sss format
- Can copy the result easily by clicking the respective box

Average Time:

- Input a number of times (seconds format only) and finds the average between them all
- Does not account for the way Prime counts in-game time (1 frame = 0.01(6))
- Can copy result easily by clicking on it

Route Finder:

- Real-time pathfinding between two rooms done using an implementation of Dijkstra's algorithm where each room is weighted equally
- Does not have logic, so you may run in to cases where the shortest path is not possible (ie Phazon Processing Center -> Elite Quarters going through Processing Center Access)
- Some rooms have an additional world identifier (ie Tallon, Mines, etc). This is because some worlds have rooms with the same names and it was throwing off the pathfinding.
- Used for fast iteration of mock-up routes.
- Easily copy rooms and paste into a spreadsheet
