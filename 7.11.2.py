filename = input("Enter File Name: ")
fout = open(filename)
total = 0
count = 0
for line in fout:
    if line.startswith("X-DSPAM-Confidence"):
        pos = line.find(':')
        total += float(line[pos + 1 : ].strip())
        count += 1

avg = float(total / count)
print("Total Line Count is: {:d} Average is: {:.10f}".format(count,avg))
