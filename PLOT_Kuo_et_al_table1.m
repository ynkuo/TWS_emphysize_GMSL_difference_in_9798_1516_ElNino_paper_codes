clc; close all; clear
%% load data
time = (1993:1/12:2017-1/12)';
load EPI_CPI_1993_2016_new.mat
load('Kuo_et_al_ECCO_timeseries_1993_2016_no_seasonality_n_trend.mat','bh_glo')
ECCO = bh_glo;
load Kuo_et_al_ERA5land_timeseries_1993_2016_no_seasonality_n_trend.mat
ERA5land = -TWS;
load Kuo_et_al_CLM5_timeseries_1993_2016_no_seasonality_n_trend.mat
CLM5 = -TWS;
load Kuo_et_al_GRACE_timeseries_2003_2016_no_seasonality_n_trend.mat
GRACE = -tws_glo;
%% calculate the column of ECCO
[corr_ab,t_score,N,p_value] = corrcoef_YN(CPI,ECCO,288);
corr_ab
corr_ab^2
p_value
[regress_slope,regress_intercept,fx,t_score,CI] = regression_YN(CPI,ECCO,288,0.95);
regress_slope
CI
% EPI
[corr_ab,t_score,N,p_value] = corrcoef_YN(EPI,ECCO,288);
corr_ab
corr_ab^2
p_value
[regress_slope,regress_intercept,fx,t_score,CI] = regression_YN(EPI,ECCO,288,0.95);
regress_slope
CI
%% calculate the column of ERA5land
% CPI
[corr_ab,t_score,N,p_value] = corrcoef_YN(CPI,ERA5land,288);
corr_ab
corr_ab^2
p_value
[regress_slope,regress_intercept,fx,t_score,CI] = regression_YN(CPI,ERA5land,288,0.95);
regress_slope
CI
% EPI
[corr_ab,t_score,N,p_value] = corrcoef_YN(EPI,ERA5land,288);
corr_ab
corr_ab^2
p_value
[regress_slope,regress_intercept,fx,t_score,CI] = regression_YN(EPI,ERA5land,288,0.95);
regress_slope
CI
%% calculate the column of CLM5
% CPI
[corr_ab,t_score,N,p_value] = corrcoef_YN(CPI,CLM5,288);
corr_ab
corr_ab^2
p_value
[regress_slope,regress_intercept,fx,t_score,CI] = regression_YN(CPI,CLM5,288,0.95);
regress_slope
CI
% EPI
[corr_ab,t_score,N,p_value] = corrcoef_YN(EPI,CLM5,288);
corr_ab
corr_ab^2
p_value
[regress_slope,regress_intercept,fx,t_score,CI] = regression_YN(EPI,CLM5,288,0.95);
regress_slope
CI
%% calculate the column of GRACE
% CPI
[corr_ab,t_score,N,p_value] = corrcoef_YN(CPI(121:288),GRACE,168);
corr_ab
corr_ab^2
p_value
[regress_slope,regress_intercept,fx,t_score,CI] = regression_YN(CPI(121:288),GRACE,168,0.95);
regress_slope
CI
% EPI
[corr_ab,t_score,N,p_value] = corrcoef_YN(EPI(121:288),GRACE,168);
corr_ab
corr_ab^2
p_value
[regress_slope,regress_intercept,fx,t_score,CI] = regression_YN(EPI(121:288),GRACE,168,0.95);
regress_slope
CI