# Lynn's Legacy
Lynn's Legacy is a Zelda-like game originally by indie game developers cha0s and Josiah Tobin. It was released as open source/public domain in 2006.
It is still available as a win32 binary, but I felt it would be really nice if the game were made available on modern systems so this project
exists to port the game to a modern game framework, Love2D. You can get the original game here: https://sourceforge.net/projects/lynn/ and you can view a youtube playthrough of the game here: https://youtu.be/5cX48TFYRAk

It is a very well made Zelda-clone with a dark atmosphere, great graphics and excellent music. I spent a lot of time in my youth in the 90's trying to make an RPG in QBasic, and the fact this game was made in FreeBASIC (which is an open source version of QuickBASIC) kind of gives me nostalgia both for those days as well as for it being an homage to the Zelda franchise. I don't want to see it lost to history, hence this project (the win32 binary has some problems on modern systems, and I fear it won't be long before it is completely unplayable).

Q. Since the source code is still available, and FreeBASIC is still maintained and has a 64 bit version, why not just fix up the original codebase?

A. That's a very good question. I have spent quite a lot of time trying to do this. I actually was able to get the game to compile with the win32 version of the FreeBASIC compiler, but then it crashes very soon after the splash screen. At the same time, I simply enjoy making game engines and working with frameworks like Love2D, so it seemed like a more pleasant, if longer path, towards getting the game running. Plus, as far as I can tell, FreeBASIC cannot work in fullscreen with crisp pixels anymore, so I would have had to roll my own solution for this either way. At the end of the day, the project exists for my pleasure in programming and my desire to preserve the game.

The project is in its very early stages. It can currently:

- Simulate a 320x200 graphics mode with 256 palettized colors
- Load palette, sprites, maps and music of the game
- Partially load enemy xml
- Has enough state callbacks implemented so that one gcopter enemy flies around with map collision
- Partially loads hero xml. You can move Lynn around and the camera follows her.

This is a Love2D project. So to work on it, you will need to install LÖVE: https://love2d.org/ The language is Lua.

The current goal is to get Lynn herself walking around the map and eventually fighting with the gcopter enemy.

The original FreeBASIC source code and win32 installer is included in the repository for convenience.

Also, the map data was originally zlib compressed. I had some trouble getting zlib to work with lua, but I was able to run the map files through a
utility called offzip (also included in the repository). The uncompressed map files are in data/map. The original, compressed map files are in
data/mapc if we decide we want to move back to using zlib. The difference in compressed size is likely not to be very relevant to a modern user,
only making a difference in about 5 mb of disk space.

I've been inspired by this game since 2007. As far back as 2013 I was already thinking about porting this game to C, PyGame, and even kicked around the idea of porting it to the SNES, since I have experience making games for the original NES. It has been quite a rollercoaster getting to where I am with the project today. In 2019, I got this Love2D port going but only got as far as loading assets with very little actual game logic ported. Then my wife left me and I put the project on indefinite hiatus. Thanks to Covid-19, I resuscitated the project in 2020 and really dug in and got the project truly off the ground, after a very emotional few days of trying and failing to get the game to compile in its original language on an up to date version of FreeBASIC. The path I've chosen of a full port is a little bit nutty, but as it turns out I'm really enjoying myself like I'm assembling an enormous jigsaw puzzle, and at the same time exercising my ability to read code by other people and understand it. I intend to put it up on itch.io for fellow retro gaming enthusiasts to enjoy when I am finished.
