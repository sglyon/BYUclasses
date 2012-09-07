"""
Created September 4, 2012

Author: Spencer Lyon

Problem 2.23 in Gregory. For HW 3 Physics 321
"""
from __future__ import division
import numpy as np
from numpy import cos, sin, sqrt
from sympy import lambdify, var
import pylab as pl

var('b c th')

# pos = b * cos(th) + c(1 - (b * sin(th) /c ) ** 2) ** (1./2)

# exact_func = pos.diff(th, 2)

def ex_func(b, c, th):
	a = -b**4*sin(th)**2*cos(th)**2/((-b**2*sin(th)**2/c**2 + 1)**(3/2)*c**3)\
	 + b**2*sin(th)**2/(sqrt(-b**2*sin(th)**2/c**2 + 1)*c) - b**2*cos(th)**2\
	 /(sqrt(-b**2*sin(th)**2/c**2 + 1)*c) - b*cos(th)
	return a

approx_func = lambda b, c, th: - b * np.cos(th) - b ** 2/c * np.cos(2 * th)	

thetas = np.linspace(0, 4 * np.pi, 500)


fig = pl.figure()
ax1 = fig.add_subplot(131)
ax1.plot(approx_func(.1, 1, thetas), label="approx")
ax1.plot(ex_func(.1, 1, thetas), label= "exact")
pl.title('b = .1, c = 1')
pl.legend(loc=8)

ax2 = fig.add_subplot(132)
ax2.plot(approx_func(.25, 1, thetas), label="approx")
ax2.plot(ex_func(.1, 1, thetas), label= "exact")
pl.title('b = .25, c = 1')
pl.legend(loc=8)

ax3 = fig.add_subplot(133)
ax3.plot(approx_func(.6, 1, thetas), label="approx")
ax3.plot(ex_func(.1, 1, thetas), label= "exact")
pl.title('b = .6, c = 1')
pl.legend(loc=8)
pl.show()

fig.savefig('Problem 2-23.png')