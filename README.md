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

- Real-time pathfinding between two rooms done using an implementation of Dijkstra's algorithm where each room is weighted equally (ie number of rooms)
- Does not have logic, so you may run in to cases where the shortest path is not possible (e.g. Phazon Processing Center -> Elite Quarters going through Processing Center Access)
- Some rooms have an additional world identifier (ie Tallon, Mines, etc). This is because some worlds have rooms with the same names and it was throwing off the pathfinding.
- Used for fast iteration of mock-up routes.
- Easily copy rooms and paste into a spreadsheet
- Includes a Map Viewer which shows the route on a model of the game's worlds.

Auto Timer:
- REQUIRES PYTHON 3.7-3.11 TO BE INSTALLED AND PRACTICE MOD V2.6.1
- Automatically takes the previous room time from the game's memory at runtime
- Input a max number of times to be displayed
- Shows a delta comparison to the inputted goal time

Auto Timer Usage:
- Open Dolphin and Prime Practice Mod v2.6.1
- Press "Hook Dolphin"
- Press "Start Scanning"
- Input the previous room time of your savestate into the Start Time box (This prevents that time from being added as a new room time every time your reload the savestate)
- Optionally input a goal time

Short how-to video: https://youtu.be/TZm8kNvdIIc

Credits:
- Pwootage, for Practice Mod and finding the addresses needed
- DarkZero, for the Dolphin Memory Engine python module

Links:
- Python - https://www.python.org/downloads/
- DME Module - https://github.com/henriquegemignani/py-dolphin-memory-engine
- Prime Practice Mod - https://github.com/MetroidPrimeModding/prime-practice-native
