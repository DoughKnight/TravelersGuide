import os

def csv(f, p):
    d = f.read(1)
    name = ""
    length = ""
    while(not d.isdigit()):
        name += d
        d = f.read(1)
    name = name[:len(name)-1]
    while(not d == ","):
        length += d
        d = f.read(1)
    d = f.read(1)
    return d, name, length, name == p

def main():
    f = open("../txt/Land_Boundaries.txt", "r")
    while(True):
        name = f.readline()
        if(name == ""):
            break;
        name = name[:len(name)-1]
        name2 = ""
        c = f.read(1)
        while(c != ":"):
            c = f.read(1)
        f.seek(1, 1)
        previous = ""
        while(c != os.linesep):
            c, name2, length, match = csv(f, previous)
            previous = name2
            if(not match):
                print("INSERT INTO Boundaries VALUES(\"" + name + "\", \"" + name2 + "\", " + length[:len(length)-3] + ");")

if __name__ == "__main__":
    main()
