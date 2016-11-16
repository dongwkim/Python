import sys

def computegrade(score):
    minscore = 0.0
    maxscore = 1.0

    if score < minscore or score > maxscore :
        print(score)
        print("Bad score")
        sys.exit(0)
    elif score >= 0.9 :
        grade = 'A'
    elif score >= 0.8 :
        grade = 'B'
    elif score >= 0.7 :
        grade = 'C'
    elif score >= 0.6 :
        grade = 'D'
    elif score < 0.6 :
        grade = 'F'
    return grade

def main():
    try:
        score = float(input("Enter score:"))
        grade = computegrade(score)
        print('Grade is %s' % grade)
    except ValueError:
        print('Bad score')

if __name__ == "__main__":
    main()
