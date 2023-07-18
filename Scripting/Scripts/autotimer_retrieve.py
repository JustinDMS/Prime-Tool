import dolphin_memory_engine as dme

addresses : dict = {
    "Last Room Time": 0x80600978,
    "Speed": 0x80600954,
}

def main():
    dme.hook()
    if dme.is_hooked():
       print(dme.read_double(addresses["Last Room Time"]), end='')
    else:
        print("Not Hooked", end='')

if __name__ == "__main__":
    main()