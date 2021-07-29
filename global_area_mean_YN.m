function [data_glo_mean] = global_area_mean_YN(data,data_mask,area_mask,lat,lon,strlat,endlat)
%----------------------------------%
% Code by Yan-Ning Kuo (2021)
% Following the instruction from NCL:
% https://www.ncl.ucar.edu/Document/Functions/Built-in/wgt_areaave.shtml
%----------------------------------%
% INPUT:
%   1) data(lon, lat, time): the data you want to do global area-weighted
%      mean.
%   2) data_mask(lon,lat): the mask for indicating your data. Where with
%      values should be 1; where is NaN should be NaN. 
%   3) area_mask(lon,lat): Example -> if you want to do land area mean, 
%      make a mask where land areas are 1, ocean areas are NaN.
%   4) lat: latitude.
%   5) lon: longitude.
%   6) strlat: the start location of latitude in your data.
%   7) endlat: the end location of latitude in your data.
%   e.g., if I want to include all latitude for the area mean in my data, 
%   strlat = 1 and endlat = length(lat).
%----------------------------------%
% OUTPUT:
%   data_glo_mean(time): area-weighted mean of data(lon, lat, time).
%----------------------------------%

lat_size = length(lat); 
lon_size = length(lon);
time_size = length(squeeze(data(1,1,:)));

rad = 4.0*atan(1.0)/180.0;
R = 6371220.0 ; %[m]
rr = R*rad;
dlon = abs(lon(2)-lon(1))*rr;
dx = dlon*cos(lat*rad);

dy = zeros(size(lat));
dy(1) = abs(lat(2)-lat(1))*rr;
dy(2:lat_size-1) = abs(lat(3:lat_size)-lat(1:lat_size-2))*rr*0.5;
dy(lat_size) = abs(lat(lat_size)-lat(lat_size-1))*rr;

area = (dx.*dy)';
area = repmat(area,lon_size,1);
counted_area = area.*area_mask;

weighted_data = zeros(lon_size,lat_size,time_size);
for t = 1:time_size
    weighted_data(:,:,t) = data(:,:,t).*area.*data_mask;
end

sum_data = squeeze(sum(sum(weighted_data(:,strlat:endlat,:),2,'omitnan'),1,'omitnan'));
sum_counted_area = squeeze(sum(sum(counted_area(:,strlat:endlat),2,'omitnan'),1,'omitnan'))
data_glo_mean = sum_data./sum_counted_area;