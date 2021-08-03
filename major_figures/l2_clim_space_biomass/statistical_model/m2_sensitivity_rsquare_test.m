%% 1. CMIP6-LUMIP Method I

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
% load maskk.mat maskk

yveg = nan(47,360, 8);
xppt = nan(47,360, 8);
xpam = nan(47,360, 8);
xt2m = nan(47,360, 8);
xtam = nan(47,360, 8);
xtma = nan(47,360, 8);
xcwd = nan(47,360, 8);
xvpd = nan(47,360, 8);
xprd = nan(47,360, 8);

for vi = 1 : 8
    vegcannpic_mmm = vegcannpic(:,:,vi)*10;
    prannpic_mmm = prannpic(:,:,vi)*365;
    pramppic_mmm = pramppic(:,:,vi)*30;
    tasannpic_mmm = tasannpic(:,:,vi)-273.15;
    tasamppic_mmm = tasamppic(:,:,vi)-273.15;
    tasmaxannpic_mmm = tasmaxannpic(:,:,vi)-273.15;
    cwdpic_mmm = cwdpic(:,:,vi)*365;
    vpdpic_mmm = vpdpic(:,:,vi);
    prdpic_mmm = prdpic(:,:,vi)*365;
    
    dataveg = vegcannpic_mmm(90-23:90+23, 1:360);
    datapr = prannpic_mmm(90-23:90+23, 1:360);
    datapramp = pramppic_mmm(90-23:90+23, 1:360);
    datata = tasannpic_mmm(90-23:90+23, 1:360);
    datataamp = tasamppic_mmm(90-23:90+23, 1:360);
    datatamax = tasmaxannpic_mmm(90-23:90+23, 1:360);
    datacwd = cwdpic_mmm(90-23:90+23, 1:360);
    datavpd = vpdpic_mmm(90-23:90+23, 1:360);
    dataprd = prdpic_mmm(90-23:90+23, 1:360);
    
%     dataveg(isnan(maskk)) = nan;
%     datapr(isnan(maskk)) = nan;
%     datapramp(isnan(maskk)) = nan;
%     datata(isnan(maskk)) = nan;
%     datataamp(isnan(maskk)) = nan;
%     datatamax(isnan(maskk)) = nan;
%     datacwd(isnan(maskk)) = nan;
%     datavpd(isnan(maskk)) = nan;
%     dataprd(isnan(maskk)) = nan;
    
    yveg(:,:,vi) = dataveg;
    xppt(:,:,vi) = datapr;
    xpam(:,:,vi) = datapramp;
    xt2m(:,:,vi) = datata;
    xtam(:,:,vi) = datataamp;
    xtma(:,:,vi) = datatamax;
    xcwd(:,:,vi) = datacwd;
    xvpd(:,:,vi) = datavpd;
    xprd(:,:,vi) = dataprd;
    
end

validmat = [1 1 1 1 1 0 1 1; ... % yveg
            1 1 1 1 1 1 1 1; ... % xppt
            1 1 1 1 1 1 1 1; ... % xpam
            1 1 1 1 1 1 1 1; ... % xt2m
            1 1 1 1 1 1 1 1; ... % xtam
            1 1 0 1 1 1 1 1; ... % xtma
            1 1 1 1 1 1 1 0; ... % xcwd
            0 1 1 0 1 1 1 1; ... % xvpd
            1 1 1 1 1 1 1 1];    % xprd
    

%%
YY = yveg;
X1 = cat(4,xppt, xpam, xprd);
X2 = cat(4,xt2m, xtam, xtma, xcwd, xvpd);
matrix = nan(15,4); % coeff a, b, R2 and RMSE
for i = 1 : 3
    for j = 1 : 5
        xx1 = X1(:,:,:,i);
        xx2 = X2(:,:,:,j);
        yveg = YY;
        yveg(isnan(xx1)) = nan;
        yveg(isnan(xx2)) = nan;
        xx1(isnan(yveg)) = nan;
        xx2(isnan(yveg)) = nan;
        x1 = nanmean(xx1,3);
        x2 = nanmean(xx2,3);
        yy = nanmean(yveg,3);
        x1(isnan(maskk)) = nan;
        x2(isnan(maskk)) = nan;
        yy(isnan(maskk)) = nan;
        x1 = x1(~isnan(x1));
        x2 = x2(~isnan(x2));
        yy = yy(~isnan(yy));

        [b,bint,r,rint,stats] = regress(yy,[x1 x2]);
        matrix((i-1)*5+j, 1) = round(b(1),3);
        matrix((i-1)*5+j, 2) = round(b(2),3);
        matrix((i-1)*5+j, 3) = round(stats(1),3);
        matrix((i-1)*5+j, 4) = round(sqrt(sum((b(1)*x1+b(2)*x2-yy).^2)/length(yy)),3);
    end
end

%% 1. LUMIP-CMIP6 Method II-hh
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

dataveg = vegcannpic_mmm(90-23+1:90+23, 1:360);
datapr = prannpic_mmm(90-23+1:90+23, 1:360);
datapramp = pramppic_mmm(90-23+1:90+23, 1:360);
datata = tasannpic_mmm(90-23+1:90+23, 1:360);
datataamp = tasamppic_mmm(90-23+1:90+23, 1:360);
datatamax = tasmaxannpic_mmm(90-23+1:90+23, 1:360);
datacwd = cwdpic_mmm(90-23+1:90+23, 1:360);
datavpd = vpdpic_mmm(90-23+1:90+23, 1:360);
dataprd = prdpic_mmm(90-23+1:90+23, 1:360);

% dataveg = cat(2,vegcannpic_mmm(90-23:90+23, 1:70),vegcannpic_mmm(90-23:90+23, 255:360));
% datapr = cat(2,prannpic_mmm(90-23:90+23, 1:70),prannpic_mmm(90-23:90+23, 255:360));
% datapramp = cat(2,pramppic_mmm(90-23:90+23, 1:70),pramppic_mmm(90-23:90+23, 255:360));
% datata = cat(2,tasannpic_mmm(90-23:90+23, 1:70),tasannpic_mmm(90-23:90+23, 255:360));
% datataamp = cat(2,tasamppic_mmm(90-23:90+23, 1:70),tasamppic_mmm(90-23:90+23, 255:360));
% datatamax = cat(2,tasmaxannpic_mmm(90-23:90+23, 1:70),tasmaxannpic_mmm(90-23:90+23, 255:360));
% datacwd = cat(2,cwdpic_mmm(90-23:90+23, 1:70),cwdpic_mmm(90-23:90+23, 255:360));
% datavpd = cat(2,vpdpic_mmm(90-23:90+23, 1:70),vpdpic_mmm(90-23:90+23, 255:360));
% dataprd = cat(2,prdpic_mmm(90-23:90+23, 1:70),prdpic_mmm(90-23:90+23, 255:360));

load landmask.mat landmask
maskk = landmask;

% maskk(14:33,80:190) = nan;
figure,imagesc(maskk)

datapr(isnan(maskk)) = nan;
datapramp(isnan(maskk)) = nan;
datata(isnan(maskk)) = nan;
datataamp(isnan(maskk)) = nan;
datatamax(isnan(maskk)) = nan;
% datacwd(isnan(maskk)) = nan;
datavpd(isnan(maskk)) = nan;
dataprd(isnan(maskk)) = nan;
dataveg(isnan(maskk)) = nan;
figure,imagesc(dataveg)
% figure,imagesc(datapr)
% figure,imagesc(datata)
% figure,imagesc(datataamp)

yveg = dataveg(~isnan(dataveg));
xppt = datapr(~isnan(datapr));
xpam = datapramp(~isnan(datapramp));
xt2m = datata(~isnan(datata));
xtam = datataamp(~isnan(datataamp));
xtma = datatamax(~isnan(datatamax));
% xcwd = datacwd(~isnan(datacwd));
xvpd = datavpd(~isnan(datavpd));
xprd = dataprd(~isnan(dataprd));

X1 = [xppt xpam xprd];
X2 = [xt2m xtam xtma xvpd];
matrix = nan(12,4); % coeff a, b, R2, p and RMSE
for i = 1 : 3
    for j = 1 : 4
        x1 = X1(:,i);
        x2 = X2(:,j);
        [b,bint,r,rint,stats] = regress(yveg,[x1 x2]);
        matrix((i-1)*4+j, 1) = round(b(1),3);
        matrix((i-1)*4+j, 2) = round(b(2),3);
        matrix((i-1)*4+j, 3) = round(stats(1),2);
        matrix((i-1)*4+j, 4) = round(stats(3),4);
        matrix((i-1)*4+j, 5) = round(sqrt(sum((b(1)*x1+b(2)*x2-yveg).^2)/length(yveg)),1);
    end
end
mean(yveg)


vegbias = (matrix(1,1)*datapr+matrix(1,2)*datata)-dataveg;
tmp = vegbias;
vegbias(:,1:180) = tmp(:,181:360);
vegbias(:,181:360) = tmp(:,1:180);
vegbias(vegbias >=100) = 99.99;
vegbias(vegbias <=-100) = -99.99;
% figure,subplot(2,1,1)
% imagesc(vegbias)
% caxis([-120 100])
% colormap([1 1 1; parula(10)])
x1 = (matrix(1,1)*datapr+matrix(1,2)*datata);
x1 = x1(~isnan(x1));
x2 = dataveg(~isnan(dataveg));
x2 = x2(~isnan(x2));
figure,plot(x1,x2,'.')
hold on,
line([0 200],[0 200],'Color','k')
set(gca,'XLim',[0 200],'YLim',[0 200])
xlabel('Predicted biomass (MgC ha^{-1})')
ylabel('CMIP6 mean biomass (MgC ha^{-1}')
saveas(gcf,'mod_2params.jpg')

load D:\Study\rainfall_deforestation\2020.07.06.all_figures\major_figures\l2_clim_space_biomass\mod_sens_para.mat
bgc = nan(46,360);
for i = 1 : 46
    for j = 1 : 360
        if(isnan(datapr(i,j)))
            continue;
        end
        
        baspr = datapr(i,j);
        if(baspr < 600)
            idx = 1;
        elseif(baspr >3100)
            idx = 26;
        else
            idx = uint64(floor(baspr/100)-5);
        end
        bgc(i,j) = bsens(idx,1)/100*datapr(i,j)+bsens(idx,2)*datata(i,j);
    end
end
vegbias = bgc-dataveg;
tmp = vegbias;
vegbias(:,1:180) = tmp(:,181:360);
vegbias(:,181:360) = tmp(:,1:180);
vegbias(vegbias >=100) = 99.99;
vegbias(vegbias <=-100) = -99.99;
% subplot(2,1,2)
% imagesc(vegbias)
% caxis([-120 100])
% colormap([1 1 1; parula(10)])
% colorbar
x1 = bgc;
x1 = x1(~isnan(x1));
x2 = dataveg;
x2 = x2(~isnan(x2));
figure,plot(x1,x2,'.')
hold on,
line([0 200],[0 200],'Color','k')
set(gca,'XLim',[0 200],'YLim',[0 200])
xlabel('Predicted biomass (MgC ha^{-1})')
ylabel('CMIP6 mean biomass (MgC ha^{-1}')
saveas(gcf,'mod_rainrange.jpg')


%% 1. LUMIP-CMIP6 Method II -Each model
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
matrix = nan(12,4,8); % coeff a, b, R2, p and RMSE

for vi = 1 : 8
    if(vi == 6) 
        continue;
    end
vegcannpic_mmm = vegcannpic(:,:,vi)*10;
prannpic_mmm = prannpic(:,:,vi)*365;
pramppic_mmm = pramppic(:,:,vi)*30;
tasannpic_mmm = tasannpic(:,:,vi)-273.15;
tasamppic_mmm = tasamppic(:,:,vi)-273.15;
tasmaxannpic_mmm = tasmaxannpic(:,:,vi)-273.15;
cwdpic_mmm = cwdpic(:,:,vi)*365;
vpdpic_mmm = vpdpic(:,:,vi);
prdpic_mmm = prdpic(:,:,vi)*365;

dataveg = vegcannpic_mmm(90-23:90+23, 1:360);
datapr = prannpic_mmm(90-23:90+23, 1:360);
datapramp = pramppic_mmm(90-23:90+23, 1:360);
datata = tasannpic_mmm(90-23:90+23, 1:360);
datataamp = tasamppic_mmm(90-23:90+23, 1:360);
datatamax = tasmaxannpic_mmm(90-23:90+23, 1:360);
datacwd = cwdpic_mmm(90-23:90+23, 1:360);
datavpd = vpdpic_mmm(90-23:90+23, 1:360);
dataprd = prdpic_mmm(90-23:90+23, 1:360);

% dataveg = cat(2,vegcannpic_mmm(90-23:90+23, 1:70),vegcannpic_mmm(90-23:90+23, 255:360));
% datapr = cat(2,prannpic_mmm(90-23:90+23, 1:70),prannpic_mmm(90-23:90+23, 255:360));
% datapramp = cat(2,pramppic_mmm(90-23:90+23, 1:70),pramppic_mmm(90-23:90+23, 255:360));
% datata = cat(2,tasannpic_mmm(90-23:90+23, 1:70),tasannpic_mmm(90-23:90+23, 255:360));
% datataamp = cat(2,tasamppic_mmm(90-23:90+23, 1:70),tasamppic_mmm(90-23:90+23, 255:360));
% datatamax = cat(2,tasmaxannpic_mmm(90-23:90+23, 1:70),tasmaxannpic_mmm(90-23:90+23, 255:360));
% datacwd = cat(2,cwdpic_mmm(90-23:90+23, 1:70),cwdpic_mmm(90-23:90+23, 255:360));
% datavpd = cat(2,vpdpic_mmm(90-23:90+23, 1:70),vpdpic_mmm(90-23:90+23, 255:360));
% dataprd = cat(2,prdpic_mmm(90-23:90+23, 1:70),prdpic_mmm(90-23:90+23, 255:360));

maskk = dataveg;
maskk(maskk==0) = nan;
maskk(isnan(datapr)) = nan;
maskk(isnan(datapramp)) = nan;
maskk(isnan(datata)) = nan;
maskk(isnan(datataamp)) = nan;
if(vi ~=3)
maskk(isnan(datatamax)) = nan;
end
if(vi ~=8)
maskk(isnan(datacwd)) = nan;
end
if(vi~=1 && vi~=4)
maskk(isnan(datavpd)) = nan;
end
maskk(datapr < 100) = nan;

datapr(isnan(maskk)) = nan;
datapramp(isnan(maskk)) = nan;
datata(isnan(maskk)) = nan;
datataamp(isnan(maskk)) = nan;
datatamax(isnan(maskk)) = nan;
datacwd(isnan(maskk)) = nan;
datavpd(isnan(maskk)) = nan;
dataprd(isnan(maskk)) = nan;
dataveg(isnan(maskk)) = nan;

yveg = dataveg(~isnan(dataveg));
xppt = datapr(~isnan(datapr));
xpam = datapramp(~isnan(datapramp));
xt2m = datata(~isnan(datata));
xtam = datataamp(~isnan(datataamp));
xtma = datatamax(~isnan(datatamax));
xcwd = datacwd(~isnan(datacwd));
xvpd = datavpd(~isnan(datavpd));
xprd = dataprd(~isnan(dataprd));

X1 = [xppt xpam xprd];
if(vi ==1 || vi ==4)
    X2 = [xt2m xtam xtma nan(length(xt2m),1)];
elseif(vi == 3)
    X2 = [xt2m xtam nan(length(xt2m),1) xvpd];
elseif(vi ==8)
    X2 = [xt2m xtam xtma xvpd];
else
    X2 = [xt2m xtam xtma xvpd];
end
for i = 1 : 3
    for j = 1 : 4
        x1 = X1(:,i);
        x2 = X2(:,j);
        x2 = x2(~isnan(x2));
        if(isempty(x2))
            continue;
        end
        [b,bint,r,rint,stats] = regress(yveg,[x1 x2]);
        matrix((i-1)*4+j, 1,vi) = round(b(1),3);
        matrix((i-1)*4+j, 2,vi) = round(b(2),3);
        matrix((i-1)*4+j, 3,vi) = round(stats(1),2);
        matrix((i-1)*4+j, 4,vi) = round(sqrt(sum((b(1)*x1+b(2)*x2-yveg).^2)/length(yveg)),1);
    end
end
end

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

figure,imagesc(tair)
landmask = tair;
landmask(isnan(biomass)) = nan;
landmask(rain < 100) = nan;
save landmask.mat landmask


biomass(isnan(landmask)) = nan;
rain(isnan(landmask)) = nan;
tair(isnan(landmask)) = nan;
tmax(isnan(landmask)) = nan;
rainamp(isnan(landmask)) = nan;
tairamp(isnan(landmask)) = nan;
% cwd(isnan(landmask)) = nan;
vpd(isnan(landmask)) = nan;
prd(isnan(landmask)) = nan;

datay1 = biomass;
datay2 = rain;
datac = tair;
datay22 = rainamp;
datacc = tairamp;
% data222 = cwd;
dataccc = vpd;
data2cc = prd;
data22c = tmax;
xppt = datay2(~isnan(datay2));
yveg = datay1(~isnan(datay1));
xt2m = datac(~isnan(datac));
xpam = datay22(~isnan(datay22));
xtam = datacc(~isnan(datacc));
% xcwd = data222(~isnan(data222));
xvpd = dataccc(~isnan(dataccc));
xprd = data2cc(~isnan(data2cc));
xtma = data22c(~isnan(data22c));

X1 = [xppt xpam xprd];
X2 = [xt2m xtam xtma xvpd];
matrix = nan(12,5); % coeff a, b, R2,p and RMSE
for i = 1 : 3
    for j = 1 : 4
        x1 = X1(:,i);
        x2 = X2(:,j);
        [b,bint,r,rint,stats] = regress(yveg,[x1 x2]);
        matrix((i-1)*4+j, 1) = round(b(1),3);
        matrix((i-1)*4+j, 2) = round(b(2),3);
        matrix((i-1)*4+j, 3) = round(stats(1),2);
        matrix((i-1)*4+j, 4) = round(stats(3),4);
        matrix((i-1)*4+j, 5) = round(sqrt(sum((b(1)*x1+b(2)*x2-yveg).^2)/length(yveg)),1);
    end
end

mean(yveg)

vegbias = (matrix(1,1)*rain+matrix(1,2)*tair)-biomass;
tmp = vegbias;
vegbias(:,1:180) = tmp(:,181:360);
vegbias(:,181:360) = tmp(:,1:180);
vegbias(vegbias >=100) = 99.99;
vegbias(vegbias <=-100) = -99.99;
% figure,subplot(2,1,1)
% imagesc(vegbias)
% caxis([-120 100])
% colormap([1 1 1; parula(10)])
x1 = (matrix(1,1)*rain+matrix(1,2)*tair);
x1 = x1(~isnan(x1));
x2 = biomass(~isnan(biomass));
x2 = x2(~isnan(x2));
figure,plot(x1,x2,'.')
hold on,
line([0 350],[0 350],'Color','k')
set(gca,'XLim',[0 350],'YLim',[0 350])
xlabel('Predicted biomass (MgC ha^{-1})')
ylabel('Data-based biomass (MgC ha^{-1}')
saveas(gcf,'obs_2params.jpg')


load D:\Study\rainfall_deforestation\2020.07.06.all_figures\major_figures\l2_clim_space_biomass\obs_sens_para.mat
bgc = nan(46,360);
for i = 1 : 46
    for j = 1 : 360
        if(isnan(rain(i,j)))
            continue;
        end
        
        baspr = rain(i,j);
        if(baspr < 600)
            idx = 1;
        elseif(baspr >3100)
            idx = 26;
        else
            idx = uint64(floor(baspr/100)-5);
        end
        bgc(i,j) = bsens(idx,1)/100*rain(i,j)+bsens(idx,2)*tair(i,j);
    end
end
vegbias = bgc-biomass;
tmp = vegbias;
vegbias(:,1:180) = tmp(:,181:360);
vegbias(:,181:360) = tmp(:,1:180);
vegbias(vegbias >=100) = 99.99;
vegbias(vegbias <=-100) = -99.99;
% subplot(2,1,2)
% imagesc(vegbias)
% caxis([-120 100])
% colormap([1 1 1; parula(10)])
% colorbar
x1 = bgc;
x1 = x1(~isnan(x1));
x2 = biomass(~isnan(biomass));
x2 = x2(~isnan(x2));
figure,plot(x1,x2,'.')
hold on,
line([0 350],[0 350],'Color','k')
set(gca,'XLim',[0 350],'YLim',[0 350])
xlabel('Predicted biomass (MgC ha^{-1})')
ylabel('Data-based biomass (MgC ha^{-1}')
saveas(gcf,'obs_rainrange.jpg')
