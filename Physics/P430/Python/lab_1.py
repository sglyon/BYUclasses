"""
Created Jan 16, 2013

Author: Spencer Lyon

Lab 1 for Physics 430
"""
from __future__ import division
import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import quad
from scipy.special import jn
from numpy import exp
import pandas as pd
from tools import make_grid, centered_difference
from sympy import symbols, Eq, solve, pprint, simplify

plt.ion()


def p1_1(part=None):
    """
    Complete solution to problem 1.1

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
    print 'Starting part a'
    x_edge, h = make_grid(0, np.pi, 100, 'cell_edge')

    f = lambda x: np.sin(x) * np.sinh(x)

    plt.figure()
    plt.plot(x_edge, f(x_edge))
    plt.title('Part a')
    plt.draw()

    print 'Finished part a \n', '----' * 5, '\nStarting part b'

    x_center, h2 = make_grid(0, 2, 5000, 'cell_center')

    f2 = lambda x: np.cos(x)

    plt.figure()
    plt.plot(x_center, f2(x_center))
    plt.title('Part b')
    plt.draw()

    int_estimate = np.sum(f2(x_center)) * h2
    int_real = quad(f2, 0, 2)[0]

    abs_int_error = abs(int_real - int_estimate)
    print 'Absolute error in integral is %.6e' % (abs_int_error)

    print 'Finished part b \n', '----' * 5, '\nStarting part c'

    x_c_ghost, h3 = make_grid(0, np.pi / 2, 500, 'cell_center_ghost')

    f3 = lambda x: np.sin(x)

    y3 = f3(x_c_ghost)

    pass  # Return nothing


def p1_3(part=None):
    """
    Complete solution to problem 1.3

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
    a, b, c, x, x1, x2, x3, h, y1, y2, y3 = symbols('a, b, c, x, x1, x2, x3, \
                                                     h, y1, y2, y3')
    x2 = x1 + h
    x3 = x1 + 2 * h
    eqns = (Eq(y1, a + b * x1 + c * x1 ** 2),
            Eq(y2, a + b * x2 + c * x2 ** 2),
            Eq(y3, a + b * x3 + c * x3 ** 2))
    soln = solve(eqns, a, b, c)
    y = a + b * x + c * x ** 2

    soln[x] = (x1 + x2) / 2
    y_est1 = simplify(y.subs(soln))
    print 'y(x1 + x2) / 2 ->\n'
    pprint(y_est1)

    soln.pop(x)

    soln[x] = (x2 + x3) / 2
    y_est2 = simplify(y.subs(soln))
    print '\ny(x1 + x2) / 2 ->\n'
    pprint(y_est2)

    pass  # return nothing


def p1_4(part=None):
    """
    Complete solution to problem 1.4

    Parameters
    ----------
    part: str, optional(default=None)
        The part number you would like evaluated. If this is left blank
        the default value of None is used and the entire problem will be
        solved.

    Returns
    -------
    i-dont-know-yet

    TODO: Call centered difference formula for derivatives.
    """
    x, h = make_grid(0, 5, 100)

    f = lambda x: jn(0, x)  # define function

    y = f(x)  # Evaluate function on grid

    # Get numerical derivatives using routine from tools.py

    yplin = centered_difference(y, 1, h, 'linear')
    ypplin = centered_difference(y, 2, h, 'linear')
    ypquad = centered_difference(y, 1, h, 'quadratic')
    yppquad = centered_difference(y, 2, h, 'quadratic')

    # Calculate real derivatives
    fp = - jn(1, x)
    fpp = 1 / 2 * (- jn(0, x) + jn(2, x))

    abs_err_linp = np.mean(np.abs(yplin - fp))  # linear 1st der. error
    abs_err_linpp = np.mean(np.abs(ypplin - fpp))  # linear 2nd der. error

    abs_err_quadp = np.mean(np.abs(ypquad - fp))  # quad 1st der. error
    abs_err_quadpp = np.mean(np.abs(yppquad - fpp))  # quad 2nd der. error

    print 'Linear first derivative error: %.8e' % (abs_err_linp)
    print 'Linear second derivative error: %.8e' % (abs_err_linpp)
    print 'Quadratic first derivative error: %.8e' % (abs_err_quadp)
    print 'Quadratic second derivative error: %.8e' % (abs_err_quadpp)

    plt.figure()
    plt.subplot(211)
    plt.plot(x, fp, x, yplin, x, ypquad)
    plt.title('First derivatives')
    plt.legend(('Real Derivative',
               'Linear Extrapolation',
               'quadratic Extrapolation'),
                loc=0)

    plt.subplot(212)
    plt.plot(x, fpp, x, ypplin, x, yppquad)
    plt.title('Second derivatives')
    plt.legend(('Real Derivative',
               'Linear Extrapolation',
               'quadratic Extrapolation'),
                loc=0)
    plt.draw()

    pass  # return nothing


def p1_5(part=None):
    """
    Complete solution to problem 1.5

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
    f, fp, fp2, fp3, fp4, h, fplus, fminus = symbols('f, fp, fp2, fp3, fp4, \
                                                     h, fplus, fminus')
    eqns = (Eq(fplus, f + fp * h + fp2 * h ** 2 / 2 + \
                      fp3 * h ** 3 / 6 + fp4 * h ** 4 / 24),
            Eq(fminus, f - fp * h + fp2 * h ** 2 / 2 - \
                       fp3 * h ** 3 / 6 + fp4 * h ** 4 / 24))
    soln = solve(eqns, fp, fp2)
    pprint(soln)

    pass  # return nothing


def p1_6(part=None):
    """
    Complete solution to problem 1.6

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
    h1 = 0.1
    h2 = 0.01
    h3 = 0.001
    h = np.array([h1, h2, h3])

    x = 0
    errs = np.zeros((3, 3))
    forward_first = 1 - ((exp(x + h) - exp(x)) / h)
    center_first = 1 - ((exp(x + h) - exp(x - h)) / (2 * h))
    center_second = 1 - ((exp(x + h) - 2 * exp(x) + exp(x - h)) / (h ** 2))

    errs[0, :] = forward_first
    errs[1, :] = center_first
    errs[2, :] = center_second

    errors = pd.DataFrame(errs, columns=['h1', 'h2', 'h3'],
                index=['Forward first', 'Centered first', 'Centered Second'])

    print 'Errors:'
    print errors

    pass  # return nothing


def p1_7(part=None):
    """
    Complete solution to problem 1.7.

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
    x, h = make_grid(0, 5, 1000, 'cell_edge')  # cell-edge data

    f = np.cos(x)
    y = np.cos(x) + .001 * np.random.rand(x.size)
    yp = np.zeros(y.shape)  # Pre-allocate memory for yp and ypp
    ypp = np.zeros(y.shape)

    # Get centered estimate for yp(p)
    yp = centered_difference(y, 1, h, 'linear')
    ypp = centered_difference(y, 2, h, 'linear')

    # Get real derivatives
    fp = -np.sin(x)
    fpp = -np.cos(x)

    # Plot f, y, fp, yp
    plt.figure()
    plt.subplot(211)
    plt.plot(x, f, 'b', x, y, 'g')
    plt.legend(('Real', 'Noisy'), loc=0)
    plt.title('f(x)')

    plt.subplot(212)
    plt.plot(x, fp, 'k', x, yp, 'r')
    plt.legend(('Real', 'Estimated'), loc=0)
    plt.title('fp(x)')
    plt.draw()

    pass  # return nothing
