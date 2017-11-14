import sys

def gather(f_b, f_c, f_a):
    
    while(True):
        #get background ----------------------------------------
        name = f_b.readline()
        if(name==""):
            return True
        name = name[:len(name)-1]
        background = f_b.readline()
        f_b.readline()
        background = background[:len(background)-1]
        #get latitude ------------------------------------------
        match_name = f_c.readline()
        match_name = match_name[:len(match_name)-1]
        if name != match_name:
            print("Fatal Error - Name mismatch")
            print(name + " v.s. " + match_name)
            sys.exit(0)
        latitude = ""
        char = f_c.read(1)
        while(char.isdigit()):
            latitude += char
            char = f_c.read(1)
        fraction = "."
        char = f_c.read(1)
        while(char.isdigit()):
            fraction += char
            char = f_c.read(1)
        latitude += fraction
        #get longitude ----------------------------------------
        f_c.seek(3, 1)
        longitude = ""
        char = f_c.read(1)
        while(char.isdigit()):
            longitude += char
            char = f_c.read(1)
        fraction2 = "."
        char = f_c.read(1)
        while(char.isdigit()):
            fraction2 += char
            char = f_c.read(1)
        f_c.seek(2, 1)
        longitude += fraction2
        #get area ---------------------------------------------
        match_name = f_a.readline()
        match_name = match_name[:len(match_name)-1]
        if name != match_name:
            print("Fatal Error - Name mismatch")
            print(name + " v.s. " + match_name)
            sys.exit(0)
        area = ""
        char = f_a.read(1)
        while(char.isdigit()):
            area += char
            char = f_a.read(1)
        f_a.readline()
        #------------------------------------------------------
        # Build the SQL statement
        #------------------------------------------------------
        print("INSERT INTO Country VALUES (\"" + name + "\", \"" + background + "\", " + latitude + ", " + longitude + ", " + area + ");")
        print("")


def main():
    f_background = open("../txt/Background.txt", "r")
    f_coords = open("../txt/Geographic_Coordinates.txt", "r")
    f_area = open("../txt/Area.txt", "r")
    gather(f_background, f_coords, f_area)


if __name__ == "__main__":
    main()

'''
INSERT INTO Country
Values(name, background, latitude, longitude, area);
'''
