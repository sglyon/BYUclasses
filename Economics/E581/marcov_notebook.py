# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <markdowncell>

# # Spencer Lyon
#
# ## Econ 581 homework 6: Recursive models and Markov processes
#
# ### Problem 1
#
# We are given the following
#
# * $Y_t = A K_t ^{\theta}$
# * $K_{t+1} = I_t$
# * $C_t = Y_t - I_t$
# * $u(C) = ln(c)$
#
# We can now write the Bellman equation
#
# $$V(K) = \max_{K} ln(AK^{\theta} - K') + \beta  V(K')$$
#
# The *first order condition* is $u'(c) = \beta * V'(K')$
#
# >(if you substitute $K' = I = Y - C$ you get a neagive sign on the $V'$ term. Then set equal to zero and solve for $u'(c)$)
#
# The *envelope condition* is $V'(k) = u'(c) A \theta K^{\theta - 1}$
#
# This makes the *Euler Equation* become $u'(c) = \beta u'(c) A \theta K^{\theta - 1}$
#
# With log utility $u'(c) = \frac{1}{c}$
#
# The simplified *Euler equation* is $$\frac{C'}{C} = \theta \beta A K'^{\theta-1}$$
#
# MISSING STEP FOR HOW TO VERIFY POLICY FUNCTION
#
# The final form of the value function is the following:
# $$V(K) = ln(AK^{\theta} - \beta \theta A K^{\theta}) + \beta V(\beta \theta A K^{\theta})$$

# <markdowncell>

# ### Problem 2

# <codecell>

import numpy as np
from numpy import asarray
from scipy.optimize import fmin
from pandas.io.data import DataReader
import datetime as dt
import filters

theta = 0.35
delta = 0.02

start1 = dt.datetime(1947, 1, 1)
end1 = dt.datetime(2012, 4, 1)

output = asarray(DataReader('GDPC1', 'fred',
                            start=start1, end=end1)).squeeze()

differ = (output[1:] - output[:-1]) / output[:-1]
ave_trend = differ.mean()

filtered = filters.hp_filter(np.log(output), lam=1600)[1]
std_filt = filtered.std(ddof=1)
auto_corr_filt = np.corrcoef(filtered[1:], filtered[:-1], ddof=1)[0, 1]

T = 254
num_sims = 10000
g2 = np.array([0.01, -0.03])
g3 = np.array([0.02, 0.01, -0.03])
marcov2 = np.array([[0.9, 0.1],
                    [0.5, 0.5]]).cumsum(1)

marcov3 = np.array([[0.5, 0.45, 0.05],
                    [0.05, 0.85, 0.10],
                    [0.25, 0.25, 0.5]]).cumsum(1)


def do_mc(periods=T, only2=False):
    """does mc simulation"""
    if only2 == False:
        s2 = 0
        s3 = 0
        epsilon = np.random.normal(0, 0.02, T)  # generate random shocks

        y2 = np.zeros(periods)
        y3 = np.zeros(periods)

        for t in range(1, periods):
            r_num = np.random.rand()
            y2[t] = g2[s2] + y2[t - 1] + epsilon[t]
            y3[t] = g3[s3] + y3[t - 1] + epsilon[t]
            s2 = np.where(marcov2[s2, :] > r_num)[0][0]
            s3 = np.where(marcov3[s3, :] > r_num)[0][0]

    return np.array([y2, y3])

y2_data = np.zeros((num_sims, T))
y3_data = np.zeros((num_sims, T))
for i in range(num_sims):
    mc_data = do_mc(T)
    y2_data[i, :] = mc_data[0, :]
    y3_data[i, :] = mc_data[1, :]

# <codecell>


def create_moments(data):
    """
    gets the moments he asks for (growth rate, std, autocorr)
    """
    if data.ndim == 2:
        total_obs = data.shape[0]
        auto_corr = np.empty(total_obs)
        all_std = np.empty(total_obs)
        all_growth = np.empty(total_obs)

        for obs in range(total_obs):
            this_obs = data[obs, :]
            diff = (this_obs[2:] - this_obs[1:-1]) / this_obs[1:-1]
            all_growth[obs] = np.mean(diff)

            filt = filters.hp_filter(np.log(this_obs), lam=1600)[1]

            all_std[obs] = np.std(filt, ddof=1)
            auto_corr[obs] = np.corrcoef(filt[2:], filt[1:-1])[0, 1]

        growth = all_growth.mean()
        std = all_std.mean()
        autos = auto_corr.mean()

    else:
        diff = (data[2:] - data[1:-1]) / data[1:-1]
        growth = np.mean(diff)

        filt = filters.hp_filter(np.log(data), lam=1600)[1]
        std = np.std(filt, ddof=1)
        autos = np.corrcoef(filt[2:], filt[1:-1])[0, 1]
    return [growth, std, autos]

# <codecell>

# print create_moments(y2_data)
# data_moms = create_moments(output)


# <codecell>


def opt_func(p11, p22, g1, g2, sigma):
    """
    do 70 mc's and return diff between moments and data moments
    """
    marcov_mat = np.array([[p11, 1 - p11], [1 - p22, p22]])
    g22 = np.array([g1, g2])
    sims = 70

    y2_sim = np.zeros((sims, T))

    for sim in range(sims):
        s2 = 0
        epsilon = np.random.normal(0, sigma, T)

        for t in range(T):
            r_num = np.random.rand()
            y2_sim[sim, t] = g22[s2] + y2_sim[sim, t - 1] + epsilon[t]
            s2 = np.where(macov_mat[s2, :] > r_num)[0][0]

    sim_moms = create_moments(y2_sim)

    difference = np.abs(sim_moms - data_moms)

    return difference

initial_guess = np.array([.6, .3, .02, -.01, .001])
best_params = fmin(opt_func, initial_guess)[0]


