"""
Created August 29, 2012

Author: Spencer Lyon

Economics 581 HW1: Solow Growth Model
"""
from __future__ import division
from time import time
import numpy as np
import pandas as pd

start_time = time()

## Global parameters, applicable to all simulations
a_bar, g, n, delta, theta, omega = [1., 0.025, 0.01, 0.1, 0.33, .0004 ** (1. / 2)]
T = 120  # sample size
num_sims = 1000
new_ind = {0: 'Exact y', 1: 'Exact c', 2: 'Exact i', 3: 'Exact k',
           4: 'Approx. y', 5: 'Approx. c', 6: 'Approx. i', 7: 'Approx. k'}


## Code to do the simulation
def main():
    """
    Does the entire Monte Carlo simulation, including analysis of moments.

    Parameters
    ----------
    None

    Returns
    -------
    data_table: array, dtype=float, shape=(8 x 5)
        The data table containing the mean, std, corr w/y, corr w/A, and
        autocorrelation averaged accross 1000 monte carlo simulations. This data
        is gathered for y, i, c, and k and is structured so each column is one
        of the 5 moments listed above and the rows are ordered as follows:

            1. y_exact
            2. c_exact
            3. i_exact
            4. k_exact
            5. y_approx
            6. c_approx
            7. i_approx
            8. k_approx
    """
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
                   np.corrcoef(data, y)[0, 1],
                   np.corrcoef(data, A)[0, 1],
                   np.corrcoef(data[1:], data[:-1])[0, 1]]

        return np.asarray(moms)

    all_data = np.empty((8, 5, num_sims))  # Table to store all the data.

    for mc in range(1000):
        ## create epsilon shocks
        epsilon = np.random.normal(0, omega, size=T)

        ## Allocate memory for exact values
        A = np.zeros(T)
        a = np.zeros(T)
        k = np.zeros(T)
        y = np.zeros(T)
        i = np.zeros(T)
        c = np.zeros(T)

        ## Allocate memory for approximate values
        k_tilde = np.zeros(T)
        k_approx = np.zeros(T)
        y_approx = np.zeros(T)
        i_approx = np.zeros(T)
        c_approx = np.zeros(T)

        ## Set initial values in exact case
        k[0] = kbar
        y[0] = k[0] ** theta * np.exp((1 - theta) * a[0])
        i[0] = kbar - (1 - delta) * kbar
        c[0] = y[0] - i[0]
        A[0] = a_bar * np.exp(g + a[0])

        ## Set initial values in approximate case
        k_approx[0] = k[0]
        y_approx[0] = k[0] ** theta * np.exp((1 - theta) * a[0])
        i_approx[0] = kbar - (1 - delta) * kbar
        c_approx[0] = y[0] - i[0]

        ## Simulate the economy
        for t in range(1, T):
            ## Calculate the exact series
            a[t] = rho * a[t - 1] + epsilon[t]
            A[t] = a_bar * np.exp(g ** t + a[t])
            k[t] = (k[t - 1] * (1 - delta) + sigma * y[t - 1]) / (1 + g + n)
            y[t] = k[t] ** theta * np.exp((1 - theta) * a[t])
            i[t] = k[t] - (1 - delta) * k[t - 1]
            #i[t] = sigma * y[t]
            c[t] = y[t] - i[t]
            #c[t] = (1 - sigma) * y[t]

            ## Calculate the approximate series
            temp_k = kbar * (1 + k_tilde[t - 1])
            k_tilde[t] = (temp_k * (1 - delta) + sigma * temp_k ** theta *
                           np.exp((1 - theta) * a[t - 1])) / (kbar * (1 + g + n)) - 1
            k_approx[t] = kbar * np.exp(k_tilde[t])
            y_approx[t] = k_approx[t] ** theta * np.exp((1 - theta) * a[t])
            i_approx[t] = k_approx[t] - (1 - delta) * k_approx[t - 1]
            c_approx[t] = y_approx[t] - i_approx[t]

        all_data[0, :, mc] = create_moments(y)
        all_data[1, :, mc] = create_moments(c)
        all_data[2, :, mc] = create_moments(i)
        all_data[3, :, mc] = create_moments(k)
        all_data[4, :, mc] = create_moments(y_approx)
        all_data[5, :, mc] = create_moments(c_approx)
        all_data[6, :, mc] = create_moments(i_approx)
        all_data[7, :, mc] = create_moments(k_approx)

        if mc % 50 == 0:
            print "Finished Monte Carlo simulation %s" % (mc)

    data_table = all_data.mean(2)

    return data_table


## The 3 simulations
# Parameters for simulation 1 followed by simulation and cleaning data.
sigma, rho = [0.1, 0.9]
kbar = (sigma / (delta + n + g)) ** (1 / (1 - theta))
data_1 = pd.DataFrame(main())
data_1.columns = ['mean', 'standard deviation', 'corr with y', 'corr with A',
                  'autocorrelation']
data_1 = data_1.rename(index=new_ind)

print '####' * 18
print '#--------------------Finished parameter set 1--------------------------#'
print '####' * 18

# Parameters for simulation 2 followed by simulation and cleaning data.
sigma, rho = [0.1, 0.]
kbar = (sigma / (delta + n + g)) ** (1 / (1 - theta))
data_2 = pd.DataFrame(main())
data_2.columns = ['mean', 'standard deviation', 'corr with y', 'corr with A',
                  'autocorrelation']
data_2 = data_2.rename(index=new_ind)

print '####' * 18
print '#--------------------Finished parameter set 2--------------------------#'
print '####' * 18

# Parameters for simulation 3 followed by simulation and cleaning data.
sigma, rho = [0.2, 0.9]
kbar = (sigma / (delta + n + g)) ** (1 / (1 - theta))
data_3 = pd.DataFrame(main())
data_3.columns = ['mean', 'standard deviation', 'corr with y', 'corr with A',
                  'autocorrelation']
data_3 = data_3.rename(index=new_ind)

running_time = time()
elapsed_time = running_time - start_time
print 'Total Execution time is ', elapsed_time, 'seconds'
