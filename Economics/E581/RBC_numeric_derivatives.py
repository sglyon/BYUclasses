from __future__ import division
import numpy as np

def numericalDerivatives(func, ssVals, nx, ny, nz):
    """
    This file takes a vector function (Euler Equations), the values of
    the states from ssVals, number of endog state vars, number of jump
    vars and the number of exogenous state variables.  It creates
    big which is a matrix used to calculate the matrices needed to solve
    matrix quadratic.  Take numerical derivatives and perturbates each
    x, y, and z val by epsilon
    """
    #We make ssVals an array to simplify life.  Epsilon is amount we change by
    #    to take numerical derivatives, and T0 is an error term.
    ssVals = np.array(ssVals).squeeze()
    epsilon = .000001
    T0 = np.absolute(func(ssVals))

    #Length is # of variables being used and height is # of Euler Equations
    length = 3 * nx + 2 * (ny + nz)
    height = ne  # TODO: What is ne?

    #Matrix of values. We change the ith ith value so we perturb each set of
    #    variables by epsilon.
    dev = np.tile(ssVals.reshape((ssVals.size, 1)), 1, length)

    for i in range(0, length):
        dev[i, i] += epsilon

    #Initialize bigmat which we will use to find Uhlig matrices
    bigMat = np.zeros((height, length))

    #For loop calculates how the values change as we shock each of the ss
    #   vals by epsilon
    for i in range(0, length):
        if i < (3 * nx + 2 * ny):
            bigMat[:, i] = ssVals[i] * (func(dev[:, i]) - T0) / (1.0 + T0)
            #Why are we multiplying by ssVals[i]
        else:
            bigMat[:, i] = (func(dev[:, i]) - T0) / (1.0 + T0)
    bigMat /= epsilon

    print bigMat

    AA = np.array(bigMat[0:ny, nx:2 * nx])
    BB = np.array(bigMat[0:ny, 2 * nx:3 * nx])
    CC = np.array(bigMat[0:ny, 3 * nx + ny:3 * nx + 2 * ny])
    DD = np.array(bigMat[0:ny, 3 * nx + 2 * ny + nz:length])
    FF = np.array(bigMat[ny:ny + nx, 0:nx])
    GG = np.array(bigMat[ny:ny + nx, nx:2 * nx])
    HH = np.array(bigMat[ny:ny + nx, 2 * nx:3 * nx])
    JJ = np.array(bigMat[ny:ny + nx, 3 * nx:3 * nx + ny])
    KK = np.array(bigMat[ny:ny + nx, 3 * nx + ny:3 * nx + 2 * ny])
    LL = np.array(bigMat[ny:ny + nx, 3 * nx + 2 * ny:3 * nx + 2 * ny + nz])
    MM = np.array(bigMat[ny:ny + nx, 3 * nx + 2 * ny + nz:length])
    TT = np.log(1 + T0)

    return [AA, BB, CC, DD, FF, GG, HH, JJ, KK, LL, MM, TT]
