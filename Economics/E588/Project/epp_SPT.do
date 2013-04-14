clear
cd C:\Users\lyon4\Documents\byuclasses\Economics\E588\Project

insheet using the_data.csv

gen t = _n
tset t

reg sp500 t
estat archlm, lags(1)

reg vix t
estat archlm, lags(1)

reg dgs10 t
estat archlm, lags(1)

reg dgs3mo t
estat archlm, lags(1)

arch sp500 t, arch(1) garch(1)
predict sp_archCAST

arch vix t, arch(1) garch(1)
predict vix_archCAST

arch dgs10 t, arch(1) garch(1)
predict d10_archCAST

arch dgs3mo t, arch(1) garch(1)
predict d3m_archCAST
