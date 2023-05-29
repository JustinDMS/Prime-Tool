import json

file_path = r"C:\Users\Justin\Documents\Godot\PrimeTool\Tools\RoomData.json"

def readJSON():
    with open(file_path) as file:
        return json.load(file)

def previewNewData():
    new_string = json.dumps(data, indent=2)
    print(new_string)

def writeJSON():
    with open(file_path, "w") as outfile:
        json.dump(data, outfile, indent=2)

#############################

data = readJSON()

for world in data["World"]:
    for room in data["World"][world]:
       for connection in data["World"][world][room].copy():
           if 'Lock Type' in data["World"][world][room][connection]:
               del data["World"][world][room][connection]['Lock Type']
           if not 'Door' in data["World"][world][room][connection]:
               data["World"][world][room][connection] = {"World" : world, "Door" : "Power"}

previewNewData()
