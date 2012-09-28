"""
Created September 26, 2012

Author: Spencer Lyon

Filters homework
"""
import numpy as np
import pandas as pd
from pandas.io.data import DataReader
import datetime as dt
fred_names = {'capital': 'NRIPDC96',
              'labor': 'PAYEMS',
              'output': 'GDPC1',
              'investment': 'GPDIC96',
              'consumption': 'PCECC96',
              'interest_rate': 'TB3MS',
              'wage': 'WASCUR'}

start1 = dt.datetime(1947, 1, 1)

end1 = dt.datetime(2012, 4, 1)

symbols = ['NRIPDC96', 'PAYEMS', 'GDPC1', 'GPDIC96',
           'PCECC96', 'TB3MS', 'WASCUR']

data = dict((sym, DataReader(sym, "fred", start=start1, end=end1)) \
                for sym in symbols)
