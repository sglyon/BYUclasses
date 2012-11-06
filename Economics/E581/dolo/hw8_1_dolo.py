from dolo import *
from dolo.numeric.decision_rules import stoch_simul, impulse_response_function
import numpy as np
import pandas as pd
model = yaml_import('hw8_1.yaml')

ss_guess = np.ones(9)
dr = solve_decision_rule(model, solve_ss=True, steady_state=ss_guess)

sims = stoch_simul(dr, model.variables, horizon=500)
imps = impulse_response_function(dr, 'epsilon', model.variables)

the_vars = np.array([str(i) for i in model.variables])

frame = pd.DataFrame(dr['ys'], index=the_vars, columns=['Steady state'])
the_vars = np.array([str(i) for i in model.variables])
sim_frame = pd.DataFrame(sims, index=the_vars).T
auto_corrs = sim_frame.apply(lambda x: x.autocorr(), axis=0)
corrs = sim_frame.corr()
frame['Mean'] = sim_frame.mean()
frame['Std. Dev'] = sim_frame.std(ddof=1)
# frame['Variance'] = sim_frame.var(ddof=1)
frame['Corr with y'] = corrs['y']
frame['Corr with lambda'] = corrs['lam']
frame['Autocorr'] = auto_corrs
