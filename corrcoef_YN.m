function [corr_ab,t_score,N,p_value] = corrcoef_YN(a,b,number)
%--------------------------------------------------------------
% [corr_ab,t_score,N,p_value] = corrcoef_YN(a,b,number)
% This function is used to calculate the correlation coefficient
% of variables (a and b) with the consideration of autocorrelation
% of a and b themselves. Note that a and b should be with same length. 
%--------------------------------------------------------------
% input:
%  a: variable 1
%  b: variable 2
%  number: the number of a  *** You can use number = length(a)
%--------------------------------------------------------------
% output:
%  corr_ab: correlation coefficient of a and b
%  t_score: the t statistic value of the correlation coefficient 
%  N: the effective number after considering the autocorrelation of a and b
%  p_value: the p value of the correlation coefficient
%--------------------------------------------------------------

a = (a-mean(a))/std(a); b = (b-mean(b))/std(b);
corr_lag1 = corrcoef(a,circshift(a,1)); corr_lag1 = corr_lag1(1,2);
corr_lag2 = corrcoef(b,circshift(b,1)); corr_lag2 = corr_lag2(1,2);
N = floor(number*((1-abs(corr_lag1*corr_lag2))/(1+abs(corr_lag1*corr_lag2)))); % effective number
corr_ab = corrcoef(a,b); corr_ab = corr_ab(1,2);
t_score = corr_ab*sqrt((N-2)/(1-corr_ab^2));
p_value = 1-tcdf(abs(t_score),N-2);