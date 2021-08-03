%% 1st model, cVeg = a*MAP + b*MAT

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


datay1 = vegcannpic_mmm(90-23:90+23, 1:360);
datay2 = prannpic_mmm(90-23:90+23, 1:360);
datac = tasannpic_mmm(90-23:90+23, 1:360);
datat = treefracpic_mmm(90-23:90+23, 1:360);
datay22 = pramppic_mmm(90-23:90+23, 1:360);
datacc = tasamppic_mmm(90-23:90+23, 1:360);
datay2(isnan(datay1)) = nan;
datac(isnan(datay1)) = nan;
datat(isnan(datay1)) = nan;
datay22(isnan(datay1)) = nan;
datacc(isnan(datay1)) = nan;
datay1(datay2 < 100) = nan;
datac(datay2 < 100) = nan;
datat(datay2 < 100) = nan;
datay22(datay2 < 100) = nan;
datacc(datay2 < 100) = nan;
datay2(datay2 < 100) = nan;
xx = datay2(~isnan(datay2));
yy = datay1(~isnan(datay1));
cc = datac(~isnan(datac));
tt = datat(~isnan(datat));
xxx = datay22(~isnan(datay22));
ccc = datacc(~isnan(datacc));

bsens = nan(26, 2);
rsqua = nan(26, 1);
% starting from 300mm to 3400 mm, ¡À200mm
for i = 600 : 100 : 3100
    xpr = xx(xx >=i-500 & xx <=i+500);
    xta = cc(xx >=i-500 & xx <=i+500);
    yvg = yy(xx >=i-500 & xx <=i+500);
    [b,bint,r,rint,stats] = regress(yvg,[xpr xta]);
    bsens((i-500)/100,1) = b(1)*100;
    bsens((i-500)/100,2) = b(2);
    rsqua((i-500)/100) = stats(1);
end

figure,
yyaxis right
b1 = bar([600:100:3100]',rsqua);
b1.FaceColor = [0.9 0.9 0.8];
hold on,
xlabel('MAP (mm yr^{-1})')
ylabel('R^2')
set(gca,'YColor','k','YLim',[0 1])

yyaxis left
plot([600:100:3100]',bsens(:,1),'-','Color',[0.1 0.2 1])
hold on,
plot([600:100:3100]',bsens(:,2),'-','Color',[1 0.2 0.1])
% title('Multi-model mean')
set(gca,'XLim',[0 3600],'YColor','k','YLim',[-12 8])
ylabel('cVeg sensitivity (MgC ha^{-1} per 100mm or per 1^oC)')

%% 2. Observations, cVeg = a*MAP + b*MAT
clear,clc;
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
% landmask = landmask(ceil(0.5:0.5:180),ceil(0.5:0.5:360));
landmask = landmask(68:113,:);
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\biomass_tropics_1deg.mat
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

biomass(landmask ==0) = nan;
rain(landmask==0) = nan;
tair(landmask==0) = nan;

datay1 = biomass;
datay2 = rain;
datac = tair;
% datat = treefracpic_mmm(90-23:90+23, 1:360);
datay2(isnan(datay1)) = nan;
datac(isnan(datay1)) = nan;
datay1(datay2 < 100) = nan;
datac(datay2 < 100) = nan;
datay2(datay2 < 100) = nan;
datay1(isnan(datac)) = nan;
datay2(isnan(datac)) = nan;
% datat(isnan(datay1)) = nan;
xx = datay2(~isnan(datay2));
yy = datay1(~isnan(datay1));
cc = datac(~isnan(datac));

bsens = nan(26, 2);
rsqua = nan(26, 1);
% starting from 300mm to 3400 mm, ¡À200mm
for i = 600 : 100 : 3100
    xpr = xx(xx >=i-500 & xx <=i+500);
    xta = cc(xx >=i-500 & xx <=i+500);
    yvg = yy(xx >=i-500 & xx <=i+500);
    [b,bint,r,rint,stats] = regress(yvg,[xpr xta]);
    bsens((i-500)/100,1) = b(1)*100;
    bsens((i-500)/100,2) = b(2);
    rsqua((i-500)/100) = stats(1);
end

figure,
yyaxis right
b1 = bar([600:100:3100]',rsqua);
b1.FaceColor = [0.9 0.9 0.8];
hold on,
xlabel('MAP (mm yr^{-1})')
ylabel('R^2')
set(gca,'YColor','k','YLim',[0 1])

yyaxis left
plot([600:100:3100]',bsens(:,1),'-','Color',[0.1 0.2 1])
hold on,
plot([600:100:3100]',bsens(:,2),'-','Color',[1 0.2 0.1])
% title('Multi-model mean')
set(gca,'XLim',[0 3600],'YColor','k','YLim',[-12 8])
ylabel('cVeg sensitivity (MgC ha^{-1} per 100mm or per 1^oC)')

