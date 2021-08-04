%% 1st model, cVeg = a*MAP + b*MAT
% 2nd model, cVeg = a*MAP + b*MAT + c*P_amplitude + d*T_amplitude
% 3rd model, cVeg = a*MAP^c + b*MAT
clear,clc;
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
% landmask = landmask(ceil(0.5:0.5:180),ceil(0.5:0.5:360));
landmask = landmask(68:113,:);
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\biomass_tropics_1deg.mat
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


%% 2nd model, cVeg = a*MAP + b*MAT +c*MAP*MAT
% 2nd model, cVeg = a*MAP + b*MAT + c*P_amplitude + d*T_amplitude
% 3rd model, cVeg = a*MAP^c + b*MAT
clear,clc;
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
% landmask = landmask(ceil(0.5:0.5:180),ceil(0.5:0.5:360));
landmask = landmask(68:113,:);
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\biomass_tropics_1deg.mat
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
% biomass(landmask ==0) = nan;
% rain(landmask==0) = nan;
% tair(landmask==0) = nan;
biomass(landmask <0.5) = nan;
rain(landmask<0.5) = nan;
tair(landmask<0.5) = nan;
datac = biomass;
datax = rain;
datay = tair;
dataxy = rain.*tair;

datax(isnan(datac)) = nan;
datay(isnan(datac)) = nan;
datax(isnan(datay)) = nan;
datac(isnan(datay)) = nan;
dataxy(isnan(datac)) = nan;
dataxy(isnan(datay)) = nan;

datax(datax<100) = nan;
datay(isnan(datax)) = nan;
datac(isnan(datax)) = nan;
dataxy(isnan(datax)) = nan;

xx = datax(~isnan(datax));
yy = datay(~isnan(datay));
cc = datac(~isnan(datac));
xy = dataxy(~isnan(dataxy));

[b,bint,r,rint,stats] = regress(cc,[xx yy xy]);
b,
stats,
b(1)*100/mean(cc)*100
b(2)/mean(cc)*100
b(3)*100/mean(cc)*100
sqrt(sum((b(1)*xx+b(2)*yy+b(3)*xy-cc).^2)/length(cc))

save('regression_mode2.obs.mat','b','stats');