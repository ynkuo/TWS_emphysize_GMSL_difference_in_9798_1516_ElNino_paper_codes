clc; close all; clear
time = (1993:1/12:2017-1/12)';
%% load data for mean TWS of 9798 and 1516 events
load ERA5land_integral_TWS_1993_2016.mat % with seasonal cycle
%% calculate the mean TWS of 9798 and 1516 events
TWS9798 = mean(TWS(:,:,55:66),3,'omitnan');
TWS1516 = mean(TWS(:,:,271:282),3,'omitnan');
%% load data for regression
load EPI_CPI_1993_2016_new.mat
load('integral_TWS_no_seasonal_cycle_1993_2016.mat') % without seasonal cycle
%% calculate regression and statistics
CP_TWS_regress = NaN(3600,1801); EP_TWS_regress = NaN(3600,1801);
CP_TWS_int = NaN(3600,1801); EP_TWS_int = NaN(3600,1801);
CP_TWS_Nd = NaN(3600,1801); EP_TWS_Nd = NaN(3600,1801);
CP_TWS_F = NaN(3600,1801); EP_TWS_F = NaN(3600,1801);

datalength = length(CPI);
for j = 1:3600
    disp(j)
    for k = 1:1801
        if ~isnan(squeeze(TWS(j,k,1)))
            P = polyfit(CPI,squeeze(TWS(j,k,:)),1);
            CP_TWS_regress(j,k) = P(1);
            CP_TWS_int(j,k) = P(2);
            temp = P(1)*CPI+P(2);
            residual = squeeze(TWS(j,k,:))-temp;
            corr_lag1 = corrcoef(residual,circshift(residual,1)); 
            corr_lag1 = corr_lag1(1,2);
            CP_TWS_Nd(j,k) = floor(datalength*((1-abs(corr_lag1))/(1+abs(corr_lag1))));
            MSE = sum((residual).^2)/(CP_TWS_Nd(j,k)-2);
            MSR = sum((temp-mean(squeeze(TWS(j,k,:)))).^2)/1;
            CP_TWS_F(j,k) = MSR/MSE;
            clear temp residual corr_lag1 MSR MSE
            P = polyfit(EPI,squeeze(TWS(j,k,:)),1);
            EP_TWS_regress(j,k) = P(1);
            EP_TWS_int(j,k) = P(2);
            temp = P(1)*EPI+P(2);
            residual = squeeze(TWS(j,k,:))-temp;
            corr_lag1 = corrcoef(residual,circshift(residual,1)); 
            corr_lag1 = corr_lag1(1,2);
            EP_TWS_Nd(j,k) = floor(datalength*((1-abs(corr_lag1))/(1+abs(corr_lag1))));
            MSE = sum((residual).^2)/(EP_TWS_Nd(j,k)-2);
            MSR = sum((temp-mean(squeeze(TWS(j,k,:)))).^2)/1;
            EP_TWS_F(j,k) = MSR/MSE;
            clear temp residual corr_lag1 MSR MSE
        end
    end
end
%% save data
save('Kuo_et_al_figure3_maps.mat','lon','lat',...
    'TWS1516','TWS9798','CP_TWS_regress','EP_TWS_regress',...
    'CP_TWS_int','EP_TWS_int','CP_TWS_Nd','EP_TWS_Nd','CP_TWS_F','EP_TWS_F')