def count(str ,letter):
    count = 0
    for pick in str:
        if pick == letter:
            count += 1
    print(count)


str='My Name is Boy and Bob and Babb'
count(str,'B')
print("{:d}".format(str.count('B')))
