# Lynn's Legacy
Lynn's Legacy is a Zelda-like game originally by indie game developers cha0s and Josiah Tobin. It was released as open source/public domain in 2006.
It is still available as a win32 binary, but I felt it would be really nice if the game were made available on modern systems so this project
exists to port the game to a modern game framework, Love2D. You can get the original game here: https://sourceforge.net/projects/lynn/ and you can view a youtube playthrough of the game here: https://youtu.be/5cX48TFYRAk

It is a very well made Zelda-clone with a dark atmosphere, great graphics and excellent music. I spent a lot of time in my youth in the 90's trying to make an RPG in QBasic, and the fact this game was made in FreeBASIC (which is an open source version of QuickBASIC) kind of gives me nostalgia both for those days as well as for it being an homage to the Zelda franchise. I don't want to see it lost to history, hence this project (the win32 binary has some problems on modern systems, and I fear it won't be long before it is completely unplayable).

The project is in its very early stages. It can currently:

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
