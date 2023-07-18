import dolphin_memory_engine as dme

def main():
    dme.hook()
    if dme.is_hooked():
        print(1, end='')
        return 1
    else:
        print(0, end='')
        return 0

if __name__ == "__main__":
    main()