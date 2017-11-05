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

def get_field(f, char):
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

def main():
    f = open("print_2003.html", "r")
    char = f.read(1)
    while(char != ''):
        get_name(f, char) 
        get_field(f, char)
        char = f.read(1)

   
if __name__ ==  "__main__":
    main()

