import sys

def get_name(f, char):
    if(char == 'b'): #specifically to read char-by-char
        if(f.read(3) == "old"): #otherwise reading by 4 would require seeking back
            #lock-on
            f.seek(4, 1)
            land = ""
            char = f.read(1)
            while(char != "<"):
                land += char
                char = f.read(1)
            print(land)

def get_2003(f, char):
    if(char == 't' and f.read(1) == 'd'):
        if(f.read(3) == ' cl'):
            #lock-on
            f.seek(67, 1)
            field = ""
            char = f.read(1)
            if(char == '-' or char.isdigit() or char == 'N'):
                while(char != ' '):
                    field += char
                    char = f.read(1)
                print(field);
                return


def get_2004(f, char):
    if(char == 't' and f.read(1) == 'd'):
        if(f.read(3) == ' cl'):
            #lock-on
            f.seek(67, 1)
            field = ""
            char = f.read(1)
            if(char == '$'):
                while(char != ' '):
                    field += char
                    char = f.read(1)
                print(field);
                return

def get_2011(f, char):
    if(char == 't' and f.read(1) == 'd'):
        if(f.read(3) == ' cl'):
            #lock-on
            f.seek(67, 1)
            field = ""
            char = f.read(1)
            while(not char.isdigit()):
                char = f.read(1)
            while(char != 'W' and char != 'E'):
                field += char
                char = f.read(1)
            if(char == 'W' or char == 'E'):
                field += char
            print(field)
            return


def get_2012(f, char):
    if(char == 't' and f.read(1) == 'd'):
        if(f.read(3) == ' cl'):
            #lock-on
            f.seek(84, 1)
            field = ""
            char = f.read(1)
            if(char == "a"): #necessary for gaza strip
                i = 3
                while i > 0:
                    while(not char.isdigit() and char != 'N'):
                        char = f.read(1)
                    while(char != '%'):
                        field += char
                        char = f.read(1)
                    field += char
                    if(i != 1):
                        field += ' '
                    i -= 1
            print(field)
            return


def get_2028(f, char):
    if(char == 't' and f.read(1) == 'd'):
        if(f.read(3) == ' cl'):
            #lock-on
            f.seek(67, 1)
            field = ""
            char = f.read(1)
            while(char != '<'):
                field += char
                char = f.read(1)
                if(char == '<'):
                    if(f.read(3) != "/td"):
                        char = f.read(1)
                        while(char != '>'):
                            char = f.read(1)
                        char = f.read(1)
            
            print(field);
            return


def get_2046(f, char):
    if(char == 't' and f.read(1) == 'd'):
        if(f.read(3) == ' cl'):
            #lock-on
            f.seek(67, 1)
            field = ""
            char = f.read(1)
            if(char.isdigit() or char == 'N'):
                while(char != ' '):
                    field += char
                    char = f.read(1)
                print(field);
                return


def get_2090(f, char):
    if(char == 't' and f.read(1) == 'd'):
        if(f.read(3) == ' cl'):
            #lock-on
            f.seek(67, 1)
            field = ""
            char = f.read(1)
            while(char != '<'):
                field += char
                char = f.read(1)
                if(char == '<'):
                    if(f.read(3) != "/td"):
                        char = f.read(1)
                        while(char != '>'):
                            char = f.read(1)
                        char = f.read(1)
            
            print(field);
            return



def main():
    f = open("../html/print_" + sys.argv[1] + ".html", "r")
    get_field = {
        "2003": get_2003,
        "2004": get_2004,
        "2011": get_2011,
        "2012": get_2012,
        "2028": get_2028,
        "2046": get_2046,
        "2090": get_2090,
    }
    char = f.read(1)
    while(char != ''):
        get_name(f, char) 
        get_field[sys.argv[1]](f, char)
        char = f.read(1)

   
if __name__ ==  "__main__":
    main()

