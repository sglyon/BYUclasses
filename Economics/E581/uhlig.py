"""
Created October 15, 2012

Author: Spencer Lyon

Uhlig's toolkit in python.

This file contains the tools to solve for decision rules in a linear
    system which is assumed ot be of the form

0 = AA x(t) + BB x(t-1) + CC y(t) + DD z(t)
0 = E_t [ FF x(t+1) + GG x(t) + HH x(t-1) +
          JJ y(t+1) + KK y(t) + LL z(t+1) + MM z(t)]

Where x(j) is the endogenous state vector in period j,
      y(j) is the endogenous non-state vector in period j,
      z(j) is the exogenous state vector in period j,

This file solve sfor the equilibirum law of motion:
    x(t) = PP x(t - 1) + QQ z(t)
    y(t) = RR y(t - 1) + SS z(t)

References:
    [1]Source: H. Uhlig (1995) "A Toolkit for Solving Nonlinear Dynamic
               Stochastic Models Easily," Discussion Paper, Institute
               for Empirical Macroeconomis, Federal Reserve Bank of
               Minneapolis #101 or Tilburg University, CentER DP 9597.

Dependencies:
    numpy
    scipy (version 0.11.0 or greater if you use qz.)
    RBC_numeric derivatives
"""
import numpy as np
import scipy as sp
from numpy import concatenate as ccat
from scipy.linalg import qz, pinv2
from numpy.linalg import matrix_rank


def null(A, eps=1e-15):
    u, s, vh = scipy.linalg.svd(A)
    null_mask = (s <= eps)
    null_space = scipy.compress(null_mask, vh, axis=0)
    return scipy.transpose(null_space)

AA, BB, CC, DD, FF, GG, HH, JJ, KK, LL, MM, NN = num_der()

q_expect_equ, m_states = FF.shape
l_equ, n_endog = CC.shape

k_exog = min(NN.shape)
sum_imag = np.sum(np.abs(np.imag(AA) + np.imag(BB) + np.imag(CC)))
sum_abs = np.sum(np.abs(AA + BB + CC))

if sum_imag / sum_abs > 0.000001:
    print str('I hate to point this out to you, but some of your matrices ' +
        'contain complex numbers, which does not make much sense. You should' +
        ' check your steady state parameters and calculations.I will proceed' +
        ' anyhow, but you will probably get nonsense.')

if matrix_rank(CC) < n_endog:
    print 'Rank(CC) needs to be at least n! CAnnot solve for PP.'

else:
    if l_equ == 0:
        CC_plus = pinv2(CC)
        CC_0 = null(CC.T)
        Psi_mat = FF
        Gamma_mat = GG
        Theta_mat = - HH
        Xi_mat =
def solve