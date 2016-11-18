filename = input("Enter File Name: ")
fout = open(filename)
for line in fout:
    print("{:s}".format(line.upper))
