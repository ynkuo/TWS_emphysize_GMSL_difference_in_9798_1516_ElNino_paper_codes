function [data_no_seasonality_n_trend] = remove_seasonality_detrend_YN(data_in);
%--------------------------------------------------------------
% This function is used to remove the seasonality and trend in
% the time series.
%--------------------------------------------------------------
cli = zeros(12,1);
for t = 1:12
    cli(t) = mean(data_in(t:12:length(data_in)));
end
cli = repmat(cli,length(data_in)/12,1);
data_no_seasonality = data_in-cli;
data_no_seasonality_n_trend = detrend(data_no_seasonality,1);