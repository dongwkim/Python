def calc():
    total = 0
    count = 0
    avg =0

    while True:
        try:
          read = input("Enter a Number: ")
          if read == 'done':
            print('Sum: %d' % total, 'Count: %d' % count, 'Average: %.3f' % avg)
            break
          read = int(read)
          count += 1
          total += read
          avg = total / count
        except ValueError:
          print('Invalid Input')
          continue

def calclist():
    inputlist=[]
    total = 0
    count = 0
    avg =0
    while True:
        try:
          read = input("Enter a Number: ")
          if read == 'done':
            print('Sum: %d' % total, 'Count: %d' % count, 'Average: %.3f' % avg, 'Max: %d' % maxiest , 'Min: %d' % smallest)
            break
          read = int(read)
          #format(read, 'd')
          inputlist.append(read)
          count = len(inputlist)
          total = sum(inputlist)
          avg = int(total / count)
          maxiest = max(inputlist)
          smallest = min(inputlist)

        except ValueError:
          print('Invalid Input')
          continue
def main():
        calclist()
if __name__ == '__main__':
    main()
