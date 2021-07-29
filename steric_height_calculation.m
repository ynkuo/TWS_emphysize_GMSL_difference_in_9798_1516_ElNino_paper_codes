function [steric_height] = steric_height_calculation(temperature,salinity,depth,lat,lon,time_step)
%--------------------------------------------------------------
% [steric_height] = steric_height_calculation(temperature,salinity,depth,lat,lon,time_step)
% This function is used to calculate the steric height.
% Note that the SEAWATER linrary version 3.2 by Lindsay Pender is 
% used in the code. 
%--------------------------------------------------------------
% input:
%  temperature(lon,lat,depth,time): temperature, unit: degree C
%  salinity(lon,lat,depth,time): salinity, unit: psu (PSS-78)
%  depth: depth of the ocean layer, unit: m
%  lat: latitude
%  lon: longitude
%  time_step: the number of time step of temperature/salinity 
%             ***  time_step = length(squeeze(temperature(1,1,1,:)))
%--------------------------------------------------------------
% output:
%  steric_height(lon,lat,time): steric height
%--------------------------------------------------------------
% calculate pressure from depth
pressure = zeros(length(depth),length(lat));
for k=1:length(depth)
    for j=1:length(lat)
        pressure(k,j)=sw_pres(depth(k),lat(j));%[db]
    end
end
pressure=pressure';
clear k j
rho = zeros(length(lon),length(lat),length(depth),time_step);
for t = 1:time_step
    for k = 1:length(depth)
    for j=1:length(lat)
    rho(:,j,k,t)=sw_dens(salinity(:,j,k,t),temperature(:,j,k,t),pressure(j,k)); %[kg/m^3]
    end
    end
end

DEPTH = repmat(depth',length(lat),1);
steric_height = NaN(length(lon),length(lat),time_step);

rhobar = mean(rho,4,'omitnan'); % time-meaned rho
rho0_dep = squeeze(mean(mean(rhobar,1,'omitnan'),2,'omitnan')); % rho0 of each depth
dz =NaN(length(depth),1); 
dz(1) = abs(DEPTH(1,1)-0); 
dz(2:length(depth)) = abs(DEPTH(1,2:length(depth))-DEPTH(1,1:length(depth)-1));
DZ = NaN(length(lon),length(lat),length(depth)); rho0 = DZ;
for i = 1:length(lon)
    for j = 1:length(lat)
        DZ(i,j,:) = dz; %create DZ(lon,lat,depth) from dz(depth)
        rho0(i,j,:) = rho0_dep; % create rho0(lon,lat,depth) from rho0_dep(depth) 
    end
end

for t = 1:time_step
    steric_height(:,:,t) = -sum(DZ.*((squeeze(rho(:,:,1:length(depth),t))-rhobar)./rho0),3,'omitnan');
end

