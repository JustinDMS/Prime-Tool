import dolphin_memory_engine as dme

addresses : dict = {
    "Last Room Time": 0x80600978,
    "Speed": 0x8046BE78,
}

def main():
    dme.hook()
    if dme.is_hooked():
       print(dme.read_double(addresses["Last Room Time"]), end=',')
       print(dme.read_float(addresses["Speed"]), end='')
    else:
        print("Not Hooked", end='')

if __name__ == "__main__":
    main()