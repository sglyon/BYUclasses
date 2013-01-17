from math import sqrt, pow
import sys


def n_4_squares(nn):
    """
    Determine the number of ways the number n can be created as the
    sum of 4 squares.
    """
    how_many = 0
    n = nn
    for a in xrange(0, int(sqrt(n)) + 1):
        for b in xrange(0, min(a, int(sqrt(n - pow(a, 2)))) + 1):
            for c in xrange(0, min(a, int(sqrt(n - pow(a, 2) - pow(b, 2)))) + 1):
                temp_d = n - pow(a, 2) - pow(b, 2) - pow(c, 2)
                if temp_d >= 0:
                    print(a, b, c)
                    how_many += 1
    return how_many


if __name__ == '__main__':
    arg = sys.argv[1]
    print arg
    n_4_squares(int(arg))