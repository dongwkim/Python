def computepay(hours, rate):
    basehr = 40
    hours = int(hours)
    rate = int(rate)
    if [ hours <= basehr ]:
        pay = hours * rate
    else:
        pay = basehr * rate + ( hours - basehr ) * 1.5
    return pay

try:
    hours = input("Enter Hours:")
    rate = input("Enter Rate:")
    # basehr = 40
    pay = computepay(hours,rate)
    # if [ hours <= basehr ]:
    #     pay = hours * rate
    # else:
    #     pay = basehr * rate + ( hours - 40 ) * 1.5

#print("Pay:",float(pay))
    print('Pay:%.2f' % pay)
except ValueError:
    print('Error, please enter numeric input')
