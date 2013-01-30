"""
Created Jan 18, 2013

Author: Spencer Lyon

Lab 3 for Physics 430
"""
from __future__ import division
import matplotlib.pyplot as plt
import scipy.linalg as la
import pandas as pd
import numpy as np
from tools import make_grid

plt.ion()


def p3_1(part=None, no_plot=False):
    """
    Complete solution to problem 3.1

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
    def f_x(x):
        """
        implement the piecewise function in equation 3.4
        """
        x = np.ascontiguousarray(x)
        ret = np.zeros(x.size)
        for i in range(x.size):
            if 0.8 <= x[i] and x[i] < 1:
                ret[i] = 0.73

        return ret

    # Define parameters
    mu = 0.003
    T = 127
    L = 1.2
    omega = 400

    # Build grid
    n = 100
    xmin = 0
    xmax = L
    x, h = make_grid(xmin, xmax, n, 'cell_edge')

    # Get data for function
    y = f_x(x)

    # Create the matrix representing A in the matrix equation for the BVP
    A = np.zeros((n, n))  # Preallocate memory for A
    A[0, 0] = 1  # Set first row of A
    A[-1, -1] = 1  # Set last row of A

    for i in xrange(1, n - 1):  # Fill in all other rows of A
        A[i, i - 1: i + 2] = [T / (h ** 2),
                              - 2 * T / (h ** 2) + mu * omega ** 2,
                              T / (h ** 2)]

    # Create the vector representing x in the matrix equation for the BVP
    x_approx = np.zeros(n)  # Preallocate memory for x_approx
    x_approx[0] = 0  # Set first row of x_approx
    x_approx[-1] = 0  # Set last row of x_approx
    x_approx[1:-1] = -f_x(x[1:-1])  # Fill in all other rows of x_approx

    # Approximate y
    y_approx = la.solve(A, x_approx)

    if no_plot == False:
        plt.figure()
        plt.plot(x, y_approx, 'b--')
        plt.title('Solution to part a with n = 100')
        plt.draw()

    # ------------------------------- Part b ------------------------------- #

    omega_arr = np.linspace(400, 1200, 100)
    iteration_data = pd.DataFrame(index=range(1, 101))
    maxes = np.zeros(100)
    iteration_data.index.name = 'x'

    for i in range(100):
        w = omega_arr[i]
        A2 = np.zeros((n, n))  # Preallocate memory for A2
        A2[0, 0] = 1  # Set first row of A2
        A2[-1, -1] = 1  # Set last row of A2

        for i in xrange(1, n - 1):  # Fill in all other rows of A2
            A2[i, i - 1: i + 2] = [T / (h ** 2),
                                  - 2 * T / (h ** 2) + mu * w ** 2,
                                  T / (h ** 2)]

        y_approx2 = la.solve(A2, x_approx)
        iteration_data[w] = y_approx2

    if no_plot == False:
        plt.figure()
        iteration_data.max(0).plot()
        plt.title('Solution to part b')
        plt.draw()

    iteration_data.columns.name = 'Omega'

    return iteration_data


def p3_2(part=None):
    """
    Complete solution to problem 3.2

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
    # ------------------------------- Part a ------------------------------- #
    mu = 0.003
    T = 127
    L = 1.2
    omega = 400

    # Build grid
    n = 100
    xmin = 0
    xmax = L
    x, h = make_grid(xmin, xmax, n, 'cell_edge')

    # Create A matrix
    A = np.zeros((n, n))
    A[0, 0] = 1
    A[-1, -1] = 1

    for i in xrange(1, n - 1):  # Fill in all other rows of A
        A[i, i - 1: i + 2] = [1 / (h ** 2),
                              - 2 / (h ** 2),
                              1 / (h ** 2)]

    # Create B matrix
    B = np.eye(n)
    B[0, 0] = 0
    B[-1, -1] = 0

    # Solve genearalized eigenvalue problem (eigen.m for python)
    lamb, v1 = la.eig(A, B)

    w2raw = - (T / mu) * lamb  # convert lambda to w ** 2
    w2, k = [np.sort(w2raw), np.argsort(w2raw)]  # sort and get indices
    contin = 1

    for i in range(n):
        if contin == 1:
            t = r'$\omega^2$ = %.3f, $\omega$ = %.3f' \
                % (w2[i], np.sqrt(np.abs(w2[i])))
            gn = v1[:, k[i]]
            w = (i + 1) * np.pi / L
            exact = np.sin(w * x)
            plt.figure()
            plt.plot(x, gn, 'r.', x, exact, 'b-')
            plt.title(t)
            plt.xlabel('x')
            plt.ylabel('g(n, x)')
            plt.draw()
            ans = raw_input('Continue? Enter 0 if no, leave blank if yes ')
            try:
                contin = int(ans)
                plt.close('all')
            except ValueError:
                contin = 1
        else:
            plt.close('all')
            break

    # ------------------------------- Part b ------------------------------- #
    # Get the first two frequencies
    first_w = np.sqrt(w2[0]).real
    second_w = np.sqrt(w2[1]).real

    # Use the iteration_data object created in 3.1.b
    iteration_data = p3_1(no_plot=True)
    maxes = iteration_data.max(0)
    where_1 = np.where(maxes.index > first_w)[0][0]
    where_2 = np.where(maxes.index > second_w)[0][0]

    plt.figure(figsize=(14, 5))
    plt.subplot(121)
    plt.plot(maxes.index[where_1 - 5: where_1 + 5], maxes.ix[where_1 - 5: where_1 + 5])
    plt.title(r'Around $\omega$ = %.3f' % first_w)
    plt.xlabel(r'$\omega$')
    plt.ylabel('Max Amplitude')

    plt.subplot(122)
    plt.plot(maxes.index[where_2 - 5: where_2 + 5], maxes.ix[where_2 - 5: where_2 + 5])
    plt.title(r'Around $\omega$ = %.3f' % second_w)
    plt.xlabel(r'$\omega$')
    plt.ylabel('Max Amplitude')
    plt.show()


def p3_3(part=None):
    """
    Complete solution to problem 3.3

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
    # ------------------------------- Part a ------------------------------- #
    mu = 0.003
    T = 127
    L = 1.2
    omega = 400

    # Build grid
    n = 100
    xmin = 0
    xmax = L
    x, h = make_grid(xmin, xmax, n, 'cell_edge')

    # Create A matrix
    A = np.zeros((n, n))
    A[0, 0] = 1
    A[-1, -3:] = [1 / (2 * h), -2 / h, 3 / (2 * h)]

    for i in xrange(1, n - 1):  # Fill in all other rows of A
        A[i, i - 1: i + 2] = [1 / (h ** 2),
                              - 2 / (h ** 2),
                              1 / (h ** 2)]

    # Create B matrix
    B = np.eye(n)
    B[0, 0] = 0
    B[-1, -1] = 0

    # Solve genearalized eigenvalue problem (eigen.m for python)
    lamb, v1 = la.eig(A, B)

    w2raw = - (T / mu) * lamb  # convert lambda to w ** 2
    w2, k = [np.sort(w2raw), np.argsort(w2raw)]  # sort and get indices
    contin = 1

    for i in range(n):
        if contin == 1:
            t = r'$\omega^2$ = %.3f, $\omega$ = %.3f' \
                % (w2[i], np.sqrt(np.abs(w2[i])))
            gn = v1[:, k[i]]
            plt.figure()
            plt.axis([0, L, -1, 1])
            plt.plot(x, gn, 'r.')
            plt.title(t)
            plt.xlabel('x')
            plt.ylabel('g(n, x)')
            plt.draw()
            ans = raw_input('Continue? Enter 0 if no, leave blank if yes ')
            try:
                contin = int(ans)
                plt.close('all')
            except ValueError:
                contin = 1
        else:
            plt.close('all')
            break

    # ------------------------------- Part b ------------------------------- #

    # Create A matrix
    A2 = np.zeros((n, n))
    A2[0, 0] = 1
    A2[-1, -3:] = [1 / (2 * h), -2 / h, 3 / (2 * h) - 2]

    for i in xrange(1, n - 1):  # Fill in all other rows of A2
        A2[i, i - 1: i + 2] = [1 / (h ** 2),
                              - 2 / (h ** 2),
                              1 / (h ** 2)]

    # Create B matrix
    B = np.eye(n)
    B[0, 0] = 0
    B[-1, -1] = 0

    # Solve genearalized eigenvalue problem (eigen.m for python)
    lamb2, v12 = la.eig(A2, B)

    w2raw2 = - (T / mu) * lamb2  # convert lambda to w ** 2
    w22, k2 = [np.sort(w2raw2), np.argsort(w2raw2)]  # sort and get indices
    contin = 1

    for i in range(n):
        if contin == 1:
            t = r'$\omega^2$ = %.3f, $\omega$ = %.3f' \
                % (w22[i], np.sqrt(np.abs(w22[i])))
            gn = v12[:, k2[i]]
            plt.figure()
            plt.axis([0, L, -1, 1])
            plt.plot(x, gn, 'r.')
            plt.title(t)
            plt.xlabel('x')
            plt.ylabel('g(n, x)')
            plt.draw()
            ans = raw_input('Continue? Enter 0 if no, leave blank if yes ')
            try:
                contin = int(ans)
                plt.close('all')
            except ValueError:
                contin = 1
        else:
            plt.close('all')
            break


if __name__ == '__main__':
    pass
