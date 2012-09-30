"""
Created September 26, 2012

Author: Spencer Lyon

Filters homework

fred_names = {'labor': 'PAYEMS',
              'output': 'GDPC1',
              'investment': 'GPDIC96',
              'consumption': 'PCECC96',
              'interest_rate': 'TB3MS',
              'wage': 'WASCUR'}
"""
import numpy as np
import pandas as pd
from numpy import asarray
from pandas.io.data import DataReader
import datetime as dt
from dolo.numeric import filters

theta = 0.35
delta = 0.02

start1 = dt.datetime(1947, 1, 1)
end1 = dt.datetime(2012, 4, 1)

new_ind = {0: 'y', 1: 'i', 2: 'c', 3: 'w',
           4: 'l', 5: 'k', 6: 'lambda', 7: 'r'}


def apply_filters(data):
    """
    Applies all 4 filters asked for and returns them in a python list.

    The list will be structured with rows in the following order:
        1. Linear OLS trend
        2. HP filters
        3. Bandpass filter
        4. First-difference

    Parameters
    ----------
    data: array-like, dtype=float
        The data set that will be run through the filters

    Returns
    -------
    filtered: list
        This is a 4 element list with the filtered data in the order
        listed above.

    Notes
    -----
        Because of how the filters work, the bandpass and first diff
        arrays will be different sizes than the hp filter ones.

        Note also that before applying the filters, we take the natural
        log of the data.
    """
    data = np.log(data)

    linear_ols = filters.hp_filter(data, lam=1e10)[1]
    hp_fils = filters.hp_filter(data, lam=1600)[1]
    bp_fils = filters.bandpass_filter(data, 10, 6, 32)

    temp1 = data.copy()
    temp1 = np.insert(temp1, temp1.size, 0)
    temp2 = data.copy()
    temp2 = np.insert(temp2, 0, 0)
    yhat = temp1 - temp2
    first_diff = yhat[1:-1]

    all_fils = [linear_ols, hp_fils, bp_fils, first_diff]

    return all_fils


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
    moms = [np.mean(data),
            data.std(ddof=1),
            np.corrcoef(data, y)[0, 1],
            np.corrcoef(data, A)[0, 1],
            np.corrcoef(data[1:], data[:-1])[0, 1]]

    return moms


# Use pandas DataReader to get data from fred
output = asarray(DataReader('GDPC1', 'fred',
                            start=start1, end=end1)).squeeze()
investment = asarray(DataReader('GPDIC96', 'fred',
                                start=start1, end=end1)).squeeze()
consumption = asarray(DataReader('PCECC96', 'fred',
                                start=start1, end=end1)).squeeze()
interest_rate = asarray(DataReader('TB3MS', 'fred',
                                start=start1, end=end1)).squeeze()
wages = asarray(DataReader('WASCUR', 'fred',
                                start=start1, end=end1)).squeeze()
labor = asarray(DataReader('PAYEMS', 'fred',
                                start=start1, end=end1)).squeeze()

# This data was quarterly so we take every 3rd data point to make it quarterly
interest_rate = interest_rate[np.arange(0, interest_rate.size, 3)]
labor = labor[np.arange(0, labor.size, 3)]

k_init = 60.2
capital = np.zeros(output.size)
capital[0] = k_init
for t in range(1, capital.size):
    capital[t] = capital[t - 1] * (1. - delta) + investment[t - 1]

capital /= 10.95

lamb = output ** (1 / (1 - theta)) * capital ** (-theta / (1 - theta)) / labor

data = [output, investment, consumption,  wages, labor, capital, lamb]
filtered = [apply_filters(i) for i in data]

filtered.extend([[interest_rate, interest_rate, interest_rate[10:-10],
                  interest_rate[1:]]])

moments = np.empty((8, 5, 4))

for filt in range(4):
    y = filtered[0][filt]
    A = filtered[-2][filt]
    for var in range(8):
        moments[var, :, filt] = create_moments(filtered[var][filt])


ols = pd.DataFrame(moments[:, :, 0])
ols.columns = ['mean', 'standard deviation', 'corr with y', 'corr with A',
                  'autocorrelation']
ols = ols.rename(index=new_ind)

hp = pd.DataFrame(moments[:, :, 1])
hp.columns = ['mean', 'standard deviation', 'corr with y', 'corr with A',
                  'autocorrelation']
hp = hp.rename(index=new_ind)

bandpass = pd.DataFrame(moments[:, :, 2])
bandpass.columns = ['mean', 'standard deviation', 'corr with y', 'corr with A',
                  'autocorrelation']
bandpass = bandpass.rename(index=new_ind)

difference = pd.DataFrame(moments[:, :, 3])
difference.columns = ['mean', 'standard deviation', 'corr with y', 'corr with A',
                  'autocorrelation']
difference = difference.rename(index=new_ind)



