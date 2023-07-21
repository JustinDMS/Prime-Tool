import dolphin_memory_engine as dme

addresses : dict = {
    "Last Room Time": 0x80600978,
    "Speed": 0x8046BE78,
    "Dash Button Time": 0x8046BD04,
    "IGT": 0x80962CA0,
}

def main():
    dme.hook()
    if dme.is_hooked():
       print(dme.read_double(addresses["Last Room Time"]), end=',')
       print(dme.read_float(addresses["Speed"]), end=',')
       print(dme.read_double(addresses["IGT"]), end='')
    else:
        print("Not Hooked", end='')

if __name__ == "__main__":
    main()