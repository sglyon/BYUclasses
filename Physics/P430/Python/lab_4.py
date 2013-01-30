"""
Created Jan 30, 2013

Author: Spencer Lyon

Lab 4 for Physics 430

Solution to problem 1:
-------- -- ------- --
Newton's second law:  $m \frac{\partial ^2 x}{\partial t^2}
    = \boldsymbol{F}$

In this case $\frac{\partial ^2 x}{\partial t^2} = 0$ and
    $\boldsymbol{F} = T(x) - G(x) = T(x) - \mu g x$

We can now solve for $T(x)$: $m (0) = T(x)  - \mu g x \rightarrow T(x)
    = \mu g x$

If we plug this back into the differential equation we get the following:

$ \mu \frac{\partial ^2 y}{\partial t^2} - \frac{\partial}{\partial x}
    \left(T(x) \frac{\partial y}{\partial x} \right) = \mu
    \frac{\partial ^2 y}{\partial t^2} - \frac{\partial}{\partial x}
    \left(\mu g x \frac{\partial y}{\partial x} \right) =
    \frac{\partial ^2 y}{\partial t^2} - g \frac{\partial}{\partial x}
    \left(x \frac{\partial y}{\partial x} \right) = 0$
"""
from __future__ import division
import numpy as np
import scipy.linalg as la
import matplotlib.pyplot as plt
from tools import make_grid

plt.ion()

def p4_2(part=None):
    """
    Complete solution to problem 4.2

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
    # Define parameters and create grid
    L = 2
    xmin = 0
    xmax = L
    n = 200
    x, h = make_grid(xmin, xmax, n, 'cell_center_ghost')

    # Get number of elements in x (number of rows in A and B)
    n_rows = x.size

    # Create A matrix
    A = np.zeros((n_rows, n_rows))
    A[-1, -2] = 1. / 2  # Equation 4.8
    A[-1, -1] = 1. / 2  # Equation 4.8
    A[0, 0] = -1. / h  # Equation 4.10
    A[0, 1] = 1. / h  # Equation 4.10

    for i in xrange(1, n_rows - 1):  # Fill in all other rows of A
        A[i, i - 1: i + 2] = [1 / (h ** 2) * x[i] + 1 / (2 * h),
                              - 2 / (h ** 2) * x[i],
                              1 / (h ** 2) * x[i] + 1 / (2 * h)]

    # Create B matrix
    B = np.eye(n_rows)
    B[-1, -1] = 0  # Equation 4.8
    B[0, 1] = 1. / 2  # Equation 4.10

    # Solve genearalized eigenvalue problem (eigen.m for python)
    lamb, v1 = la.eig(A, B)

    w2raw = - 9.8 * lamb  # convert lambda to w ** 2.  g = 9.8
    w2, k = [np.sort(w2raw), np.argsort(w2raw)]  # sort and get indices
    contin = 1

    for i in range(n):
        if contin == 1:
            t = r'$\omega^2$ = %.3f, $\omega$ = %.3f' \
                % (w2[i], np.sqrt(np.abs(w2[i])))
            gn = v1[:, k[i]]
            plt.figure()
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
