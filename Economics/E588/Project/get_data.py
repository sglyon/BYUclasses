"""
Created Apr 9, 2013

Author: Spencer Lyon

Various routines used in my final project for 588

TODO:
    - Follow the data description from the original EPP paper page 147.
"""
import pandas as pd
from pandas.io.data import DataReader, get_data_yahoo
import statsmodels.api as sm
import matplotlib.pyplot as plt
import numpy as np
from byumcl.misc.pd_tools import df_to_latex

# Apply monkey patch to pandas DataFrame to get my latex_form function
pd.DataFrame.latex_form = lambda self, *args, **kwargs: \
                          df_to_latex(self, *args, **kwargs)


def save_data():
    start = '1/1/1990'

    # Get S&P 500 data from yahoo
    sp500 = get_data_yahoo('^GSPC', start=start)['Adj Close']
    sp500.name = 'SP500'

    vix = get_data_yahoo('^VIX', start=start)['Adj Close']
    vix.name = 'VIX'

    # Get ten year and 3 month t-bill rates
    ten_yr = DataReader('DGS10', 'fred', start=start)
    three_mon = DataReader('DGS3MO', 'fred', start=start)

    ten_yr = ten_yr.ix[ten_yr.DGS10.str.count(r'^\.') != 1].astype(float)
    three_mon = three_mon.ix[three_mon.DGS3MO.str.count(r'^\.') != 1].astype(float)

    data = ten_yr.join(three_mon)
    data = data.join(sp500)
    data = data.join(vix)

    # Drop non-like observations (obs on different days)
    data = data.dropna()

    data.save('SP_YC.db')
    data.to_csv('the_data.csv')


def load_data():
    return pd.DataFrame.load('SP_YC.db')


def fred_plots():
    # Plot FRED data
    plt.figure()
    fred.plot()
    plt.ylabel('%')
    plt.title('US Treasury Bill Time Series')
    plt.savefig('./Figures/FRED_data.eps', format='eps', dpi=1000)

    # Plot logged FRED data
    plt.figure()
    np.log(fred).plot()
    plt.ylabel('%')
    plt.title('Logged US Treasury Bill Time Series')
    plt.savefig('./Figures/FRED_data_log.eps', format='eps', dpi=1000)

    # Plot first differenced FRED data
    plt.figure()
    fred.diff(1).plot()
    plt.ylabel('%')
    plt.title('First Differenced US Treasury Bill Time Series')
    plt.savefig('./Figures/FRED_data_diff.eps', format='eps', dpi=1000)


def sp_plots():
    # Plot sp50 data
    plt.figure()
    sp.plot()
    plt.ylabel('%')
    plt.title('US Treasury Bill Time Series')
    plt.savefig('./Figures/sp500_data.eps', format='eps', dpi=1000)

    # Plot logged sp data
    plt.figure()
    np.log(sp).plot()
    plt.ylabel('%')
    plt.title('Logged US Treasury Bill Time Series')
    plt.savefig('./Figures/sp500_data_log.eps', format='eps', dpi=1000)

    # Plot first differenced sp data
    plt.figure()
    sp.diff(1).plot()
    plt.ylabel('%')
    plt.title('First Differenced US Treasury Bill Time Series')
    plt.savefig('./Figures/sp500_data_diff.eps', format='eps', dpi=1000)


def data_plot():
    (data / data.mean()).plot(linewidth=0.6)
    plt.legend(loc=2)
    plt.savefig('./Figures/all_data.eps', format='eps', dpi=900)


def ac_pac():
    ac = [sm.tsa.stattools.acf(data['%s' % i].values) for i in data.columns]
    pac = [sm.tsa.stattools.pacf(data['%s' % i].values) for i in data.columns]

    corrs = pd.DataFrame(ac[0], columns=['DGS10ac'])
    corrs['DGS3ac'] = ac[1]
    corrs['SPac'] = ac[2]
    corrs['VIXac'] = ac[3]
    corrs['DGS10pac'] = pac[0]
    corrs['DGS3pac'] = pac[1]
    corrs['SPpac'] = pac[2]
    corrs['VIXpac'] = pac[3]

    return corrs


def ac_plot():
    # Plot the correlation and autocorrelation coefficients.
    corrs = ac_pac(45)
    fig, axes = plt.subplots(nrows=2, ncols=2, figsize=(8, 5))

    corrs[['DGS10ac', 'DGS10pac']].plot(ax=axes[0, 0])
    axes[0, 0].set_title('Ten Year T-Bill (P)AC coefs')

    corrs[['DGS3ac', 'DGS3pac']].plot(ax=axes[0, 1])
    axes[0, 1].set_title('Three Month T-Bill (P)AC coefs')

    corrs[['SPac', 'SPpac']].plot(ax=axes[1, 0])
    axes[1, 0].set_title('S&P 500 (P)AC coefs')

    corrs[['VIXac', 'VIXpac']].plot(ax=axes[1, 1])
    axes[1, 1].set_title('VIX (P)AC coefs')

    fig.subplots_adjust(hspace=0.3)
    fig.savefig('./Figures/all_corrs.eps', format='eps', dpi=1000)


def plot_diffs(ser, n=4, rows_cols=None, subplots=True):
    """
    Plot the first n differences of the pandas series ser
    """
    df = pd.DataFrame(ser)
    names = ['d%i' % i for i in range(1, n + 1)]
    for i in range(n):
        df[names[i]] = ser.diff(i + 1)

    df = df.drop(ser.name, axis=1)

    if subplots:
        if rows_cols:
            rows, cols = rows_cols
        rem = n % (rows * cols)
        fig, axes = plt.subplots(nrows=rows, ncols=cols, figsize=(8, 8))

        i = 0
        for r in range(rows):
            for c in range(cols):
                name = names[i]
                title = '%s: diff(%i)' % (ser.name, i + 1)
                if rows == 1 or cols == 1:
                    df[name].plot(ax=axes[r + c], xticks=[], use_index=False)
                    axes[r + c].set_title(title)
                else:
                    df[name].plot(ax=axes[r, c], xticks=[], use_index=False)
                    axes[r, c].set_title(title)
                i += 1

        if rem:
            plt.show()
            # Plot the remainder on separate axis
            name = names[i]
            title = '%s: diff(%i)' % (ser.name, i + 1)
            plt.figure()
            df[name].plot()
            plt.title(title)

    plt.show()

    # return df


def diff_analysis():
    arr1 = np.array([[i] * 4 for i in data.columns]).ravel()
    arr2 = np.array([[1, 2, 3, 4] * 4])
    arrays = np.row_stack([arr1, arr2])

    tuples = zip(*arrays)
    index = pd.MultiIndex.from_tuples(tuples, names=['DataSet', 'Lags'])
    diffs = pd.DataFrame(columns=['Mean', 'Variance'], index=index).T

    for col in data.columns:
        for i in range(1, 5):
            index = '%s, %s' % (col, str(i))
            exec "d%i = data[col].diff(%i)" % (i, i)
            exec "mean = d%i.mean()" % (i)
            exec "var = d%i.var()" % (i)
            print('DataSet: %s, LAGS: %i, Mean:%.2e, Variance: %.2e'
                  % (col, i, mean, var))
            diffs[col][str(i)]['Mean'] = mean
            diffs[col][str(i)]['Variance'] = var

        plt.figure()
        plot_diffs(data[col], 4, (2, 2))
        plt.show()

    return diffs


def est_returns(items, freq='A'):
    """
    Get an estimate for the return on an equity at a given frequency

    Parameters
    ----------
    items : pandas.DataFrame
        The pandas data frame containing a TimeSeriesIndex and columns
        for the equities you want to estimate returns for

    freq : str, optional(default='A')
        The frequency you would like to sample the
    """
    if freq == 'A':
        periods = 250  # 250 trading days in a year
    elif freq == 'M':
        periods = 21  # 21 trading days in a month
    elif freq == 'W':
        periods = 5  # 5 trading days in a week

    changes = items.pct_change(periods=periods)

    # Resample annually
    period_returns = changes.resample(freq, how='mean') * 100

    period_returns.columns.name = 'Returns - ' + freq + ' (%)'

    return period_returns.dropna()


def adf_tests(data):
    lags = floor((data.shape[0] - 1) ** (1 / 3.))  # use R default
    adf_nolag = np.asarray([sm.tsa.adfuller(data[i], maxlag=lags,
                                            regression='ct',
                                            autolag=None)[:2]
                            for i in data.columns])
    adf_1lag = np.asarray([sm.tsa.adfuller(data[i].diff(1).dropna(),
                                           maxlag=lags,
                                           regression='ct',
                                           autolag=None)[:2]
                           for i in data.columns])
    adf_tests = np.concatenate([adf_nolag, adf_1lag])

    multi_ind = pd.MultiIndex.from_arrays(
               [['DGS10', 'DGS3MO', 'SP500', 'VIX'] * 2,
                [0, 0, 0, 0, 1, 1, 1, 1]])

    adf = pd.DataFrame(adf_tests, index=multi_ind, columns=['Statistic', 'p-value'])
    adf.columns.name = 'Value'
    adf.index.names = ['Data', 'Lags']
    adf = adf.sort_index()
    return adf

# save_data()
data = load_data()
# Describe data and save as latex file
desc = data.describe()

fred = data[['DGS10', 'DGS3MO']]
sp = data[['SP500', 'VIX']]

# Plot the data
# fred_plots()
# sp_plots()

# Generate autocorrelation and partial autocorrelation coefficients
corrs = ac_pac()

ann_returns = est_returns(sp, freq='A')

ann_returns = ann_returns.join(fred.resample('A', how='mean'))

ann_returns.plot(linewidth=2, title='Estimated Annual returns')

plt.savefig('./Figures/returns.eps', format='eps', dpi=1000)

# plot_diffs(data.VIX, 4, (1, 4))nu
