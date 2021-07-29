clc;clear;close all
%% load data
load Kuo_et_al_AVISO_timeseries_1993_2016.mat
gmsl = remove_seasonality_detrend_YN(gmsl)*1000;
load Kuo_et_al_AVISO_timeseries_1993_2016_no_seasonality_n_trend.mat
load Kuo_et_al_ECCO_timeseries_1993_2016_no_seasonality_n_trend.mat
load EPI_CPI_1993_2016_new.mat
load ONI_positive_negative_separate_1993_2016.mat
%% calculate uncertainty of uncertainty with Monte Carlo method
[p S]= polyfit(time,gmsl,1);
pval = polyval(p,time);
diff_res = gmsl-pval;
[c,lags] = xcov(gmsl,3,'normalized');
c = c(1:4);
M2 = zeros(3,1);
M2(1:3) = c(3:-1:1);
M1 = zeros(3,3);
for i = 1:3
    M1(i,i:3) = c(4:-1:i+1);
end
for i = 1:3
    M1(i:3,i) = c(4:-1:i+1);
end
number = length(gmsl);
corr_lag1 = corrcoef(gmsl,circshift(gmsl,1)); corr_lag1 = corr_lag1(1,2);
N = floor(number*((1-abs(corr_lag1))/(1+abs(corr_lag1)))); % effective number
a = M1\M2;
var_noise = M1(1,1)-sum(a.*M2);
sla_reg = gmsl;
sla_reg(2) = a(1)*sla_reg(1);
sla_reg(3) = a(1)*sla_reg(2)+a(2)*sla_reg(1);
for tt = 4:length(gmsl)
    sla_reg(tt) = a(1)*sla_reg(tt)+a(2)*sla_reg(tt)+a(3)*sla_reg(tt);
end
noise_reg = gmsl-sla_reg;
var_noise(1) = mean(noise_reg); var_noise(2) = (M1(1,1)-sum(a.*M2))^(1/2);
P = gmsl-mean(gmsl);
gm(1) = mean(gmsl); gm(2) = ((1/(length(gmsl)-1))*sum(P.^2)).^(1/2);
[MC_sample y] = MC_simulation_auto_regress_YN(288,a,var_noise,gm,10000);
t95 = tinv(0.95,N);
sla_std = repmat(mean(std(y')*t95),1,288);
sla_glo = gmsl;
%% plotting figure 1
figure('Position',[.2 .15 850 1200])
%% figure 1a
subplot(13,1,[1:7])
h1=area(1:36,ONI_PN(37:72,:),'EdgeColor','none','FaceAlpha',.5);
h1(1).FaceColor=[.8 .1 0];
h1(2).FaceColor=[0 .5 .9];
axis([1 36 -3.2 3.2])
hold on
h2=area(1:36,ONI_PN(253:288,:),'EdgeColor','none','FaceAlpha',.5);
h2(1).FaceColor=[1 .6 .5];
h2(2).FaceColor=[.1 .8 .5];
ylabel('ONI (K)')
yyaxis('right')
hh1 = errorbar(1:36,sla_glo(37:72),sla_std(37:72),'k','LineWidth',3);
hh2 = errorbar(1:36,sla_glo(253:288),sla_std(253:288),'Color',...
    [.5 .5 .5],'LineWidth',3,'LineStyle','-');
set(gca,'YColor','k')
ylabel('Sea Level Anomaly (mm)')
axis([1 36 -11 11])
yticks([-10 -5 0 5 10])
xticks([1 13 25 36]);
xticklabels({'1996(2014)' '1997(2015)' '1998(2016)' '1999(2017)'});
l = legend([h1(1) h1(2) h2(1) h2(2) hh1 hh2],'ONI > 0 (1996-1998)',...
    'ONI < 0 (1996-1998)','ONI > 0 (2014-2016)','ONI < 0 (2014-2016)',...
    'GMSL (1996-1998)','GMSL (2014-2016)','Location','South','NumColumns',3)
l.EdgeColor = 'none'; 
set(gca,'FontName','TImes New Roman','FontWeight','Bold','FontSize',16)
grid on
title('(a) Evolutions of 1996¡V1998 and 2014¡V2016 Global Mean Sea Level (GMSL)','FontSize',16)
%% figure 1b
axes('Position',[0.13 0.25 0.35 0.16],'Box','on')
hold on
b = bar([sh(37:72),bh(37:72)],'stacked','EdgeColor','none','FaceAlpha',.5);
hh1 = plot(1:36,sh(37:72)+bh(37:72),'k','LineWidth',4);
set(gca,'YColor','k')
ylabel('mm')
axis([1 36 -11 11])
yticks([-10 -5 0 5 10])
xticks([1 13 25 36]);
xticklabels('')
l = legend([b(1) b(2) hh1],'Steric','Barystatic','Total','Position',[0.13311393719184,0.2556,0.338899345276834,0.026236125631361]);
l.EdgeColor = 'none'; l.Color = 'none'; l.NumColumns = 3;
set(gca,'FontName','TImes New Roman','FontWeight','Bold','FontSize',14)
l.FontSize = 11;
title('(b) 1996¡V1998 GMSL (ECCO)','FOntSize',16)
ax = gca; ax.XGrid = 'on'; grid on
%% figure 1c
axes('Position',[0.55 0.25 0.35 0.16],'Box','on')
b = bar([sh(253:288),bh(253:288)],'stacked','EdgeColor','none','FaceAlpha',.5);
hold on
hh2 = plot(1:36,sh(253:288)+bh(253:288),'Color',...
    [.5 .5 .5],'LineWidth',4,'LineStyle','-');
set(gca,'YColor','k')
axis([1 36 -11 11])
xticks([1 13 25 36]);
xticklabels('')
yticks([-10:5:10])
yticklabels('')
l = legend([b(1) b(2) hh2],'Steric','Barystatic','Total','Location','Best')
l.EdgeColor = 'none'; l.Color = 'none'; l.NumColumns = 3;
set(gca,'FontName','TImes New Roman','FontWeight','Bold','FontSize',14)
l.FontSize = 11;
title('(c) 2014¡V2016 GMSL (ECCO)','FOntSize',16)
ax = gca; ax.XGrid = 'on'; grid on
%% figure 1d
axes('Position',[0.13 0.06 0.35 0.14],'Box','on')
hh1 = plot(1:36,CPI(37:72),'-*','LineWidth',2.5); hold on
hh2 = plot(1:36,EPI(37:72),'-x','LineWidth',2.5);
axis([1 36 -4.8 4.8])
ax = gca; ax.XGrid = 'on';
grid on
xticks([1 13 25 36]);
xticklabels({'1996' '1997' '1998' '1999'});
yticks([-4:2:4])
l = legend([hh1 hh2],'CPI','EPI','Location','South')
l.EdgeColor = 'none'; l.Color = 'none'; l.NumColumns = 2;
set(gca,'FontName','TImes New Roman','FontWeight','Bold','FontSize',14)
l.FontSize = 11;
title('(d) 1996¡V1998 CP/EP Index','FOntSize',16)
%% figure 1e
axes('Position',[0.55 0.06 0.35 0.14],'Box','on')
hh1 = plot(1:36,CPI(253:288),'-*','LineWidth',2.5); hold on
hh2 = plot(1:36,EPI(253:288),'-x','LineWidth',2.5);
axis([1 36 -4.8 4.8])
ax = gca; ax.XGrid = 'on';
grid on
xticks([1 13 25 36]);
xticklabels({'2014' '2015' '2016' '2017'});
yticks([-4:2:4])
yticklabels('')
l = legend([hh1 hh2],'CPI','EPI','Location','South')
l.EdgeColor = 'none'; l.Color = 'none'; l.NumColumns = 2;
set(gca,'FontName','TImes New Roman','FontWeight','Bold','FontSize',14)
l.FontSize = 11;
title('(e) 2014¡V2016 CP/EP Index','FOntSize',16)
%% save figure 1
saveas(gcf,'figure1_2EventObservedSLAandONI_BudgetAnalysis_CPIEPI_norun','png')
print('figure1_2EventObservedSLAandONI_BudgetAnalysis_CPIEPI_norun','-r600','-depsc')
