"""
Created Jan 16, 2013

Author: Spencer Lyon

Utility functions that I used a lot in physics 430

TODO: implement whos function that uses pandas to print key info about data.
"""
from __future__ import division
import numpy as np
import pandas as pd


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
        grid = np.arange(xmin - h / 2, xmax + h / 2 + h, h)

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


def whos(var):
    """
    A function comparable to MatLab's whos function.
    """
    the_type = type(var)
