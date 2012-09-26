"""
Created September 21, 2012

Author: Spencer Lyon

Solution to OLG model proposed in Kerk's assignment
"""
from time import time
import numpy as np
import pandas as pd

start_time = time()

beta, theta, gamma, sigma = [.99, .36, 0.6, np.sqrt(0.0004)]

l1 = 60.2
l2 = 4.8
Lt = 65
T = 121

num_sims = 10000

all_moments = np.empty((7, 5, num_sims))


def create_moments(data):
    """
    Creates an array with the desired moments. Specifically the moments are
    mean, std, corr with y, corr with A, and autocorrelation.

    Parameters
    ----------
    data: array, dtype=float
        The data set for which you want the moments

    Returns
    -------
    moms: array, dtype=float
        The array containing the 5 moments explained above
    """
    moms = [data.mean(),
               data.std(ddof=1),
               np.corrcoef(data, Y)[0, 1],
               np.corrcoef(data, lamb)[0, 1],
               np.corrcoef(data[1:], data[:-1])[0, 1]]

    return np.asarray(moms)

for sim in range(num_sims):
    ##----- Step 1
    epsilon = np.random.normal(0, sigma, size=T)

    z = np.zeros(T)
    for i in range(1, T):
        z[i] = gamma * z[i - 1] + epsilon[i]

    lamb = np.exp(z)

    ##----- Step 2
    Kappa = (theta * beta * l1 / (Lt ** theta)) / \
            ((l2 / Lt) + (theta * (1 + beta)) / (1 - theta))

    K = np.zeros(T)
    K[0] = 8.7241

    for i in range(1, T):
        K[i] = Kappa * lamb[i - 1] * K[i - 1] ** theta

    ##----- Step 3
    wage = (1 - theta) * lamb * (K / Lt) ** theta  # S:(T x 1) P:[0, T-1]
    rate = theta * lamb * (Lt / K) ** (1 - theta)  # (T x 1) [0, T-1]
    Y = lamb * (K ** theta) * Lt ** (1 - theta)  # S:(T x 1) P:[0, T-1]
    c1 = wage[:-1] * l1 - K[1:]  # S:(T-1 x 1) P:[0, T-2]
    c2 = wage[:-1] * l2 + rate[:-1] * K[:-1]  # S:(T-1 x 1) P:[0, T-2]
    C = c1 + c2  # S:(T-1 x 1) P:[0, T-2]
    I = Y[:-1] - C  # (T-1 x 1) P:[0, T-2]

    # I need to make all the data the same size and in the same period so
        # I will take away from wage, rate, Y, K, and lamb
    Y = Y[:-1]
    K = K[:-1]
    wage = wage[:-1]
    rate = rate[:-1]
    lamb = lamb[:-1]

    # Now all data is shape (T-1 x 1) and goes from periods [0, T-2]

    ##----- Step 4
    all_moments[0, :, sim] = create_moments(Y)
    all_moments[1, :, sim] = create_moments(I)
    all_moments[2, :, sim] = create_moments(C)
    all_moments[3, :, sim] = create_moments(wage)
    all_moments[4, :, sim] = create_moments(rate)
    all_moments[5, :, sim] = create_moments(K)
    all_moments[6, :, sim] = create_moments(lamb)


new_ind = {0: 'Y', 1: 'I', 2: 'C', 3: 'w', 4: 'r', 5: 'K', 6: 'lamb'}

kerks_table = np.mean(all_moments, axis=2)
moment_table = pd.DataFrame(kerks_table)
moment_table.columns = ['mean', 'standard deviation', 'corr with y',
                        'corr with lamb', 'autocorrelation']
moment_table = moment_table.rename(index=new_ind)

running_time = time()
elapsed_time = running_time - start_time
print 'Total Execution time is ', elapsed_time, 'seconds'
