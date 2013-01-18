"""
Solve the boundary value problem

y''(x) + 9 * y(x) = sin(x); y(0) = 0, y(2) = 1

or we could say

y'(x) = v
v'(x) = sin(x) - 9 * y(x)
"""

import scikits.bvp_solver as bvp
import numpy as np
import pylab as pl

y0 = 0
y2 = 1


def function(a, x):
    return np.array([x[1], np.sin(a) - 9 * x[0]])


def bcs(left, right):
    return (np.array([left[0] - y0]), np.array([right[0] - y2]))

problem = bvp.ProblemDefinition(num_ODE=2,
                                  num_parameters=0,
                                  num_left_boundary_conditions=1,
                                  boundary_points=(0, 2),
                                  function=function,
                                  boundary_conditions=bcs)

solution = bvp.solve(problem, solution_guess=(0, 0))

xx = np.linspace(0, 2, 100)
yy = solution(xx)

pl.plot(xx, yy.T)
pl.show()

