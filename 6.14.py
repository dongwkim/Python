str = 'X-DSPAM-Confidence: 0.8475'

idx_pos = str.find(':')
print("{:f}".format(float(str[idx_pos+1:].strip())))

str = 'X Y     Z'
print(repr(str))
