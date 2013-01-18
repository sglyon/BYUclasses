"""
Created Jan 16, 2013

Author: Spencer Lyon

Lab 2 for Physics 430
"""
from __future__ import division
import numpy as np
from numpy import cos, sin
import matplotlib.pyplot as plt
import scipy.linalg as la
from scipy.special import jn
import pandas as pd
from sympy import symbols, Eq, solve, pprint, diff, expand
from tools import make_grid

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
    # ------------------------------- Part a ------------------------------- #
    n = 30
    xmin = 0
    xmax = 2
    x, h = make_grid(xmin, xmax, n, 'cell_edge')

    cot = lambda x: 1 / np.tan(x)
    csc = lambda x: 1 / np.sin(x)

    # ------------------------------- Part b ------------------------------- #
    fy = lambda x: \
        (1 / 24) * ((-2) * cos(3 * x) * sin(2 * x) + (-4) * cos(2) ** 2 * \
        sin(3 * x) + cos(8) * sin(3 * x) + 4 * cos(x) ** 2 * sin(3 * x) + \
        (-1) * cos(4 * x) * sin(3 * x) + 24 * csc(6) * sin(3 * x) + 2 * \
        cot(6) * sin(4) * sin(3 * x) + (-1) * cot(6) * sin(8) * sin(3 * x) + \
        cos(3 * x) * sin(4 * x))

    y = fy(x)

    # ------------------------------- Part c ------------------------------- #
    # Create the matrix representing A in the matrix equation 2.5
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

    Notes
    -----
    Part a:
        Solve equation 2.6 using the linear algebra approach

    Part b:
        Solve equation 2.7 using the linear algebra approach
    """
    # ------------------------------- Part a ------------------------------- #
    n = 30
    xmin = 0
    xmax = 5
    x, h = make_grid(xmin, xmax, n, 'cell_edge')

    # Create matrix A
    A = np.zeros((n, n))  # Preallocate memory for A
    A[0, 0] = 1  # Set first row of A
    A[-1, -1] = 1  # Set last row of A

    for i in xrange(1,  n - 1):
        # For readability I compute each element on a separate line and combine
        jx = x[i]
        el1 = 1 / (h ** 2) - 1 / (2 * jx * h)  # for y_{j - 1}
        el2 = - 2 / (h ** 2) + 1 - 1 / (jx ** 2)  # for y_{j}
        el3 = 1 / (h ** 2) + 1 / (2 * jx * h)  # for y_{j + 1}
        A[i, i - 1: i + 2] = [el1, el2, el3]

    # Create vector to represent x in the matrix equation
    x_approx = np.zeros(n)  # Preallocate memory for A
    x_approx[0] = 0  # Set first row of x_approx
    x_approx[-1] = 1  # Set last row of x_approx
    x_approx[1:-1] = x[1:-1]  # Fill in all other rows of x_approx

    # Solve the matrix equation
    y_approx = la.solve(A, x_approx)

    # Compute Exact solution
    y = - 4 / jn(1, 5) * jn(1, x) + x

    # Plot solution
    plt.figure()
    plt.plot(x, y_approx, 'r.', x, y, 'b')
    plt.title('Plot for part a')
    plt.draw()

    # ------------------------------- Part b ------------------------------- #
    n2 = 600
    xmin2 = 0
    xmax2 = 5
    x2, h2 = make_grid(xmin2, xmax2, n2, 'cell_edge')

    A2 = np.zeros((n2, n2))  # Preallocate memory for A2
    A2[0, 0] = 1  # Set first row of A2
    A2[-1, -1] = 1  # Set last row of A2

    for i in xrange(1,  n2 - 1):
        # For readability I compute each element on a separate line and combine
        xi = x2[i]
        el1 = 1 / (h2 ** 2) - np.sin(xi) / (2 * h2)  # for y_{j - 1}
        el2 = - 2 / (h2 ** 2) + np.exp(xi)  # for y_{j}
        el3 = 1 / (h2 ** 2) + np.sin(xi) / (2 * h2)  # for y_{j + 1}
        A2[i, i - 1: i + 2] = [el1, el2, el3]

    # Create vector to represent x in the matrix equation
    x_approx2 = np.zeros(n2)  # Preallocate memory for A2
    x_approx2[0] = 0  # Set first row of x_approx2
    x_approx2[-1] = 3  # Set last row of x_approx2
    x_approx2[1:-1] = x2[1:-1]  # Fill in all other rows of x_approx2

    # Solve the matrix equation
    y_approx2 = la.solve(A2, x_approx2)

    plt.figure()
    plt.plot(x2, y_approx2)
    plt.title('Plot for part b')
    plt.draw()

    ind1 = np.where(x2 > 4.5)[0][0]
    close_ones = np.array([ind1 - 1, ind1])
    print 'From Mathematica y(4.5) = 8.72062'

    py_data = pd.DataFrame(np.column_stack((x2[close_ones],
                                           y_approx2[close_ones])),
                            columns=['x', 'y'])
    print 'Data around x = 4.5 from python: '
    print py_data


def p2_3(part=None):
    """
    Complete solution to problem 2.3

    Parameters
    ----------
    part: str, optional(default=None)
        The part number you would like evaluated. If this is left blank
        the default value of None is used and the entire problem will be
        solved.

    Returns
    -------
    i-dont-know-

    Notes
    -----
    Part a:
        Solve equation 2.8 with forward difference for derivative B.C.

    Part b:
        Solve equation 2.8 with quadratic extrapolation for derivative
        B.C.
    """
    def p2_2_sym():
        a, b, c, x, xN, xNm1, xNm2 = symbols('a, b, c, x, xN, xNm1, xNm2')
        h, yN, yNm1, yNm2 = symbols('h, yN, yNm1, yNm2')

        xNm1 = xN - h
        xNm2 = xN - 2 * h
        eqns = (Eq(yN, a + b * xN + c * xN ** 2),
                Eq(yNm1, a + b * xNm1 + c * xNm1 ** 2),
                Eq(yNm2, a + b * xNm2 + c * xNm2 ** 2))
        soln = solve(eqns, a, b, c)

        x = symbols('x')

        y = a + b * x + c * x ** 2
        yprime = diff(y, x)

        soln[x] = xN

        ans = expand(yprime.subs(soln))
        print 'Solution to symbolic part: '
        pprint(ans)
        return
    # ------------------------------- Part a ------------------------------- #
    n = 30
    xmin = 0
    xmax = 2
    x, h = make_grid(xmin, xmax, n, 'cell_edge')

    # Create the matrix representing A in the matrix equation 2.5
    A = np.zeros((n, n))  # Preallocate memory for A
    A[0, 0] = 1  # Set first row of A
    A[-1, -2:] = [-1 / h, 1 / h]  # Set last row of A

    for i in xrange(1, n - 1):  # Fill in all other rows of A
        A[i, i - 1: i + 2] = [1 / (h ** 2), - 2 / (h ** 2) + 9, 1 / (h ** 2)]

    # Create the vector representing x in the matrix equation 2.5
    x_approx = np.zeros(n)  # Preallocate memory for x_approx
    x_approx[0] = 0  # Set first row of x_approx
    x_approx[-1] = 0  # Set last row of x_approx
    x_approx[1:-1] = x[1:-1]  # Fill in all other rows of x_approx

    # Approximate y
    y_approx = la.solve(A, x_approx)

    y = x / 9 - np.sin(3 * x) / (27 * np.cos(6))

    plt.figure()
    plt.plot(x, y_approx, 'r.',  x, y, 'b-')
    plt.title('Problem 2.3 part a')
    plt.draw()

    rms_err_a = np.sqrt(np.mean(np.power(y - y_approx, 2)))

    # ------------------------------- Part b ------------------------------- #
    # Call symbolic function:
    p2_2_sym()
    # Create A matrix
    A2 = np.zeros((n, n))  # Preallocate memory for A2
    A2[0, 0] = 1  # Set first row of A2
    A2[-1, -3:] = [1 / (2 * h), -2 / h, 3 / (2 * h)]  # Set last row of A2

    for i in xrange(1, n - 1):  # Fill in all other rows of A2
        A2[i, i - 1: i + 2] = [1 / (h ** 2), - 2 / (h ** 2) + 9, 1 / (h ** 2)]

    # Approximate y
    y_approx2 = la.solve(A2, x_approx)

    plt.figure()
    plt.plot(x, y_approx2, 'r.',  x, y, 'b-')
    plt.title('Problem 2.3 part b')
    rms_err_b = np.sqrt(np.mean(np.power(y - y_approx2, 2)))

    err = pd.DataFrame(np.array([rms_err_a, rms_err_b]),
                       index=['Forward Difference', 'Quadratic Extrapolation'],
                       columns=['RMS errors'])
    print err


def p2_4(part=None):
    """
    Complete solution to problem 2.4

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
        We can't turn this into a linear algebra problem because of the
        fact that y(x) is embedded inside the sin() function.

    Part b:
        Solve equation 2.13 with linear algebra methods inside an
        iterative loop.
    """
    # ------------------------------- Part b ------------------------------- #
    n = 50
    xmin = 0
    xmax = 3
    x, h = make_grid(xmin, xmax, n, 'cell_edge')

    # Create the matrix representing A in the matrix equation 2.5
    A = np.zeros((n, n))  # Preallocate memory for A
    A[0, 0] = 1  # Set first row of A
    A[-1, -1] = 1  # Set last row of A

    for i in xrange(1, n - 1):  # Fill in all other rows of A
        A[i, i - 1: i + 2] = [1 / (h ** 2), - 2 / (h ** 2), 1 / (h ** 2)]

    # Setup iteration variables
    toler = 1e-8  # convergence criterion
    max_iter = 500  # Max number of iterations
    its = 0  # iteration number counter
    dist = 500  # starting norm

    # define initial y(x)
    y_old = np.zeros(n)

    while its < max_iter and dist > toler:
        b = 1 - np.sin(y_old)  # Create b using y_old
        b[0] = 0
        b[-1] = 0
        y = la.solve(A, b)  # Solve linear problem for y

        # Create y'' and check the norm
        dist = np.linalg.norm(A.dot(y) - 1 + np.sin(y))

        # Set y_old equal to the y created on this iteration and update its
        y_old = y
        its += 1

    plt.figure()
    plt.plot(x, y)
    plt.title('Solution to 2.4 part b')
    plt.show()
