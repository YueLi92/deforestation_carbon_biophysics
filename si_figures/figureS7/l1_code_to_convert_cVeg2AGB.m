%% code to correct cVeg to AGB
% based on previous empirical relationship in Liu et al. 2015, NCC
% Tropical forest AGB/TBC = 0.8, savanna AGB/TBC = 0.4
% This code will convert cVeg in CMIP6 to AGB, the ratio is the average
% ratio between forest and savanna weighted by Treecover fraction
clear,clc;
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
load([path,'treeFrac_30yrmean_pattern.mat'])
load([path,'Biomass_30yrmean_pattern.mat'])

vegcannpicn = treeFracpic*0.01.*vegcannpic*0.8 + (1-treeFracpic*0.01).*vegcannpic*0.4;
vegcanndefn = treeFracdef*0.01.*vegcanndef*0.8 + (1-treeFracdef*0.01).*vegcanndef*0.4;

for mi = 1 : 8
    figure,imagesc(vegcannpicn(:,:,mi) - vegcannpic(:,:,mi));
    colorbar
end
vegcannpic = vegcannpicn;
vegcanndef = vegcanndefn;
save([path,'Biomass_30yrmean_pattern_new.mat'], 'vegcannpic', 'vegcanndef');

%%
clear,clc;
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'Biomass_30yrmean_pattern_new.mat'], 'vegcannpic', 'vegcanndef');
vcdef = ncread([path,'Biomass_30yrmean_pattern_new.nc'],'vegcanndef');
vcpic = ncread([path,'Biomass_30yrmean_pattern_new.nc'],'vegcannpic');

for mi = 1 : 8
    vcdef(:,:,mi) = rot90(vegcanndef(:,:,mi),-1);
    vcpic(:,:,mi) = rot90(vegcannpic(:,:,mi),-1);
end

ncwrite([path,'Biomass_30yrmean_pattern_new.nc'],'vegcanndef',vcdef);
ncwrite([path,'Biomass_30yrmean_pattern_new.nc'],'vegcannpic',vcpic);