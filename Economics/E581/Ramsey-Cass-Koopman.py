"""
Created August 29, 2012

Author: Spencer Lyon

Economics 581 HW2: Ramsy Cass Koopman's Model
"""
from __future__ import division
import numpy as np
from scipy.optimize import fmin
import pylab as pl

## Intantiate parameters and solve for steady state k, c
g, n, delta, theta = [0.025, 0.01, 0.1, 0.33]
gammas = gamma1, gamma2, gamma3 = np.array([1.0, 2.5, 1.0])
rhos = rho1, rho2, rho3 = np.array([0.05, 0.05, 0.1])

kbars = (1. / theta * ((1 + rhos) * (1 + g) ** gammas - 1 + delta)) ** \
                                (1. / (theta - 1))
cbars = kbars ** theta - kbars * (g + n + g * n + delta)


def solve_with_params(param_set, k_start):
    """
    Solves the time path iteration problem with a given set of parameter
    values and a starting point for k.

    Parameters
    ----------
    param_set: number, int
        An integer saying which parameter set you want. Only values
        between 0 - 2 will work.

    k_start: number, int
        An integer stating which starting value for k you want to use.
        Only integers 1 or 2 will work. If 1 is passed k will start 30%
        below the steady state, if 2 is passed it will start at 50%
        above the SS
    """
    gamma = gammas[param_set]
    rho = rhos[param_set]
    if k_start == 1:
        k_init = (kbars * 0.7)[param_set]
    elif k_start == 2:
        k_init = (kbars * 1.5)[param_set]

    ktp1 = lambda kt, ct: ((kt ** theta) + (1 - delta) * kt - ct) / \
                            ((1 + g) * (1 + n))
    ctp1 = lambda kt_1, ct: (((1 - delta + theta * kt_1 ** (theta - 1)) / \
                         ((1 + rho) * (1 + g) ** gamma)) ** (1 / gamma)) * ct

    c_guess = 0.8
    if param_set == 2 and k_start ==1:
        c_guess = 0.5

    def opt_func(c_init):
        ct = np.zeros(50)
        kt = np.zeros(50)
        ct[0] = c_init
        kt[0] = k_init
        for t in range(1, 50):
            kt[t] = ktp1(kt[t - 1], ct[t - 1])
            ct[t] = ctp1(kt[t], ct[t - 1])
        diff = kbars[param_set] - kt[-1]
        return np.abs(diff)

    c_init = fmin(opt_func, c_guess)

    c = np.zeros(50)
    k = np.zeros(50)

    c[0] = c_init
    k[0] = k_init

    for t in range(1, 50):
        k[t] = ktp1(k[t - 1], c[t - 1])
        c[t] = ctp1(k[t], c[t - 1])

    r = theta * k ** (theta - 1)
    w = (1 - theta) * k ** (theta)
    y = k ** theta

    string_title = [None, '30% below', '50% above']
    title = 'Parameter set %s, k starts %s the ss' % (str(param_set + 1),
                                                        string_title[k_start])

    pl.plot(c, 'r-', label='c', linewidth=2)
    pl.plot(k, 'b-', label='k', linewidth=2)
    pl.plot(r, 'g-', label='r', linewidth=2)
    pl.plot(w, 'k-', label='w', linewidth=2)
    pl.plot(y, 'y-', label='y', linewidth=2)
    pl.legend(loc=0)
    pl.title(title)
    pl.savefig(str('RCK P -' + str(param_set) + ' S -' + str(k_start)))
    pl.show()

