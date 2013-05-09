from __future__ import division
import numpy as np


def rotate(theta, u):
    cos = np.cos
    sin = np.sin
    row_1 = np.array([cos(theta) + u[0] ** 2 * (1 - cos(theta)),
                      u[0]*u[1] * (1 - cos(theta) - u[2] * sin(theta)),
                      u[1]*u[2]*(1 - cos(theta) + u[1] * sin(theta))])

    row_2 = np.array([u[1]*u[0]*(1 - cos(theta) + u[2] * sin(theta)),
                      cos(theta) + u[1]**2 * (1 - cos(theta)),
                      u[1]*u[2]*(1 - cos(theta)) - u[0] * sin(theta)])

    row_3 = np.array([u[2]*u[0]*(1 - cos(theta) - u[1] * sin(theta)),
                      u[2]*u[1]*(1 - cos(theta)) + u[0] * sin(theta),
                      cos(theta) + u[2]**2 * (1 - cos(theta))])

    return np.row_stack([row_1, row_2, row_3])


def rotate_2(theta, u):
    """
    Determine the rotation matrix for rotating theta radians about the
    axis u.

    Parameters
    ----------
    theta : float
        The degree (in radians) that we are rotating.

    u : array_like, size=3, dtype=float
        The 3-d vector representing the axis of rotation.

    Returns
    -------
    R : array_like, shape=(3, 3), dtype=float
        The rotation matrix representing the rotation.

    References
    ----------
    http://en.wikipedia.org/wiki/Rotation_matrix
    """
    el_1 = np.eye(3) * np.cos(theta)
    el_2 = np.sin(theta) * mat_cross(u)
    el_3 = (1 - np.cos(theta)) * np.outer(u, u)

    return el_1 + el_2 + el_3


def mat_cross(x):
    return np.array([[0, -x[2], x[1]],
                    [x[2], 0, -x[0]],
                    [-x[1], x[0], 0]])
