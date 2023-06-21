import dolphin_memory_engine as dme

lrt_address = 0x80600978

def hookDME():
    dme.hook()

def getLastRoomTime():
    if dme.is_hooked():
        print(dme.read_double(lrt_address))
    return

hookDME()
getLastRoomTime()