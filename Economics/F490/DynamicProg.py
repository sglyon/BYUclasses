"""
Created __, 2012

Author: Spencer Lyon
"""
import numpy as np
from numpy.matlib import repmat
import scipy as sp
import matplotlib.pyplot as plt


# Define variables and parameters
beta = .95
r = .03
S = np.arange(0,1.25,.25)
P = np.array([[.4, .3, .15, .12, .03],
              [.18, .42, .20, .15, .05],
              [ .1, .15, .5, .15, .1],
              [.05, .15, .2, .42, .18],
              [.03, .12, .15, .3, .4]])
gamma = 3
A = np.arange(.0001, 3.0001 + .005, .005)
a = A.size
n_S = S.size
sa = a * n_S
v_0 = np.mat(sp.randn(a, n_S))
tol = .001


# Define funcitons
u = lambda x: x**(1-gamma)/(1-gamma)
c_t = lambda a_t, a_t1, s_t: (1 + r) * a_t + s_t - a_t1

util = np.ones((5, a, a))

for i in range(a):
    for j in range(a):
        for mat in range(5):
            if c_t(A(j), A(i), S(mat)) >= 0:
                util[mat, i, j] = u(c_t(A(j), A(i), S(mat)))
            else:
                util[mat, i, j] = - np.inf

r = np.zeros((5, a, 1))

# the matlab command for max is done with max(x, axis=1), argmax(x, axis=1)

testObj = util + beta * repmat(v_0 * 3)
