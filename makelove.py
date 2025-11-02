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

