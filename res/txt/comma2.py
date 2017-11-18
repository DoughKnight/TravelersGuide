def parse(f):
   line = "do"
   i = 0
   while(line != ""):
       line = f.readline()
       line = line[:len(line)-1]
       i += 1
       if(i % 3 == 2):
           line = line[:len(line)-1] + ","
       print(line)

if __name__ == "__main__":
    f = open("Industries.txt", "r")
    parse(f)

