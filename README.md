# Lynn's Legacy
Lynn's Legacy is a game originally by indie game developers cha0s and Josiah Tobin. It was released as open source/public domain in 2006.
It is still available as a win32 binary, but I felt it would be really nice if the game were made available on modern systems so this project
exists to port the game to a modern game framework, Love2D. The project is in its very early stages. It can currently:

- Simulate a 320x200 graphics mode with 256 palettized colors
- Load palette, sprites, maps and music of the game
- Partially load some xml objects (shows some animations on one map at the moment)
- Scroll around the currently loaded map.

The current goal is to begin porting some of the state logic.

The original FreeBASIC source code and win32 installer is included in the repository for convenience.

Also, the map data was originally zlib compressed. I had some trouble getting zlib to work with lua, but I was able to run the map files through a
utility called offzip (also included in the repository). The uncompressed map files are in data/map. The original, compressed map files are in
data/mapc if we decide we want to move back to using zlib. The difference in compressed size is likely not to be very relevant to a modern user,
only making a difference in about 5 mb of disk space.
