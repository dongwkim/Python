hours = int(input("Enter Hours:"))
rate = int(input("Enter Rate:"))

basehr = 40
if [ hours <= basehr ]:
    pay = hours * rate
else:
    pay = basehr * rate + ( hours - 40 ) * 1.5

#print("Pay:",float(pay))
print('Pay:%.2f' % pay)
