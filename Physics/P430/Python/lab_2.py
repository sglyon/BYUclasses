"""
Created Jan 16, 2013

Author: Spencer Lyon

Lab 1 for Physics 430
"""
from __future__ import division
import numpy as np
from numpy import cos, sin
import matplotlib.pyplot as plt
import scipy.linalg as la
from tools import make_grid, centered_difference

plt.ion()


def p2_1(part=None):
    """
    Complete solution to problem 2.1

    Parameters
    ----------
    part: str, optional(default=None)
        The part number you would like evaluated. If this is left blank
        the default value of None is used and the entire problem will be
        solved.

    Returns
    -------
    i-dont-know-yet

    Notes
    -----
    Part a:
        Create a cell edge grid witn n = 30 points from x = 0 to x = 2.

    Part b:
        Solve boundary value problem in mathematica, use ToMatlab to get
        the solution in MatLab, then plot the solution using a blue
        curve.

    Part c:
        Solve the boundary value problem using the linear algebra
        technique summarized in equation 2.5 then plot the solution
        using red dots. Then repeat the process with N = 100 instead
        of N = 30
    """
    x, h = make_grid(0, 2, 30, 'cell_edge')

    cot = lambda x: 1 / np.tan(x)
    csc = lambda x: 1 / np.sin(x)

    fy = lambda x: \
        (1 / 24) * ((-2) * cos(3 * x) * sin(2 * x) + (-4) * cos(2) ** 2 * \
        sin(3 * x) + cos(8) * sin(3 * x) + 4 * cos(x) ** 2 * sin(3 * x) + \
        (-1) * cos(4 * x) * sin(3 * x) + 24 * csc(6) * sin(3 * x) + 2 * \
        cot(6) * sin(4) * sin(3 * x) + (-1) * cot(6) * sin(8) * sin(3 * x) + \
        cos(3 * x) * sin(4 * x))

    y = fy(x)

    # Create the vector representing x in the matrix equation 2.5
    A = np.zeros((n, n))  # Preallocate memory for A
    A[0, 0] = 1  # Set first row of A
    A[-1, -1] = 1  # Set last row of A

    for i in xrange(1, n - 1):  # Fill in all other rows of A
        A[i, i - 1: i + 2] = [1 / (h ** 2), - 2 / (h ** 2) + 9, 1 / (h ** 2)]

    # Create the vector representing x in the matrix equation 2.5
    x_approx = np.zeros(n)  # Preallocate memory for x_approx
    x_approx[0] = 0  # Set first row of x_approx
    x_approx[-1] = 1  # Set last row of x_approx
    x_approx[1:-1] = sin(x[1:-1])  # Fill in all other rows of x_approx

    # Approximate y
    y_approx = la.solve(A, x_approx)

    plt.figure()
    plt.plot(x, y, 'b', x, y_approx, 'r.')
    plt.title('Exact and approximate with n = 30')
    plt.draw()

    n2 = 100
    h2 = (xmax - xmin) / (n2 - 1)
    x2 = np.linspace(xmin, xmax, n2)

    y2 = fy(x2)

    # Create the matrix representing A in the matrix equation 2.5
    A2 = np.zeros((n2, n2))  # Preallocate memory for A2
    A2[0, 0] = 1  # Set first row of A2
    A2[-1, -1] = 1  # Set last row of A2

    for i in xrange(1, n2 - 1):  # Fill in all other rows of A2
        A2[i, i - 1: i + 2] = [1 / (h2 ** 2), - 2 / (h2 ** 2) + 9, 1 / (h2 ** 2)]

    # Create the vector representing x in the matrix equation 2.5
    x_approx2 = np.zeros(n2)  # Preallocate memory for x_approx2
    x_approx2[0] = 0  # Set first row of x_approx2
    x_approx2[-1] = 1  # Set last row of x_approx2
    x_approx2[1:-1] = sin(x2[1:-1])  # Fill in all other rows of x_approx2

    # Approximate y
    y_approx2 = la.solve(A2, x_approx2)

    plt.figure()
    plt.plot(x2, y2, 'b', x2, y_approx2, 'r.')
    plt.title('Exact and approximate with n = 100')
    plt.draw()


def p2_2(part=None):
    """
    Complete solution to problem 2.2

    Parameters
    ----------
    part: str, optional(default=None)
        The part number you would like evaluated. If this is left blank
        the default value of None is used and the entire problem will be
        solved.

    Returns
    -------
    i-dont-know-yet
    """
