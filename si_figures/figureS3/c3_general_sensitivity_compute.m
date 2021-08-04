%% 1. Baccini 2012
clear,clc;
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
% landmask = landmask(ceil(0.5:0.5:180),ceil(0.5:0.5:360));
landmask = landmask(68:113,:);
% load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\biomass_tropics_1deg.mat
load AGB_Baccini.mat biomass
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\rain_tropics_1deg.mat
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\tair_tropics_1deg.mat
tmp = biomass*0.5;
biomass(:,1:180) = tmp(:,181:360);
biomass(:,181:360) = tmp(:,1:180);
tmp = rain;
rain(:,1:180) = tmp(:,181:360);
rain(:,181:360) = tmp(:,1:180);
tmp = tair;
tair(:,1:180) = tmp(:,181:360);
tair(:,181:360) = tmp(:,1:180);
% Experiments!!
% biomass(landmask ==0) = nan;
% rain(landmask==0) = nan;
% tair(landmask==0) = nan;
biomass(landmask <0.5) = nan;
rain(landmask<0.5) = nan;
tair(landmask<0.5) = nan;
datac = biomass;
datax = rain;
datay = tair;

datax(isnan(datac)) = nan;
datay(isnan(datac)) = nan;
datax(isnan(datay)) = nan;
datac(isnan(datay)) = nan;

datax(datax<100) = nan;
datay(isnan(datax)) = nan;
datac(isnan(datax)) = nan;

xx = datax(~isnan(datax));
yy = datay(~isnan(datay));
cc = datac(~isnan(datac));


[b,bint,r,rint,stats] = regress(cc,[xx yy]);
b,
bint,
stats,
b(1)*100/mean(cc)*100
b(2)/mean(cc)*100
sqrt(sum((b(1)*xx+b(2)*yy-cc).^2)/length(cc))

% save('regression_mode1.obs.mat','b','stats');

%% 2. Saatchi 2011
clear,clc;
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
% landmask = landmask(ceil(0.5:0.5:180),ceil(0.5:0.5:360));
landmask = landmask(68:113,:);
% load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\biomass_tropics_1deg.mat
load AGB_Saatchi.mat
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\rain_tropics_1deg.mat
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\tair_tropics_1deg.mat
tmp = biomass;
biomass(:,1:180) = tmp(:,181:360);
biomass(:,181:360) = tmp(:,1:180);
tmp = rain;
rain(:,1:180) = tmp(:,181:360);
rain(:,181:360) = tmp(:,1:180);
tmp = tair;
tair(:,1:180) = tmp(:,181:360);
tair(:,181:360) = tmp(:,1:180);
% Experiments!!
% biomass(landmask ==0) = nan;
% rain(landmask==0) = nan;
% tair(landmask==0) = nan;
biomass(landmask <0.5) = nan;
rain(landmask<0.5) = nan;
tair(landmask<0.5) = nan;
datac = biomass;
datax = rain;
datay = tair;

datax(isnan(datac)) = nan;
datay(isnan(datac)) = nan;
datax(isnan(datay)) = nan;
datac(isnan(datay)) = nan;

datax(datax<100) = nan;
datay(isnan(datax)) = nan;
datac(isnan(datax)) = nan;

xx = datax(~isnan(datax));
yy = datay(~isnan(datay));
cc = datac(~isnan(datac));


[b,bint,r,rint,stats] = regress(cc,[xx yy]);
b,
bint,
stats,
b(1)*100/mean(cc)*100
b(2)/mean(cc)*100
sqrt(sum((b(1)*xx+b(2)*yy-cc).^2)/length(cc))

% save('regression_mode1.obs.mat','b','stats');