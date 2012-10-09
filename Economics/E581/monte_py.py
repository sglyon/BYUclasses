import numpy as np


def monteCarlo(sims, pers):
    """
    static python implementation of monte carlo simulation"
    """
    g2 = np.array([0.01, -0.03])
    g3 = np.array([0.02, 0.01, -0.03])
    marcov2 = np.array([[0.9, 0.1],
                        [0.5, 0.5]]).cumsum(1)

    marcov3 = np.array([[0.5, 0.45, 0.05],
                        [0.05, 0.85, 0.10],
                        [0.25, 0.25, 0.5]]).cumsum(1)

    y2 = np.zeros((sims, pers))
    y3 = np.zeros((sims, pers))
    for sim in range(sims):
        s2 = 0
        s3 = 0
        epsilon = np.random.normal(0, 0.02, pers)  # generate random shocks

        for t in range(1, pers):
            r_num = np.random.rand()
            y2[sim, t] = g2[s2] + y2[sim, t - 1] + epsilon[t]
            y3[sim, t] = g3[s3] + y3[sim, t - 1] + epsilon[t]
            s2 = np.where(marcov2[s2, :] > r_num)[0][0]
            s3 = np.where(marcov3[s3, :] > r_num)[0][0]

    return [y2, y3]
