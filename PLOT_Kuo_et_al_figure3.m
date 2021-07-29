clc; clear; close all
%% load data
load Kuo_et_al_figure3_maps.mat
%% make Eurasia in the center
LON = (-179.9:0.1:180)';
TWS1516 = [TWS1516(1801:3600,:);TWS1516(1:1800,:)];
TWS9798 = [TWS9798(1801:3600,:);TWS9798(1:1800,:)];
CP_TWS_regress = [CP_TWS_regress(1801:3600,:);CP_TWS_regress(1:1800,:)];
EP_TWS_regress = [EP_TWS_regress(1801:3600,:);EP_TWS_regress(1:1800,:)];
%% calculate the p value with F value (CP_TWS_F; EP_TWS_F) and effective
%  number (CP_TWS_Nd; EP_TWS_Nd). 
pmap_cp = 1-fcdf(CP_TWS_F,1,CP_TWS_Nd-2);
pmap_ep = 1-fcdf(EP_TWS_F,1,EP_TWS_Nd-2);
pmap_cp = [pmap_cp(1801:3600,:);pmap_cp(1:1800,:)];
pmap_ep = [pmap_ep(1801:3600,:);pmap_ep(1:1800,:)];
[y x] = meshgrid(lat,LON);
ocean_mask = mask;
ocean_mask(ocean_mask==1) = 0;
ocean_mask(isnan(ocean_mask)) = 1;
ocean_mask(ocean_mask==0) = NaN;
%% calculating the value in figure 3a and 3b
global_area_mean_YN(TWS1516.*mask,mask,ocean_mask,lat,lon,1,length(lat))
global_area_mean_YN(TWS9798.*mask,mask,ocean_mask,lat,lon,1,length(lat))
%% plotting figure 3
figure('Position',[-800 -800 3000 2000])
%% figure 3a
subplot(2,2,1)
m_proj('miller','lon',[-179.9 179.9],'lat',[-60 90])
m_pcolor(x,y,TWS9798.*mask); hold on 
c=colorbar; color = cptcmap('BlueDarkRed18');
colormap(color(6:13,:));
set(gca,'Clim',[-150 150]); c.Ticks = [-150:50:150];
% Amazon
m_line(repmat(-85,38,1),-20:1:17,'linewi',2,'color','k');
m_line(-85:-30,repmat(-20,length(-85:-30),1),'linewi',2,'color','k');
m_line(repmat(-30,38,1),-20:1:17,'linewi',2,'color','k');
m_line(-85:-30,repmat(17,length(-85:-30),1),'linewi',2,'color','k');
% Africa
m_line(repmat(-15,length(-40:1:17),1),-40:1:17,'linewi',2,'color','k');
m_line(-15:50,repmat(-40,length(-15:50),1),'linewi',2,'color','k');
m_line(repmat(50,length(-40:1:17),1),-40:1:17,'linewi',2,'color','k');
m_line(-15:50,repmat(17,length(-15:50),1),'linewi',2,'color','k');
% Australia
m_line(repmat(110,length(-45:1:-10),1),-45:1:-10,'linewi',2,'color','k');
m_line(110:157,repmat(-45,length(110:157),1),'linewi',2,'color','k');
m_line(repmat(157,length(-45:1:-10),1),-45:1:-10,'linewi',2,'color','k');
m_line(110:157,repmat(-10,length(110:157),1),'linewi',2,'color','k');
% America
m_line(repmat(-125,length(30:1:50),1),30:1:50,'linewi',2,'color','k');
m_line(-125:-70,repmat(30,length(-125:-70),1),'linewi',2,'color','k');
m_line(repmat(-70,length(30:1:50),1),30:1:50,'linewi',2,'color','k');
m_line(-125:-70,repmat(50,length(-125:-70),1),'linewi',2,'color','k');
% Europe
m_line(repmat(0,length(30:1:75),1),30:1:75,'linewi',2,'color','k');
m_line(0:157,repmat(30,length(0:157),1),'linewi',2,'color','k');
m_line(repmat(157,length(30:1:75),1),30:1:75,'linewi',2,'color','k');
m_line(0:157,repmat(75,length(0:157),1),'linewi',2,'color','k');
m_coast('patch',[.7 .7 .7],'edgecolor',[.6 .6 .6],'FaceColor','none'); 
title(c,'mm','FontName','Times New Roman','FontWeight','Bold')
m_grid('linest','none','tickdir','out','FontName','Times New Roman','FontWeight','Bold');
set(gca,'FontName','Times New Roman','FontSize',12,'FontWeight','Bold')
title('(a) Mean TWS during 1997/07¡V1998/06','Fontsize',14);

text(-3,-.7,'-0.87 mm','FontSize',12,'FontName','Times New Roman','FontWeight','Bold')
text(-3,-1,'to GMSL','FontSize',11,'FontName','Times New Roman','FontWeight','Bold')
%% figure 3b
subplot(2,2,2)
m_proj('miller','lon',[-179.9 179.9],'lat',[-60 90])
m_pcolor(x,y,TWS1516.*mask); hold on 
c=colorbar; color = cptcmap('BlueDarkRed18');
colormap(color(6:13,:));
set(gca,'Clim',[-150 150]); c.Ticks = [-150:50:150];
% Amazon
m_line(repmat(-85,38,1),-20:1:17,'linewi',2,'color','k');
m_line(-85:-30,repmat(-20,length(-85:-30),1),'linewi',2,'color','k');
m_line(repmat(-30,38,1),-20:1:17,'linewi',2,'color','k');
m_line(-85:-30,repmat(17,length(-85:-30),1),'linewi',2,'color','k');
% Africa
m_line(repmat(-15,length(-40:1:17),1),-40:1:17,'linewi',2,'color','k');
m_line(-15:50,repmat(-40,length(-15:50),1),'linewi',2,'color','k');
m_line(repmat(50,length(-40:1:17),1),-40:1:17,'linewi',2,'color','k');
m_line(-15:50,repmat(17,length(-15:50),1),'linewi',2,'color','k');
% Australia
m_line(repmat(110,length(-45:1:-10),1),-45:1:-10,'linewi',2,'color','k');
m_line(110:157,repmat(-45,length(110:157),1),'linewi',2,'color','k');
m_line(repmat(157,length(-45:1:-10),1),-45:1:-10,'linewi',2,'color','k');
m_line(110:157,repmat(-10,length(110:157),1),'linewi',2,'color','k');
% America
m_line(repmat(-125,length(30:1:50),1),30:1:50,'linewi',2,'color','k');
m_line(-125:-70,repmat(30,length(-125:-70),1),'linewi',2,'color','k');
m_line(repmat(-70,length(30:1:50),1),30:1:50,'linewi',2,'color','k');
m_line(-125:-70,repmat(50,length(-125:-70),1),'linewi',2,'color','k');
% Europe
m_line(repmat(0,length(30:1:75),1),30:1:75,'linewi',2,'color','k');
m_line(0:157,repmat(30,length(0:157),1),'linewi',2,'color','k');
m_line(repmat(157,length(30:1:75),1),30:1:75,'linewi',2,'color','k');
m_line(0:157,repmat(75,length(0:157),1),'linewi',2,'color','k');
m_coast('patch',[.7 .7 .7],'edgecolor',[.6 .6 .6],'FaceColor','none'); 
title(c,'mm','FontName','Times New Roman','FontWeight','Bold')
m_grid('linest','none','tickdir','out','FontName','Times New Roman','FontWeight','Bold');
set(gca,'FontName','Times New Roman','FontSize',12,'FontWeight','Bold')
title('(b) Mean TWS during 2015/07¡V2016/06','Fontsize',14);

text(-3,-.7,'3.88 mm','FontSize',12,'FontName','Times New Roman','FontWeight','Bold')
text(-3,-1,'to GMSL','FontSize',11,'FontName','Times New Roman','FontWeight','Bold')
%% figure 3c
subplot(2,2,3)
P = zeros(3600,1801); P((pmap_ep.*mask)<=0.05) = 0.05;
m_proj('miller','lon',[-179.9 179.9],'lat',[-60 90])
m_pcolor(x,y,EP_TWS_regress); hold on
h2=m_line(x(P==0.05),y(P==0.05),'marker','o','color','k','linewi',.01,...
          'linest','none','markersize',.01,'markerfacecolor','k');

m_line(repmat(-85,38,1),-20:1:17,'linewi',2,'color','k');
m_line(-85:-30,repmat(-20,length(-85:-30),1),'linewi',2,'color','k');
% Amazon
m_line(repmat(-85,38,1),-20:1:17,'linewi',2,'color','k');
m_line(-85:-30,repmat(-20,length(-85:-30),1),'linewi',2,'color','k');
m_line(repmat(-30,38,1),-20:1:17,'linewi',2,'color','k');
m_line(-85:-30,repmat(17,length(-85:-30),1),'linewi',2,'color','k');
% Africa
m_line(repmat(-15,length(-40:1:17),1),-40:1:17,'linewi',2,'color','k');
m_line(-15:50,repmat(-40,length(-15:50),1),'linewi',2,'color','k');
m_line(repmat(50,length(-40:1:17),1),-40:1:17,'linewi',2,'color','k');
m_line(-15:50,repmat(17,length(-15:50),1),'linewi',2,'color','k');
% Australia
m_line(repmat(110,length(-45:1:-10),1),-45:1:-10,'linewi',2,'color','k');
m_line(110:157,repmat(-45,length(110:157),1),'linewi',2,'color','k');
m_line(repmat(157,length(-45:1:-10),1),-45:1:-10,'linewi',2,'color','k');
m_line(110:157,repmat(-10,length(110:157),1),'linewi',2,'color','k');
% America
m_line(repmat(-125,length(30:1:50),1),30:1:50,'linewi',2,'color','k');
m_line(-125:-70,repmat(30,length(-125:-70),1),'linewi',2,'color','k');
m_line(repmat(-70,length(30:1:50),1),30:1:50,'linewi',2,'color','k');
m_line(-125:-70,repmat(50,length(-125:-70),1),'linewi',2,'color','k');
% Europe
m_line(repmat(0,length(30:1:75),1),30:1:75,'linewi',2,'color','k');
m_line(0:157,repmat(30,length(0:157),1),'linewi',2,'color','k');
m_line(repmat(157,length(30:1:75),1),30:1:75,'linewi',2,'color','k');
m_line(0:157,repmat(75,length(0:157),1),'linewi',2,'color','k');

c=colorbar; color = cptcmap('BlueDarkRed18');
colormap(color(6:13,:));
set(gca,'Clim',[-25 25]); c.Ticks = [-25:10:25];
m_coast('patch',[.7 .7 .7],'edgecolor',[.6 .6 .6],'FaceColor','none'); 
title(c,'mm/index','FontName','Times New Roman','FontWeight','Bold')
m_grid('linest','none','tickdir','out','FontName','Times New Roman','FontWeight','Bold',...
    'FontSize',12);
set(gca,'FontName','Times New Roman','FontSize',12,'FontWeight','Bold')
title('(c) Regression of TWS on EPI (1993¡V2016)','Fontsize',14);
%% figure 3d
subplot(2,2,4)
P = zeros(3600,1801); 
P((pmap_cp.*mask)<=0.05) = 0.05;
m_proj('miller','lon',[-179.9 179.9],'lat',[-60 90])
m_pcolor(x,y,CP_TWS_regress); hold on
h2=m_line(x(P==0.05),y(P==0.05),'marker','o','color','k','linewi',.01,...
          'linest','none','markersize',.01,'markerfacecolor','k');

m_line(repmat(-85,38,1),-20:1:17,'linewi',2,'color','k');
m_line(-85:-30,repmat(-20,length(-85:-30),1),'linewi',2,'color','k');
% Amazon
m_line(repmat(-85,38,1),-20:1:17,'linewi',2,'color','k');
m_line(-85:-30,repmat(-20,length(-85:-30),1),'linewi',2,'color','k');
m_line(repmat(-30,38,1),-20:1:17,'linewi',2,'color','k');
m_line(-85:-30,repmat(17,length(-85:-30),1),'linewi',2,'color','k');
% Africa
m_line(repmat(-15,length(-40:1:17),1),-40:1:17,'linewi',2,'color','k');
m_line(-15:50,repmat(-40,length(-15:50),1),'linewi',2,'color','k');
m_line(repmat(50,length(-40:1:17),1),-40:1:17,'linewi',2,'color','k');
m_line(-15:50,repmat(17,length(-15:50),1),'linewi',2,'color','k');
% Australia
m_line(repmat(110,length(-45:1:-10),1),-45:1:-10,'linewi',2,'color','k');
m_line(110:157,repmat(-45,length(110:157),1),'linewi',2,'color','k');
m_line(repmat(157,length(-45:1:-10),1),-45:1:-10,'linewi',2,'color','k');
m_line(110:157,repmat(-10,length(110:157),1),'linewi',2,'color','k');
% America
m_line(repmat(-125,length(30:1:50),1),30:1:50,'linewi',2,'color','k');
m_line(-125:-70,repmat(30,length(-125:-70),1),'linewi',2,'color','k');
m_line(repmat(-70,length(30:1:50),1),30:1:50,'linewi',2,'color','k');
m_line(-125:-70,repmat(50,length(-125:-70),1),'linewi',2,'color','k');
% Europe
m_line(repmat(0,length(30:1:75),1),30:1:75,'linewi',2,'color','k');
m_line(0:157,repmat(30,length(0:157),1),'linewi',2,'color','k');
m_line(repmat(157,length(30:1:75),1),30:1:75,'linewi',2,'color','k');
m_line(0:157,repmat(75,length(0:157),1),'linewi',2,'color','k');

c=colorbar; color = cptcmap('BlueDarkRed18');
colormap(color(6:13,:));
set(gca,'Clim',[-25 25]); c.Ticks = [-25:10:25];
m_coast('patch',[.7 .7 .7],'edgecolor',[.6 .6 .6],'FaceColor','none'); 
title(c,'mm/index','FontName','Times New Roman','FontWeight','Bold')
m_grid('linest','none','tickdir','out','FontName','Times New Roman','FontWeight','Bold',...
    'FontSize',12);
set(gca,'FontName','Times New Roman','FontSize',12,'FontWeight','Bold')
title('(d) Regression of TWS on CPI (1993¡V2016)','Fontsize',14);
%% save figure 3
saveas(gcf,'figure3_TWS97_TWS15_TWSCPregress_TWSEPregress_ERA5-land_1993','png')
print('figure3_TWS97_TWS15_TWSCPregress_TWSEPregress_ERA5-land_1993','-r600','-depsc')