%% 1. CMIP6-LUMIP
clear,clc;
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
load([path,'treeFrac_30yrmean_pattern.mat'])
load([path,'Biomass_30yrmean_pattern.mat'])
load([path,'MAP_30yrmean_pattern.mat'])
load([path,'MAP_30yramplitude_pattern.mat'])
load([path,'MAT_30yrmean_pattern.mat'])
load([path,'MAT_30yramplitude_pattern.mat'])
load([path,'MATmax_30yrmean_pattern.mat'])
load([path,'PRD_30yrmean_pattern.mat'])
load([path,'CWD_30yrmean_pattern.mat'])
load([path,'VPD_30yrmean_pattern.mat'])
vegcannpic_mmm = nanmean(vegcannpic,3)*10;
prannpic_mmm = nanmean(prannpic,3)*365;
pramppic_mmm = nanmean(pramppic,3)*30;
tasannpic_mmm = nanmean(tasannpic,3)-273.15;
tasamppic_mmm = nanmean(tasamppic,3)-273.15;
tasmaxannpic_mmm = nanmean(tasmaxannpic,3)-273.15;
cwdpic_mmm = nanmean(cwdpic,3)*365;
vpdpic_mmm = nanmean(vpdpic,3);
prdpic_mmm = nanmean(prdpic,3)*365;

dataveg = vegcannpic_mmm(90-23:90+23, 1:360);
datapr = prannpic_mmm(90-23:90+23, 1:360);
datapramp = pramppic_mmm(90-23:90+23, 1:360);
datata = tasannpic_mmm(90-23:90+23, 1:360);
datataamp = tasamppic_mmm(90-23:90+23, 1:360);
datatamax = tasmaxannpic_mmm(90-23:90+23, 1:360);
datacwd = cwdpic_mmm(90-23:90+23, 1:360);
datavpd = vpdpic_mmm(90-23:90+23, 1:360);
dataprd = prdpic_mmm(90-23:90+23, 1:360);

maskk = dataveg;
maskk(maskk==0) = nan;
maskk(isnan(datapr)) = nan;
maskk(isnan(datapramp)) = nan;
maskk(isnan(datata)) = nan;
maskk(isnan(datataamp)) = nan;
maskk(isnan(datatamax)) = nan;
maskk(isnan(datacwd)) = nan;
maskk(isnan(datavpd)) = nan;
maskk(datapr < 100) = nan;

datapr(isnan(maskk)) = nan;
datapramp(isnan(maskk)) = nan;
datata(isnan(maskk)) = nan;
datataamp(isnan(maskk)) = nan;
datatamax(isnan(maskk)) = nan;
datacwd(isnan(maskk)) = nan;
datavpd(isnan(maskk)) = nan;
dataprd(isnan(maskk)) = nan;

yveg = dataveg(~isnan(dataveg));
xppt = datapr(~isnan(datapr));
xpam = datapramp(~isnan(datapramp));
xt2m = datata(~isnan(datata));
xtam = datataamp(~isnan(datataamp));
xtma = datatamax(~isnan(datatamax));
xcwd = datacwd(~isnan(datacwd));
xvpd = datavpd(~isnan(datavpd));
xprd = dataprd(~isnan(dataprd));

X = [xppt xpam xt2m xtam xtma xvpd xprd];
T = array2table(X,'VariableNames',{'MAP','Pamp','MAT','Tamp','MAXT','VPD','PRD'});
collintest(T,'plot','on','tolIdx',20,'tolPro',0.4)
corrplot(T)

save maskk.mat maskk
% X = [datapr datapramp datacwd];
% collintest(X,'plot','on','tolIdx',5,'tolPro',0.4)



%% 2. Observations
clear,clc;
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
% landmask = landmask(ceil(0.5:0.5:180),ceil(0.5:0.5:360));
landmask = landmask(68:113,:);
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\biomass_tropics_1deg.mat
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\rain_tropics_1deg.mat
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\tair_tropics_1deg.mat
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\tmax_tropics_1deg.mat
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\rainamp_tropics_1deg.mat
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\tairamp_tropics_1deg.mat
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\cwd_tropics_1deg.mat
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\vpd_tropics_1deg.mat
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\prd_tropics_1deg.mat

tmp = biomass;
biomass(:,1:180) = tmp(:,181:360);
biomass(:,181:360) = tmp(:,1:180);
tmp = rain;
rain(:,1:180) = tmp(:,181:360);
rain(:,181:360) = tmp(:,1:180);
tmp = tair;
tair(:,1:180) = tmp(:,181:360);
tair(:,181:360) = tmp(:,1:180);
tmp = tmax;
tmax(:,1:180) = tmp(:,181:360);
tmax(:,181:360) = tmp(:,1:180);
tmp = rainamp;
rainamp(:,1:180) = tmp(:,181:360);
rainamp(:,181:360) = tmp(:,1:180);
tmp = tairamp;
tairamp(:,1:180) = tmp(:,181:360);
tairamp(:,181:360) = tmp(:,1:180);
tmp = cwd;
cwd(:,1:180) = tmp(:,181:360);
cwd(:,181:360) = tmp(:,1:180);
tmp = vpd;
vpd(:,1:180) = tmp(:,181:360);
vpd(:,181:360) = tmp(:,1:180);
tmp = prd;
prd(:,1:180) = tmp(:,181:360);
prd(:,181:360) = tmp(:,1:180);

landmask(landmask==0) = nan;
landmask(isnan(biomass)) = nan;
landmask(isnan(cwd)) = nan;
landmask(isnan(tair)) = nan;
landmask(rain < 100) = nan;

biomass(isnan(landmask)) = nan;
rain(isnan(landmask)) = nan;
tair(isnan(landmask)) = nan;
tmax(isnan(landmask)) = nan;
rainamp(isnan(landmask)) = nan;
tairamp(isnan(landmask)) = nan;
cwd(isnan(landmask)) = nan;
vpd(isnan(landmask)) = nan;
prd(isnan(landmask)) = nan;

datay1 = biomass;
datay2 = rain;
datac = tair;
datay22 = rainamp;
datacc = tairamp;
data222 = cwd;
dataccc = vpd;
data2cc = prd;
data22c = tmax;
xppt = datay2(~isnan(datay2));
yveg = datay1(~isnan(datay1));
xt2m = datac(~isnan(datac));
xpam = datay22(~isnan(datay22));
xtam = datacc(~isnan(datacc));
xcwd = data222(~isnan(data222));
xvpd = dataccc(~isnan(dataccc));
xprd = data2cc(~isnan(data2cc));
xtma = data22c(~isnan(data22c));

X = [xppt xpam xt2m xtam xtma xvpd xprd];
T = array2table(X,'VariableNames',{'MAP','Pamp','MAT','Tamp','MAXT','VPD','PRD'});
collintest(T,'plot','on','tolIdx',20,'tolPro',0.4)
corrplot(T)

% X = [datapr datapramp datacwd];
% collintest(X,'plot','on','tolIdx',5,'tolPro',0.4)