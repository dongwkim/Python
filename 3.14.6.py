# import pdb
def computepay(hours, rate):
    # basehr = 40
    if  hours <= basehr :
        pay = hours * rate
    else:
        pay = rate * ( basehr + ( hours - basehr ) * 1.5 )
    return pay

try:
    hours = int(input("Enter Hours:"))
    rate = int(input("Enter Rate:"))
    basehr = 40
    pay = computepay(hours, rate)
    # if [ hours <= basehr ]:
    #     pay = hours * rate
    # else:
    #     pay = basehr * rate + ( hours - 40 ) * 1.5

#print("Pay:",float(pay))
    print('Pay:%.2f' % pay)
except ValueError:
    print('Error, please enter numeric input')
