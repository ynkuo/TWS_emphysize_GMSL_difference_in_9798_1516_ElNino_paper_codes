function [regress_slope,regress_intercept,fx,t_score,CI] = regression_YN(x,y,number,conf_level)
%--------------------------------------------------------------
% This function is used to calculate the linear regression
% of variables (x and y) with the consideration of autocorrelation
% of the residuals. Note that x and y should be with same length. 
%--------------------------------------------------------------
% input:
%  x: variable 1
%  y: variable 2
%  number: the number of a  *** You can use number = length(a)
%  conf_level: the confidence intervals for the regression uncertainty
%--------------------------------------------------------------
% output:
%  regress_slope: regression slope of x and y
%  regress_intercept: regression intercept of x and y
%  fx: the regressed f(x)
%  t_score: the Student's t inverse cumulative distribution
%  CI: Confidence Interval
%--------------------------------------------------------------
p = polyfit(x,y,1);
regress_slope = p(1);
regress_intercept = p(2);
fx = polyval(p,x);
residuals = y-fx;

corr_lag1 = corrcoef(residuals,circshift(residuals,1)); corr_lag1 = corr_lag1(1,2);
N = floor(number*((1-abs(corr_lag1))/(1+abs(corr_lag1)))); % effective number

std_err = sqrt(((residuals.'*residuals)/(N-2))*(inv(x.'*x)))
t_score = tinv(conf_level,N-2);

CI = zeros(number,1);
CI = t_score.*std_err;