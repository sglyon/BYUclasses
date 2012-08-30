"""
Created August 29, 2012

Author: Spencer Lyon

Economics 581 HW1: Solow Growth Model
"""
from __future__ import division
import numpy as np


##-----------------------------Define Parameters-----------------------------##
a_bar = 1.
g = 0.025
n = 0.01
delta = 0.1
theta = 0.33
sigma = 0.1
rho = 0.9
omega = (0.0004) ** (1./2)
kbar = (sigma / (delta + n + g)) ** (1 / (1 - theta))

T = 120  # sample size



epsilon = np.random.normal(0, omega, size=T)

A = np.zeros(T)
a = np.zeros(T)
k = np.zeros(T)
y = np.zeros(T)
i = np.zeros(T)
c = np.zeros(T)

k[0] = kbar
y[0] = k[0] ** theta * np.exp((1 - theta) * a[0])
i[0] = k[0]
c[0] = y[0] - i[0]

for t in range(1, T):
    a[t] = rho * a[t-1] + epsilon[t]
    A[t] = a_bar * np.exp(g ** t + a[t])
    k[t] = (k[t-1] * (1 - delta) + sigma * y[t-1]) / (1 + g + n)
    y[t] = k[t] ** theta * np.exp((1 - theta) * a[t])
    i[t] = k[t] - (1 - delta) * k[t-1]
    c[t] = y[t] - i[t]



