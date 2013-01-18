"""
Solve the boundary value problem

y''(x) + sin(y(x)) = 1; y(0) = 0, y(3) = 0

or we could say

y'(x) = v
v'(x) = 1 - sin(y)
"""

import scikits.bvp_solver as bvp
import numpy as np
import pylab as pl

y0 = 0
y3 = 0


def function(a, x):
    return np.array([x[1], 1 - np.sin(x[0])])


def bcs(left, right):
    return (np.array([left[0] - y0]), np.array([right[0] - y3]))

problem = bvp.ProblemDefinition(num_ODE=2,
                                  num_parameters=0,
                                  num_left_boundary_conditions=1,
                                  boundary_points=(0, 3),
                                  function=function,
                                  boundary_conditions=bcs)

solution = bvp.solve(problem, solution_guess=(0, 0))

xx = np.linspace(0, 3, 100)
yy = solution(xx)

pl.plot(xx, yy[0, :])
pl.show()

