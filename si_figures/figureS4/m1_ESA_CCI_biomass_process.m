clear,clc;
ncdisp E:\Data\Obs_RS\ESA_CCI_AGB_biomass\ESACCI-BIOMASS-L4-AGB-MERGED-100m-2017-fv1.0.nc


%%
lat = ncread('E:\Data\Obs_RS\ESA_CCI_AGB_biomass\ESACCI-BIOMASS-L4-AGB-MERGED-100m-2017-fv1.0.nc','lat');
lon = ncread('E:\Data\Obs_RS\ESA_CCI_AGB_biomass\ESACCI-BIOMASS-L4-AGB-MERGED-100m-2017-fv1.0.nc','lon');
% lat: 64125 (23oN) - 115876 (23oS)

biomass = nan(140, 360); % 1 deg, 80N-60S
for i = 1 : 140 % from 23N every 1deg
    i,
    agb = ncread('E:\Data\Obs_RS\ESA_CCI_AGB_biomass\ESACCI-BIOMASS-L4-AGB-MERGED-100m-2017-fv1.0.nc',...
        'agb',[1 1+1125*(i-1) 1],[405000 1125 1],[1 1 1]);
    for j = 1 : 360 % from -180 every 1deg
        tmp = agb( floor((j-1)*1125)+1 : floor(j*1125), :);
        sz = size(tmp)
        biomass(i,j) = nansum(nansum(tmp))/(sz(1)*sz(2));
%         tmp = tmp(~isnan(tmp));
%         biomass(i,j) = mean(tmp);
    end
end

% Amazon point, i = 83, j = 111

% save biomass_tropics_1deg_glob.mat biomass