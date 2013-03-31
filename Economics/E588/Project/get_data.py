import pandas as pd
from pandas.io.data import DataReader, get_data_yahoo
import matplotlib.pyplot as plt
import numpy as np
from byumcl.misc.pd_tools import df_to_latex

# Apply monkey patch to pandas DataFrame to get my latex_form function
pd.DataFrame.latex_form = lambda self, *args, **kwargs: \
                          df_to_latex(self, *args, **kwargs)


def save_data():
    start = '1/1/2000'

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

    data['YC'] = data.DGS10 - data.DGS3MO

    data.save('SP_YC.db')


def load_data():
    return pd.DataFrame.load('SP_YC.db')


def fred_plots():
    # Plot FRED data
    plt.figure()
    fred.plot()
    plt.ylabel('%')
    plt.title('US Treasury Bill Time Series')
    plt.savefig('./Figures/FRED_data.png')

    # Plot logged FRED data
    plt.figure()
    np.log(fred).plot()
    plt.ylabel('%')
    plt.title('Logged US Treasury Bill Time Series')
    plt.savefig('./Figures/FRED_data_log.png')

    # Plot first differenced FRED data
    plt.figure()
    fred.diff(1).plot()
    plt.ylabel('%')
    plt.title('First Differenced US Treasury Bill Time Series')
    plt.savefig('./Figures/FRED_data_diff.png')


def sp_plots():
    # Plot sp50 data
    plt.figure()
    sp.plot()
    plt.ylabel('%')
    plt.title('US Treasury Bill Time Series')
    plt.savefig('./Figures/sp500_data.png')

    # Plot logged sp data
    plt.figure()
    np.log(sp).plot()
    plt.ylabel('%')
    plt.title('Logged US Treasury Bill Time Series')
    plt.savefig('./Figures/sp500_data_log.png')

    # Plot first differenced sp data
    plt.figure()
    sp.diff(1).plot()
    plt.ylabel('%')
    plt.title('First Differenced US Treasury Bill Time Series')
    plt.savefig('./Figures/sp500_data_diff.png')


# save_data()
data = load_data()

# Describe data and save as latex file
desc = data.describe()
# label = 'tab:describe'
# caption = 'Description of data. Note the rows with percent labels correspond'\
#            + 'to percentiles'

# d_tex = desc.latex_form(h_row=1, h_col=True, label=label, caption=caption,
#                         filename='describe_data.tex')


fred = data[['DGS10', 'DGS3MO']]
sp = data[['SP500', 'VIX']]

# Plot the data
# fred_plots()
# sp_plots()
