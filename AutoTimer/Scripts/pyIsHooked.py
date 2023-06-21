import dolphin_memory_engine as dme

def getHooked() -> bool:
    dme.hook()
    return dme.is_hooked()

print(getHooked())