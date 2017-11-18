import os

def csv(f):
    d = f.read(1)
    #print("d: " + d)
    industry = ""
    note = ""
    state = 1 # 1 initial state, 2 reading notes
    while((not d == "," and not d == ";") or state == 2):
        if(state == 1):
            if(d == "("):
                state = 2
            else:
                industry += d
        elif(state == 2):
            if(d == ")"):
                state = 1
            else:
                note += d
        d = f.read(1)
    d = f.read(1)
    return d, industry, note

def main():
    i = 0
    f = open("../txt/Industries.txt", "r")
    while(True):
        name = f.readline()
        if(name == "\n"):
            break;
        name = name[:len(name)-1]
        name2 = ""
        c = ""
        while(c != os.linesep):
            c, industry, note = csv(f)
            if(note == ""):
                print("INSERT INTO Industries(id, country, industry) VALUES(" + str(i) + ", \"" + name + "\", \"" + industry + "\");")
            else:
                print("INSERT INTO Industries VALUES(" + str(i) + ", \"" + name + "\", \"" + industry + "\", \"" + note + "\");")
            i += 1

if __name__ == "__main__":
    main()
