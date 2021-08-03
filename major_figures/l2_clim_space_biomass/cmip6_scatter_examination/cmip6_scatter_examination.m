%% 1. Model-mean-piControl
path= 'D:\Study\rainfall_deforestation\2020.05.12.physics_bar\';
prama = ncread([path,'l1.prepare_data\pr_Amazon_congo_Asa_piControl_lst30lumip.nc'],'prama');
prcon = ncread([path,'l1.prepare_data\pr_Amazon_congo_Asa_piControl_lst30lumip.nc'],'prcon');
prasa = ncread([path,'l1.prepare_data\pr_Amazon_congo_Asa_piControl_lst30lumip.nc'],'prasa');
% piControl (30yr, ann-wet-dry, models)
amapr = ncread([path,'l1.prepare_data\pr_Amazon_congo_Asa_piControl_lst30lumip.nc'],'amapr');
conpr = ncread([path,'l1.prepare_data\pr_Amazon_congo_Asa_piControl_lst30lumip.nc'],'conpr');
asapr = ncread([path,'l1.prepare_data\pr_Amazon_congo_Asa_piControl_lst30lumip.nc'],'asapr');
data_def = reshape(prama(:,1,:)*86400*365,30,8);
data_piC = reshape(amapr(:,1,:)*86400*365,30,8);
amaprldef = mean(mean(data_def,1));
amaprlpic = mean(mean(data_piC,1));
data_def = reshape(prcon(:,1,:)*86400*365,30,8);
data_piC = reshape(conpr(:,1,:)*86400*365,30,8);
conprldef = mean(mean(data_def,1));
conprlpic = mean(mean(data_piC,1));
data_def = reshape(prasa(:,1,:)*86400*365,30,8);
data_piC = reshape(asapr(:,1,:)*86400*365,30,8);
asaprldef = mean(mean(data_def,1));
asaprlpic = mean(mean(data_piC,1));

path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
load([path,'treeFrac_30yrmean_pattern.mat'])
load([path,'Biomass_30yrmean_pattern_new.mat'])
load([path,'MAP_30yrmean_pattern.mat'])
load([path,'MAT_30yrmean_pattern.mat'])
modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR','Multimodel mean'};
prannpic(isnan(vegcannpic)) = nan;
tasannpic(isnan(vegcannpic)) = nan;
vegcannpic = nanmean(vegcannpic,3);
prannpic = nanmean(prannpic,3);
tasannpic = nanmean(tasannpic,3);

figure,
datam = [amaprldef conprldef asaprldef; amaprlpic conprlpic asaprlpic];
color = [1 0.6 0.2; 0.6 1 0.2; 0.2 0.6 1];
for i = 1 : 3
    dtt = datam(:,i);
    line([dtt(2) dtt(2)],[12.2 31],'Color',color(i,:),'LineStyle','-','LineWidth',1.5)
    line([dtt(1) dtt(1)],[12.2 31],'Color',color(i,:),'LineStyle','--','LineWidth',1.5)
    hold on,
%     dttt = (dtt(1)-dtt(2))/20;
%     dttt
%     cnt = dtt(2);
%     for j = 1 : 20
%         xf = [cnt cnt+j*dttt cnt+j*dttt cnt];
%         yf = [12.2 12.2 31 31];
%         pf(j) = fill(xf,yf,'b','FaceColor',color(i,:),'EdgeColor','none');
%         pf(j).FaceAlpha = (1-(log10(11-ceil(j/2))))*0.1;
%         hold on,
%         cnt = cnt+dttt;
%     end
end
% line([750 750],[14 16],'Color','k','LineStyle','-','LineWidth',1.5)
% line([250 250],[14 16],'Color','k','LineStyle','--','LineWidth',1.5)
% subplot(2,2,2),
datac = vegcannpic(90-23:90+23, 1:360)*10;
datax = prannpic(90-23:90+23, 1:360)*365;
datay = tasannpic(90-23:90+23, 1:360)-273.15;
lmk = landmask(90-23:90+23,1:360);
datac(lmk ==0) = nan;
datax(lmk ==0) = nan;
datay(lmk ==0) = nan;
datax(isnan(datac)) = nan;
datay(isnan(datac)) = nan;

datax(datax<100) = nan;
datay(isnan(datax)) = nan;
datac(isnan(datax)) = nan;

xx = datax(~isnan(datax));
yy = datay(~isnan(datay));
cc = datac(~isnan(datac));


scatter(xx,yy,8,cc,'o','filled')
cmp = flipud(parula);
colormap(cmp)
colorbar,
caxis([0 170])
box on
hcb = colorbar;
title('CMIP6-piControl mean')
colorTitleHandle = get(hcb,'Title');
titleString = 'Biomass (MgC ha^{-1})';
set(colorTitleHandle ,'String',titleString);
set(gca,'XLim',[0 3600],'YLim',[12.2 31])
% caxis([0 250])
xlabel('MAP (mm yr^{-1})')
ylabel('MAT (^oC)')


%% 2. Model-mean-piControl - each model
clear,clc;

path= 'D:\Study\rainfall_deforestation\2020.05.12.physics_bar\';
prama = ncread([path,'l1.prepare_data\pr_Amazon_congo_Asa_piControl_lst30lumip.nc'],'prama');
prcon = ncread([path,'l1.prepare_data\pr_Amazon_congo_Asa_piControl_lst30lumip.nc'],'prcon');
prasa = ncread([path,'l1.prepare_data\pr_Amazon_congo_Asa_piControl_lst30lumip.nc'],'prasa');
% piControl (30yr, ann-wet-dry, models)
amapr = ncread([path,'l1.prepare_data\pr_Amazon_congo_Asa_piControl_lst30lumip.nc'],'amapr');
conpr = ncread([path,'l1.prepare_data\pr_Amazon_congo_Asa_piControl_lst30lumip.nc'],'conpr');
asapr = ncread([path,'l1.prepare_data\pr_Amazon_congo_Asa_piControl_lst30lumip.nc'],'asapr');
data_def = reshape(prama(:,1,:)*86400*365,30,8);
data_piC = reshape(amapr(:,1,:)*86400*365,30,8);
amaprldef = mean(mean(data_def,1));
amaprlpic = mean(mean(data_piC,1));
data_def = reshape(prcon(:,1,:)*86400*365,30,8);
data_piC = reshape(conpr(:,1,:)*86400*365,30,8);
conprldef = mean(mean(data_def,1));
conprlpic = mean(mean(data_piC,1));
data_def = reshape(prasa(:,1,:)*86400*365,30,8);
data_piC = reshape(asapr(:,1,:)*86400*365,30,8);
asaprldef = mean(mean(data_def,1));
asaprlpic = mean(mean(data_piC,1));

path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
load([path,'treeFrac_30yrmean_pattern.mat'])
load([path,'Biomass_30yrmean_pattern_new.mat'])
load([path,'MAP_30yrmean_pattern.mat'])
load([path,'MAT_30yrmean_pattern.mat'])
modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR','Multimodel mean'};
prannpic(isnan(vegcannpic)) = nan;
tasannpic(isnan(vegcannpic)) = nan;

for mi = 1 : 8
% vegcannpic = nanmean(vegcannpic,3);
% prannpic = nanmean(prannpic,3);
% tasannpic = nanmean(tasannpic,3);

vegcannpic2 = vegcannpic(:,:,mi);
prannpic2 = prannpic(:,:,mi);
tasannpic2 = tasannpic(:,:,mi);

figure,
datam = [amaprldef conprldef asaprldef; amaprlpic conprlpic asaprlpic];
color = [1 0.6 0.2; 0.6 1 0.2; 0.2 0.6 1];
for i = 1 : 3
    dtt = datam(:,i);
    line([dtt(2) dtt(2)],[12.2 31],'Color',color(i,:),'LineStyle','-','LineWidth',1.5)
    line([dtt(1) dtt(1)],[12.2 31],'Color',color(i,:),'LineStyle','--','LineWidth',1.5)
    hold on,
%     dttt = (dtt(1)-dtt(2))/20;
%     dttt
%     cnt = dtt(2);
%     for j = 1 : 20
%         xf = [cnt cnt+j*dttt cnt+j*dttt cnt];
%         yf = [12.2 12.2 31 31];
%         pf(j) = fill(xf,yf,'b','FaceColor',color(i,:),'EdgeColor','none');
%         pf(j).FaceAlpha = (1-(log10(11-ceil(j/2))))*0.1;
%         hold on,
%         cnt = cnt+dttt;
%     end
end
% line([750 750],[14 16],'Color','k','LineStyle','-','LineWidth',1.5)
% line([250 250],[14 16],'Color','k','LineStyle','--','LineWidth',1.5)
% subplot(2,2,2),
datac = vegcannpic2(90-23:90+23, 1:360)*10;
datax = prannpic2(90-23:90+23, 1:360)*365;
datay = tasannpic2(90-23:90+23, 1:360)-273.15;
lmk = landmask(90-23:90+23,1:360);
datac(lmk ==0) = nan;
datax(lmk ==0) = nan;
datay(lmk ==0) = nan;
datax(isnan(datac)) = nan;
datay(isnan(datac)) = nan;

datax(datax<100) = nan;
datay(isnan(datax)) = nan;
datac(isnan(datax)) = nan;

xx = datax(~isnan(datax));
yy = datay(~isnan(datay));
cc = datac(~isnan(datac));


scatter(xx,yy,8,cc,'o','filled')
cmp = flipud(parula);
colormap(cmp)
colorbar,
caxis([0 170])
box on
hcb = colorbar;
title(modelname{mi})
colorTitleHandle = get(hcb,'Title');
titleString = '    MgC ha^{-1}';
set(colorTitleHandle ,'String',titleString);
set(gca,'XLim',[0 3600],'YLim',[12.2 31])
% caxis([0 250])
xlabel('MAP (mm yr^{-1})')
ylabel('MAT (^oC)')

end