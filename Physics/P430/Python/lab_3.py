"""
Created Jan 18, 2013

Author: Spencer Lyon

Lab 3 for Physics 430
"""
import matplotlib.pyplot as plt
import scipy.linalg as la
import pandas as pd
from __future__ import division
import numpy as np
from tools import make_grid


def p3_1(part=None):
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
    # Define parameters
    mu = 0.0003
    T = 127
    L = 1.2
    omega = 400

    # Build grid
    n = 100
    xmin = 0
    xmax = L
    x, h = make_grid(xmin, xmax, h, 'cell_edge')

    def f_x(x):
        """
        implement the piecewise function in equation 3.4
        """
        x = np.ascontiguousarray(x)
        ret = np.zeros(x.size)
        ret[0.8 <= x < 1] = 0.73

        return ret
