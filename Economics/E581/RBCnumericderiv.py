"""
Created October 20, 2012

Author: Spencer Lyon

Use a given function to compute numerical derivatives to be used as
inputs in Uhlig's solve routine.
"""
import numpy as np


def rbc_numericderiv(func, theta0, nx, ny, nz):
    """
    Calculate numerical derivative matricies to be used in Uhlig's
    solve routine.

    They are laid out as follows:
        A*x_t + B*x_t-1 + C* y_t + D*z_t = 0

        E{F*x_t+1 + G*x_t + H*x_t-1 + J*y_t+1 + K*y_t + L*z_t+1 K*z_t}=0

    Parameters
    ----------
    func: function
        The name of the function that takes takes in parameter
        values for the model and returns a vector of ny + nx
        dynamic equations evaluated at the input values.
        If the input is the steady state, this function should
        evaluate to zero.

    theta0: array-like, dtype=float
        The ny + nx steady state values

    nx: scalar, int
        The number of elements in X

    ny: scalar, int
        The number of elements in Y

    nz: scalar, int
        the number of elements in Z

    Returns:
    -------
    **: array-like, dtype=float
        The matricies A-K shown above.
    """
    #We make ssVals an array to simplify life.  Epsilon is amount we change by
    #    to take numerical derivatives, and T0 is an error term.
    ssVals = np.array(theta0).squeeze()
    epsilon = .000001
    T0 = np.absolute(func(ssVals))

    #Length is # of variables being used and height is # of Euler Equations
    length = 3 * nx + 2 * (ny + nz)
    height = nx + ny  # TODO: What is ne? Is is nx + ny?

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
