import os
from glob import glob
import shutil
import string

world_directory = r"C:\Users\Justin\Documents\Prime\ExtractTemp\MP1\Metroid6\!6LavaWorld1028_3EF8237C"
new_directory = r"C:\Users\Justin\Documents\Prime\DumpedRooms\Magmoor Caverns"

def copyAndMoveModel(path:str):
    map_file_path = glob(path + '*.blend', recursive=True)[1]
    new_name = map_file_path.split(" ", maxsplit=1)[1] # Uses the name from the folder that has the .blend file and removes the number
    old_name = new_name.split("\\", maxsplit=1)[1] # Save the old name for os.rename()
    new_name = new_name.split("\\", maxsplit=1)[0] # Removes the backslash from the directory to give us the new name
    shutil.copy(map_file_path, new_directory)
    os.rename(new_directory + "/" + old_name, new_directory + "/" + new_name + ".blend")
    

if os.path.exists(world_directory):
    sub_folders = glob(world_directory + "/*/", recursive=True)
    for f in sub_folders:
        copyAndMoveModel(f)