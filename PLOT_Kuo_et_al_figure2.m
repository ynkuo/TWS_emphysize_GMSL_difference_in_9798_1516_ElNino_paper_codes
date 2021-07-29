clc; close all; clear
%% load data
time = (1993:1/12:2017-1/12)';
load Kuo_et_al_ERA5land_timeseries_1993_2016_no_seasonality_n_trend.mat
ERA5land = -TWS;
load Kuo_et_al_GRACE_timeseries_2003_2016_no_seasonality_n_trend.mat
GRACE = -tws_glo;
load('Kuo_et_al_ECCO_timeseries_1993_2016_no_seasonality_n_trend.mat','bh_glo')
ECCO = bh_glo;
load Kuo_et_al_CLM5_timeseries_1993_2016_no_seasonality_n_trend.mat
CLM5 = -TWS;
load Kuo_et_al_racmo23p2_timeseries_1993_2016_no_seasonality_n_trend.mat
ANT_GL = -smb_gl-ant_smb;
load ONI_positive_negative_separate_1993_2016.mat
%% plotting figure 2
figure('Position',[0 0 1000 280])
shading_area = zeros(36,2);shading_area(:,1) = 13; shading_area(:,2) = -13;
a1 = area(time(37:72),shading_area,'EdgeColor','none','FaceAlpha',.5);
X1(1:36) = time(37:72);
X1(37:72) = flip(time(37:72));
Y1(1:36) = shading_area(:,2);
Y1(37:72) = flip(shading_area(:,1));
fill(X1,Y1,[.7 .7 .7],'EdgeColor','none','FaceAlpha',0.5)
hold on
X1(1:36) = time(253:288);
X1(37:72) = flip(time(253:288));
Y1(1:36) = shading_area(:,2);
Y1(37:72) = flip(shading_area(:,1));
fill(X1,Y1,[.7 .7 .7],'EdgeColor','none','FaceAlpha',0.5)
set(gca,'FontName','TImes New Roman','FontWeight','Bold','FontSize',14)
h_racmo = plot(time,ANT_GL,'LineWidth',3);
h_era5land = plot(time,ERA5land,'LineWidth',3);
h_ecco = plot(time,ECCO,'LineWidth',3);
h_grace = plot((2003:1/12:2017-1/12),GRACE,'LineWidth',3);
h_clm5 = plot(time,CLM5,'LineWidth',3);
axis([-inf inf -12 12])
ll = legend([h_ecco h_grace h_era5land h_clm5 h_racmo],...
    'ECCO','GRACE','ERA5-land','CLM5','RACMO2.3p2',...
    'Location','North','EdgeColor','None','FOntSize',14,...
    'Color','None','NumColumns',5)
ylabel('mm')
title('Global Mean Barystatic (ECCO), -TWS (ERA5-land, GRACE, CLM5, RACMO2.3p2 (GL+ANT))','FontSize',14)
%% save figure 2
saveas(gcf,'figure2_ECCO_barystatic_ERA5land_Icase_GRACE_TWS_timeseries_norun','png')
print('figure2_ECCO_barystatic_ERA5land_Icase_GRACE_TWS_timeseries_norun','-r600','-depsc')