import os

def csv(f):
    d = f.read(1)
    #print("d: " + d)
    name = ""
    percent = ""
    failsafe = False
    state = -1 # -1 initial state, 0 not reading, 1 reading name, 2 reading percent
    while(not d == ","):
        if(state == -1):
            if(d[0].isupper()):
                state = 1
            elif(d[0].islower()):
                state = 0
            elif(d[0].isdigit()):
                state = 2
        if(state == 0):
            failsafe = True
        if(state == 1):
            name += d
            if(d == " "):
                state = -1
        if(state == 2):
            if(name == ""):
                failsafe = True
                state = 0
            if(d != "%"):
                percent += d
        d = f.read(1)
    d = f.read(1)
    if(len(name) > 0):
        if(name[len(name) - 1] == " "):
            name = name[:len(name)-1]
    return d, name, percent, failsafe

def main():
    i = 0
    f = open("../txt/Languages.txt", "r")
    while(True):
        name = f.readline()
        if(name == ""):
            break;
        name = name[:len(name)-2]
        name2 = ""
        c = ""
        while(c != os.linesep):
            c, name2, percent, failsafe = csv(f)
            if(not failsafe):
                if(percent == ""):
                    print("INSERT INTO Languages(id, name, country) VALUES(" + str(i) + ", \"" + name2 + "\", \"" + name + "\");")
                else:
                    print("INSERT INTO Languages VALUES(" + str(i) + ", \"" + name2 + "\", \"" + name + "\", " + percent + ");")
                i += 1

if __name__ == "__main__":
    main()
