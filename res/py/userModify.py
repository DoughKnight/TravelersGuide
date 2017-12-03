import random

def psw(line):
    index = 0 ; count = 0 ; char = ""
    while(count != 3 or char != ","):
        char = line[index]
        if(char == ","):
            count += 1
        index += 1
    l = random.randint(8,20) ; c = 0 ; mid = ""
    while(c != l):
        bla = random.randint(35, 126)
        if bla == 69 or bla == 92:
            bla += 1 #to prevent an ES or EN combination, or to prevent escape sequences
        mid += chr(bla)
        c += 1
    return line[:index] + " \"" + mid + "\"," + line[index:]

def lang(line):
    ru = False;
    replacement = ""
    if line.find(".ru") != -1:
        ru = True
        
    code_index = line.find("EN")
    if code_index == -1:
        code_index = line.rfind("ES")
        code = "ES"
    else:
        code = "EN"
    if ru == True:
        if code == "ES":
            opt = random.randint(0, 1)
            if opt == 0:
                replacement = "Belarusian"
            if opt == 1:
                replacement = "Ukrainian" 
        else:
            replacement = "Russian"
    else:
        if(code == "ES"):
            opt = random.randint(0,2)
            if opt == 0:
                replacement = "Chinese"
            if opt == 1:
                replacement = "Spanish"
            if opt == 2:
                replacement = "Hindi"
    if code == "EN" and not ru == True:
        replacement = "English"
    return line[:code_index] + replacement + line[code_index+2:]

def main():
    f = open("../../TravelersGuide.sql", "r")
    line = "do"
    while(line != ""):
        line = f.readline()
        if "INSERT INTO Users" in line:
            line = psw(line)
            line = lang(line)
            print(line[:len(line)-1])
        else:
            print(line[:len(line)-1])

if __name__ == "__main__":
    main()
