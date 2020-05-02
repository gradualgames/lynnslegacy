from zipfile import ZipFile
import os
import shutil

outputDir = "./ll"

def addDir(dirPath):
   # Iterate over all the files in directory
   for folderName, subfolders, filenames in os.walk(dirPath):
       for filename in filenames:
           #create complete filepath of file in directory
           filePath = os.path.join(folderName, filename)
           # Add file to zip
           zipObj.write(filePath)

# Create ll output folder.
if not os.path.exists(outputDir):
    os.makedirs(outputDir)

# Create the .love file.
with ZipFile("./ll/ll.love", "w") as zipObj:
    addDir("./data")
    addDir("./game")
    addDir("./lib")
    addDir("./shader")
    zipObj.write("./main.lua")

# Copy love.exe and *.dll from love installation directory into output directory.
shutil.copyfile("C:\Program Files\LOVE\love.exe", os.path.join(outputDir, "ll.exe"))
shutil.copyfile("C:\Program Files\LOVE\love.dll", os.path.join(outputDir, "love.dll"))
shutil.copyfile("C:\Program Files\LOVE\lua51.dll", os.path.join(outputDir, "lua51.dll"))
shutil.copyfile("C:\Program Files\LOVE\mpg123.dll", os.path.join(outputDir, "mpg123.dll"))
shutil.copyfile("C:\Program Files\LOVE\msvcp120.dll", os.path.join(outputDir, "msvcp120.dll"))
shutil.copyfile("C:\Program Files\LOVE\msvcr120.dll", os.path.join(outputDir, "msvcr120.dll"))
shutil.copyfile("C:\Program Files\LOVE\OpenAL32.dll", os.path.join(outputDir, "OpenAL32.dll"))
shutil.copyfile("C:\Program Files\LOVE\SDL2.dll", os.path.join(outputDir, "SDL2.dll"))

# Now append our .love file onto the copied love executable.
with open(os.path.join(outputDir, "ll.exe"), "ab") as exe, open(os.path.join(outputDir, "ll.love"), "rb") as love:
    exe.write(love.read())

# Now delete the .love file.
os.remove("./ll/ll.love")
