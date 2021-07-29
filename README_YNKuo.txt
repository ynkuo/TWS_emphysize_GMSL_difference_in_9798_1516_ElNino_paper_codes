-------------------------------------------------------
This file is created by Yan-Ning Kuo
-------------------------------------------------------

These are codes (based on matlab) for plotting the figures in "Terrestrial Water Storage Anomalies Emphasize Interannual Variations in Global Mean Sea Level During 1997–1998 and 2015–2016 El Niño Events" (Kuo et al., 2021). This README file will briefly introduce them:

1)  global_area_mean_YN.m: covert the gridded data to global area weighted mean

2)  remove_seasonality_trend_YN.m: remove the seasonality and trend in time series

3)  corrcoef_YN.m: calculate correlation coefficient considering the effective number

4)  regression_YN.m: calculate the linear regression considering the effective number

5)  steric_height_calculation.m: calculate the steric height with salinity and temperature as inputs. Note that SEAWATER linrary version 3.2, which is a toolbox based on EOS80, is used in the code.

6) MC_simulation_auto_regress_YN.m: Monte Carlo simulation for the uncertainties in figure 1a, the difference of the peaks in GMSL, TWS in main text of the paper.

7)  PLOT_Kuo_et_al_table1.m: calculting values for table 1

8)  PLOT_Kuo_et_al_figure1.m: plotting code for figure 1

9)  PLOT_Kuo_et_al_figure2.m: plotting code for figure 2

10)  PLOT_Kuo_et_al_figure3.m: plotting code for figure 3. Note that the M_Map and cpt-city toolboxes are needed in this code.

11) CALCULATE_Kuo_et_al_figure3.m: calculating the maps used in figure 3.

Reference: 
  SEAWATER library version 3.2 attributed to Morgan, P. P. SEAWATER: a library of MATLAB® computational routines for the properties of sea water: Version 1.2. 1994. Report No.:222. http://hdl.handle.net/102.100.100/239771?index=1.
  M_MAP: https://www.eoas.ubc.ca/~rich/map.html
  cpt-city: http://soliton.vm.bytemark.co.uk/pub/cpt-city/