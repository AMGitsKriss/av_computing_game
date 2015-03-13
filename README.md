# AV Computing Game

Built using Processing

- backdrop_steel is loading 4 sprites when it only needs 1. Why?
- horizontal_blastdoor seems to only loading 1 as intended. backdrop issue shouldn't interfere if properly structured. (IF TYPE == 11 && INDEX > OR < #)?

- loadFiles() is loading as many images as there are png files in that directory. backdrop_steel has 4 png files in it's directory, but is told to only load backdrop_steel. Thus, all 4 of the file are backdrop steel. 