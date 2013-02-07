"""
Created Jan 16, 2013

Author: Spencer Lyon

Utility functions that I used a lot in physics 430

TODO: implement whos function that uses pandas to print key info about data.
"""
from __future__ import division
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import scipy.linalg as la


def make_grid(xmin, xmax, n, grid_type='cell_edge'):
    """
    Creates grid with n points from xmin to xmax. The type of grid is
    determined by the input parameter grid_type.

    Parameters
    ----------
    xmin: scalar, float
        The left edge or minimum for the grid.

    xmax: scalar, float
        The right edge or maximum for the grid.

    n: int
        The number of data points.

    Returns
    -------
    grid: array_like, dtype=float
        The array of evenly spaced data of grid_type type.

    h: float
        The scalar representing the step size.
    """
    if grid_type == 'cell_edge':
        grid = np.linspace(xmin, xmax, n)
        h = grid[1] - grid[0]

    elif grid_type == 'cell_center':
        h = (xmax - xmin) / n
        grid = np.arange(xmin + h / 2, xmax - h / 2 + h, h)

    elif grid_type == 'cell_center_ghost':
        h = (xmax - xmin) / n
        grid = np.arange(xmin - h / 2, xmax + h, h)

    else:
        errstr = "Function not implemented for grid_type != "
        errstr += '(cell_edge, or cell_center or cell_center_ghost)'
        raise ValueError(errstr)

    return grid, h


def centered_difference(data, order, h, extrap_type=None):
    """
    Compute a nth order numerical derivative given an array of data

    Parameters
    ----------
    data: array_like, dtype=float
        An array of data to be used in calculating the derivative.

    order: int
        An integer specifying which derivative should be computed.
        For example, if order=1, the first derivative will be computed.
        Acceptable values are 1 or 2.

    h: float
        The step size for the independent variable used to create the
        input data for this function.

    extrap_type: str, optional(default=None)
        A string representing the type of extrapolation to be used in
        computing the end-points. The default is None and unless changed
        the first and last value of the returned array will be zero.
        Acceptable values for extrap_type are 'linear' or 'quadratic'.

    Returns
    -------
    der: array_like, dtype=float, shape=data.shape
        An array of the same shape as data that contains the numerical
        derivative.

    Notes
    -----
    This function assumes equal spacing for the independent variable
    used to create the parameter data.
    """
    der = np.zeros(data.shape)

    if order == 1:
        # Baseline interior points
        der[1:-1] = (data[2:] - data[:-2]) / (2 * h)

        if extrap_type == 'linear':
            der[0] = 2 * der[1] - der[2]
            der[-1] = 2 * der[-2] - der[-3]

        elif extrap_type == 'quadratic':
            der[0] = 3 * der[1] - 3 * der[2] + der[3]
            der[-1] = 3 * der[-2] - 3 * der[-3] + der[-4]

        elif extrap_type == None:
            pass

        else:
            errstr_extrap = "Function not implemented for extrap_type != "
            errstr_extrap += "('linear' or 'quadratic') "
            raise ValueError(errstr_extrap)

    elif order == 2:
        # Baseline interior points
        der[1:-1] = (data[2:] - 2 * data[1:-1] + data[:-2]) / (h ** 2)

        if extrap_type == 'linear':
            der[0] = 2 * der[1] - der[2]
            der[-1] = 2 * der[-2] - der[-3]

        elif extrap_type == 'quadratic':
            der[0] = 3 * der[1] - 3 * der[2] + der[3]
            der[-1] = 3 * der[-2] - 3 * der[-3] + der[-4]

        elif extrap_type == None:
            pass

        else:
            errstr_extrap = "Function not implemented for extrap_type != "
            errstr_extrap += "('linear' or 'quadratic') "
            raise ValueError(errstr_extrap)

    else:
        # Only have 1st and 2nd derivatives so far
        raise ValueError('Function not implemented for order != (1 or 2)')

    return der


def solve_plot_eig(A, B, T, mu, x=None):
    """
    Routine similar to the function eigen.m from MatLab. This will solve
    the genralized eigenvlaue problem

        Av = lamb B v,

    After computing the solution it will convert the lamb into
    frequencies (omega), sort the eigenvalues / eigen vectors, and plot
    the solutions.

    Parameters
    ----------
    A: array-like, dtype=float
        The matrix A in the generalized eigenvalue problem above

    B: array-like, dtype=float
        The matrix B in the genearalized eigenvalue problem above.

    T: scalar, dype=float
        The tension in the string for this problem

    mu: scalar, dtype=float
        The linear mass density of the string

    x: array-like, dtype=float, optional(default=None)
        The vector of dependent variable values, equally spaced. This
        is only used in making the plot labels correct.

    lb: scalar, dtype=float
        The lower bound on the dependent variable values

    ub: scalar, dtype=float
        The upper bound on the dependent variable values
    Returns
    -------
    Nothing, just plots the eigenmodes.
    """
    plt.ion()

    # Solve genearalized eigenvalue problem (eigen.m for python)
    lamb, v1 = la.eig(A, B)

    w2raw = - (T / mu) * lamb  # convert lambda to w ** 2
    w2, k = [np.sort(w2raw), np.argsort(w2raw)]  # sort and get indices
    contin = 1

    for i in range(w2.size):
        if contin == 1:
            t = r'$\omega^2$ = %.3f, $\omega$ = %.3f' \
                % (w2[i], np.sqrt(np.abs(w2[i])))
            gn = v1[:, k[i]]
            plt.figure()
            if x:
                plt.plot(x, gn, 'r.')
            else:
                plt.plot(gn)
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


def stlf():
    """
    Python equivalent of the code found in stlf.m
    """
    import matplotlib.pyplot as plt
    # Staggered Leapfrog Script Template

    # Set the values for parameters
    c = 2  # wave speed

    # build a cell-centered grid with N=200 cells
    # on the interval x=0 to x=L, with L=1
    L = 1
    x = make_grid(0, L, 200, grid_type='cell_center_ghost')

    # define the initial displacement and velocity vs. x
    y = np.exp(- (x - L / 2) ** 2 * 160 / L ** 2) - \
        np.exp(- (0 - L / 2) ** 2 * 160 / L ** 2)
    vy = np.zeros_like(x)

    # Choose a time step (Suggest that it is no larger than taulim)
    taulim = h / c
    print(' Courant time step limit %f \n' % taulim)
    tau = raw_input('Enter the time step: ')

    # Get the initial value of yold from the initial y and vy

    # Apply the boundary conditions for yold(1) and yold(N+2)

    # plot the initial conditions and pause to look at them
    plt.figure()
    plt.subplot(211)
    plt.plot(x, y)
    plt.xlabel('x')
    plt.ylabel('y(x,0)')
    plt.title('Initial Displacement')
    plt.subplot(212)
    plt.plot(x, vy)
    plt.xlabel('x')
    plt.ylabel('v_y(x,0)')
    plt.title('Initial Velocity')
    # pause  TODO: fix this pause call

    # Choose how long to run and when to plot
    tfinal = raw_input(' Enter tfinal:')
    skip = raw_input(' Enter # of steps to skip between plots (faster):')
    nsteps = tfinal / tau

    # here is the loop that steps the solution along

    plt.figure()  # open a new frame for the animation
    for n in range(nsteps):
        time = n * tau  # compute the time

        # Use leapfrog and the boundary conditions to load ynew with y
        # at the next time step using y and yold, i.e., ynew(2:N+1)=...
        # Be sure to use colon commands so it will run fast.

        #update yold and y
        yold = yy = ynew

    # make plots every skip time steps
        if n % skip == 0:
            plt.plot(x, y, 'b-')
            plt.xlabel('x')
            plt.ylabel('y')
            plt.title('Staggered Leapfrog Wave: time %.2f' % time)
            plt.axis([x.min(), x.max(), -2, 2])
            pause(.1)  # TODO: figure out how to use this
