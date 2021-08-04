%% show the biomass in climate space
clear,clc;

% 1. Observations
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
figure,
% subplot(2,2,1),
scatter(xx,yy,8,cc,'o','filled')
cmp = flipud(parula);
colormap(cmp)
colorbar,
box on
hcb = colorbar;
title('Observations')
colorTitleHandle = get(hcb,'Title');
titleString = 'Biomass (MgC ha^{-1})';
set(colorTitleHandle ,'String',titleString);
set(gca,'XLim',[0 3600],'YLim',[12.2 31])
% caxis([0 250])
% colorbar('off')
xlabel('MAP (mm yr^{-1})')
ylabel('MAT (^oC)')

% 2. Model-mean-piControl
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
load([path,'treeFrac_30yrmean_pattern.mat'])
load([path,'Biomass_30yrmean_pattern.mat'])
load([path,'MAP_30yrmean_pattern.mat'])
load([path,'MAT_30yrmean_pattern.mat'])
modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR','Multimodel mean'};
prannpic(isnan(vegcannpic)) = nan;
tasannpic(isnan(vegcannpic)) = nan;
vegcannpic = nanmean(vegcannpic,3);
prannpic = nanmean(prannpic,3);
tasannpic = nanmean(tasannpic,3);

figure,
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
%     saveas(gcf, ['clim_space.',modelname{vi},'.jpg'],'jpg');


%% NEW - show the biomass in climate space
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
% 1. Observations
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
biomass(landmask ==0) = nan;
rain(landmask==0) = nan;
tair(landmask==0) = nan;
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
figure,
datam = [amaprldef conprldef asaprldef; amaprlpic conprlpic asaprlpic];
color = [1 0.6 0.2; 0.6 1 0.2; 0.2 0.6 1];
obspr = [2314, 1627, 3311];
txt = {'Amazon','Congo','tropAsia'};
intv = [100 -100 100];
for i = 1 : 3
    dtt = datam(:,i);
    line([obspr(i) obspr(i)],[12.2 31],'Color',color(i,:),'LineStyle','-','LineWidth',1.5)
    line([obspr(i)+(dtt(1)-dtt(2)) obspr(i)+(dtt(1)-dtt(2))],[12.2 31],'Color',color(i,:),'LineStyle','--','LineWidth',1.5)
    text(obspr(i)+intv(i),17,txt{i},'Rotation',-90,'Color',color(i,:),'FontSize',12)
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
line([750 750],[14 16],'Color','k','LineStyle','-','LineWidth',1.5)
line([250 250],[14 16],'Color','k','LineStyle','--','LineWidth',1.5)
% subplot(2,2,1),
scatter(xx,yy,8,cc,'o','filled')
cmp = flipud(parula);
colormap(cmp)
colorbar,
caxis([0 170])
box on
hcb = colorbar;
title('Observations')
colorTitleHandle = get(hcb,'Title');
titleString = 'Biomass (MgC ha^{-1})';
set(colorTitleHandle ,'String',titleString);
set(gca,'XLim',[0 3600],'YLim',[12.2 31])
% caxis([0 250])
% colorbar('off')
xlabel('MAP (mm yr^{-1})')
ylabel('MAT (^oC)')

% 2. Model-mean-piControl
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
%     saveas(gcf, ['clim_space.',modelname{vi},'.jpg'],'jpg');


%% box plot - Observations
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

bsens = nan(26, 2);
rsqua = nan(26, 1);
pval = nan(26, 1);

% starting from 300mm to 3400 mm, ¡À200mm
for i = 600 : 100 : 3100
    xpr = xx(xx >=i-500 & xx <=i+500);
    xta = yy(xx >=i-500 & xx <=i+500);
    yvg = cc(xx >=i-500 & xx <=i+500);
    [b,bint,r,rint,stats] = regress(yvg,[xpr xta]);
    bsens((i-500)/100,1) = b(1)*100;
    bsens((i-500)/100,2) = b(2);
    rsqua((i-500)/100) = stats(1);
    pval((i-500)/100) = stats(3);
end
bsens(20:26,:) = 0; % because p value > 0.001
% save obs_sens_para.mat bsens rsqua pval

data = nan(7, 2);
data2 = nan(7, 2);
for i = 1 : 7 % starting from 100mm, every 500mm, 100-600-1100-1600-2100-2600-3100-3600
    idx1 = find(xx >=500*(i-1) & xx < 500+500*(i-1) & yy <= 25);
    idx2 = find(xx >=500*(i-1) & xx < 500+500*(i-1) & yy > 25);
%     length(idx1)
%     length(idx2)
    data(i,1) = mean(cc(idx1));
    data(i,2) = mean(cc(idx2));
    data2(i,1) = std(cc(idx1));
    data2(i,2) = std(cc(idx2));
%     if(i == 1)
%         data = [cc(idx2) cc(idx1)];
%     else
%         data = [data cc(idx2) cc(idx1)];
%     end
end
figure('position',[680 558 560 360]),
% b1 = bar(data);
% set(gca,'XLim',[0.5 7.7],'YLim',[0 350],...
%     'XTick',[1.5:1:7.5],'XTickLabel',{'500','1000','1500','2000','2500','3000','3500'})
% b1(1).FaceColor=[0.2 0.6 0.8];
% b1(1).EdgeColor = 'none';
% b1(2).FaceColor=[0.8 0.3 0.3];
% b1(2).EdgeColor = 'none';
% hold on,
% for i = 1 : 7
%     line([i-0.15 i-0.15],[data(i,1) data(i,1)+data2(i,1)],'LineWidth',1.2)
%     line([i+0.15 i+0.15],[data(i,2) data(i,2)+data2(i,2)],'LineWidth',1.2)
% end
% xlabel('MAP (mm yr^{-1})')
% ylabel('Biomass (MgC ha^{-1})')
% % legend('MAT<=25^oC','MAT>25^oC','location','best')

p1=plot([600:100:2400]',bsens(1:19,1),'-o','Color',[0.1 0.2 1],'MarkerFaceColor'...
    ,[0.1 0.2 1],'MarkerSize',6.5,'LineWidth',2);
hold on,
% p1=plot([2400:100:3100]',bsens(19:26,1),'-','Color',[0.1 0.2 1],'LineWidth',2);
% scatter([600:100:2400]',bsens(1:19,1),30,'MarkerFaceColor',[0.1 0.2 1],'MarkerEdgeColor','none')
% line([0 3600],[0 0],'Color','k','LineStyle','--')
set(gca,'XLim',[0 3600],'YColor',[0.1 0.2 1],'YLim',[-3 9])
ylabel('MgC ha^{-1} /100mm yr^{-1}')
xlabel('MAP (mm yr^{-1})')

yyaxis right
p2=plot([600:100:2400]',bsens(1:19,2),'-o','Color',[1 0.2 0.1],'MarkerFaceColor'...
    ,[1 0.2 0.1],'MarkerSize',6.5,'LineWidth',2);
hold on
% p2=plot([2400:100:3100]',bsens(19:26,2),'-','Color',[1 0.2 0.1],'LineWidth',2);
% scatter([600:100:2400]',bsens(1:19,2),30,'MarkerFaceColor',[1 0.2 0.1])
% title('Multi-model mean')
set(gca,'XLim',[0 3600],'YColor',[1 0.2 0.1],'YLim',[-3 9])
ylabel('MgC ha^{-1} /^oC')
% legend('Rainfall sensitivity','Temperature sensitivity','location','northwest')
% legend('boxoff')
legendLabel = {'Rainfall sensitivity','Temperature sensitivity'};
ah1=axes('position',get(gca,'position'),...
    'visible','off');
h1 = legend(ah1,[p1 p2],legendLabel{:});
set(h1,'EdgeColor','white','fontsize',8)
% set(gca,'OuterPosition',[-0.18 0.08 0.4319 0.1948])
% get(gca,'OuterPosition')
    

%% box plot - Model
clear,clc;
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

datac = vegcannpic(90-23:90+23, 1:360)*10;
datax = prannpic(90-23:90+23, 1:360)*365;
datay = tasannpic(90-23:90+23, 1:360)-273.15;
lmk = landmask(90-23:90+23,1:360);
% datac(lmk ==0) = nan;
% datax(lmk ==0) = nan;
% datay(lmk ==0) = nan;
datac(lmk <0.5) = nan;
datax(lmk <0.5) = nan;
datay(lmk <0.5) = nan;

datax(isnan(datac)) = nan;
datay(isnan(datac)) = nan;

datax(datax<100) = nan;
datay(isnan(datax)) = nan;
datac(isnan(datax)) = nan;

xx = datax(~isnan(datax));
yy = datay(~isnan(datay));
cc = datac(~isnan(datac));

bsens = nan(26, 2);
rsqua = nan(26, 1);
pval = nan(26,1);
% starting from 300mm to 3400 mm, ¡À200mm
for i = 600 : 100 : 3100
    xpr = xx(xx >=i-500 & xx <=i+500);
    xta = yy(xx >=i-500 & xx <=i+500);
    yvg = cc(xx >=i-500 & xx <=i+500);
    [b,bint,r,rint,stats] = regress(yvg,[xpr xta]);
    bsens((i-500)/100,1) = b(1)*100;
    bsens((i-500)/100,2) = b(2);
    rsqua((i-500)/100) = stats(1);
    pval((i-500)/100) = stats(3);
end
% save mod_sens_para.mat bsens rsqua pval

data = nan(7, 2);
data2 = nan(7, 2);
for i = 1 : 7 % starting from 100mm, every 500mm, 100-600-1100-1600-2100-2600-3100-3600
    idx1 = find(xx >=500*(i-1) & xx < 500+500*(i-1) & yy <= 25);
    idx2 = find(xx >=500*(i-1) & xx < 500+500*(i-1) & yy > 25);
%     length(idx1)
%     length(idx2)
    data(i,1) = mean(cc(idx1));
    data(i,2) = mean(cc(idx2));
    data2(i,1) = std(cc(idx1));
    data2(i,2) = std(cc(idx2));
%     if(i == 1)
%         data = [cc(idx2) cc(idx1)];
%     else
%         data = [data cc(idx2) cc(idx1)];
%     end
end
figure('position',[680 558 560 360]),
% b1 = bar(data);
% set(gca,'XLim',[0.5 7.7],...
%     'XTick',[1.5:1:7.5],'XTickLabel',{'500','1000','1500','2000','2500','3000','3500'})
% b1(1).FaceColor=[0.2 0.6 0.8];
% b1(1).EdgeColor = 'none';
% b1(2).FaceColor=[0.8 0.3 0.3];
% b1(2).EdgeColor = 'none';
% hold on,
% for i = 1 : 7
%     line([i-0.15 i-0.15],[data(i,1) data(i,1)+data2(i,1)],'LineWidth',1.2)
%     line([i+0.15 i+0.15],[data(i,2) data(i,2)+data2(i,2)],'LineWidth',1.2)
% end
% xlabel('MAP (mm yr^{-1})')
% ylabel('Biomass (MgC ha^{-1})')
% legend('MAT<=25^oC','MAT>25^oC','location','best')
    
plot([600:100:3100]',bsens(1:26,1),'-o','Color',[0.1 0.2 1],'MarkerFaceColor'...
    ,[0.1 0.2 1],'MarkerSize',6.5,'LineWidth',2);
hold on,
p1=plot([2400:100:3100]',bsens(19:26,1),'-','Color',[0.1 0.2 1],'LineWidth',2);
% scatter([600:100:2400]',bsens(1:19,1),30,'MarkerFaceColor',[0.1 0.2 1],'MarkerEdgeColor','none')
% line([0 3600],[0 0],'Color','k','LineStyle','--')
set(gca,'XLim',[0 3600],'YColor',[0.1 0.2 1],'YLim',[-3 9])
ylabel('MgC ha^{-1} /100mm yr^{-1}')
xlabel('MAP (mm yr^{-1})')

yyaxis right
plot([600:100:3100]',bsens(1:26,2),'-o','Color',[1 0.2 0.1],'MarkerFaceColor'...
    ,[1 0.2 0.1],'MarkerSize',6.5,'LineWidth',2);
hold on
p2=plot([2400:100:3100]',bsens(19:26,2),'-','Color',[1 0.2 0.1],'LineWidth',2);
% scatter([600:100:2400]',bsens(1:19,2),30,'MarkerFaceColor',[1 0.2 0.1])
% title('Multi-model mean')
set(gca,'XLim',[0 3600],'YColor',[1 0.2 0.1],'YLim',[-3 9])
ylabel('MgC ha^{-1} /^oC')


%% Together
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
% 1. Observations
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
figure,
subplot(2,2,1)
datam = [amaprldef conprldef asaprldef; amaprlpic conprlpic asaprlpic];
color = [1 0.6 0.2; 0.6 1 0.2; 0.2 0.6 1];
obspr = [2314, 1627, 3311];
txt = {'Amazon','Congo','tropAsia'};
intv = [100 -100 100];
for i = 1 : 3
    dtt = datam(:,i);
    line([obspr(i) obspr(i)],[12.2 31],'Color',color(i,:),'LineStyle','-','LineWidth',1.5)
    line([obspr(i)+(dtt(1)-dtt(2)) obspr(i)+(dtt(1)-dtt(2))],[12.2 31],'Color',color(i,:),'LineStyle','--','LineWidth',1.5)
    text(obspr(i)+intv(i),17,txt{i},'Rotation',-90,'Color',color(i,:),'FontSize',12)
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
line([750 750],[14 16],'Color','k','LineStyle','-','LineWidth',1.5)
line([250 250],[14 16],'Color','k','LineStyle','--','LineWidth',1.5)
% subplot(2,2,1),
scatter(xx,yy,8,cc,'o','filled')
cmp = flipud(parula);
colormap(cmp)
colorbar,
box on
hcb = colorbar;
title('Observations')
colorTitleHandle = get(hcb,'Title');
titleString = 'Biomass (MgC ha^{-1})';
set(colorTitleHandle ,'String',titleString);
set(gca,'XLim',[0 3600],'YLim',[12.2 31])
% caxis([0 250])
% colorbar('off')
xlabel('MAP (mm yr^{-1})')
ylabel('MAT (^oC)')

% 2. Model-mean-piControl
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
load([path,'treeFrac_30yrmean_pattern.mat'])
load([path,'Biomass_30yrmean_pattern.mat'])
load([path,'MAP_30yrmean_pattern.mat'])
load([path,'MAT_30yrmean_pattern.mat'])
modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR','Multimodel mean'};
prannpic(isnan(vegcannpic)) = nan;
tasannpic(isnan(vegcannpic)) = nan;
vegcannpic = nanmean(vegcannpic,3);
prannpic = nanmean(prannpic,3);
tasannpic = nanmean(tasannpic,3);

subplot(2,2,2),
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
%     saveas(gcf, ['clim_space.',modelname{vi},'.jpg'],'jpg');


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

bsens = nan(26, 2);
rsqua = nan(26, 1);
pval = nan(26, 1);

% starting from 300mm to 3400 mm, ¡À200mm
for i = 600 : 100 : 3100
    xpr = xx(xx >=i-500 & xx <=i+500);
    xta = yy(xx >=i-500 & xx <=i+500);
    yvg = cc(xx >=i-500 & xx <=i+500);
    [b,bint,r,rint,stats] = regress(yvg,[xpr xta]);
    bsens((i-500)/100,1) = b(1)*100;
    bsens((i-500)/100,2) = b(2);
    rsqua((i-500)/100) = stats(1);
    pval((i-500)/100) = stats(3);
end
save obs_sens_para.mat bsens rsqua pval

data = nan(7, 2);
data2 = nan(7, 2);
for i = 1 : 7 % starting from 100mm, every 500mm, 100-600-1100-1600-2100-2600-3100-3600
    idx1 = find(xx >=500*(i-1) & xx < 500+500*(i-1) & yy <= 25);
    idx2 = find(xx >=500*(i-1) & xx < 500+500*(i-1) & yy > 25);
%     length(idx1)
%     length(idx2)
    data(i,1) = mean(cc(idx1));
    data(i,2) = mean(cc(idx2));
    data2(i,1) = std(cc(idx1));
    data2(i,2) = std(cc(idx2));
%     if(i == 1)
%         data = [cc(idx2) cc(idx1)];
%     else
%         data = [data cc(idx2) cc(idx1)];
%     end
end
subplot(2,2,3),
% b1 = bar(data);
% set(gca,'XLim',[0.5 7.7],'YLim',[0 350],...
%     'XTick',[1.5:1:7.5],'XTickLabel',{'500','1000','1500','2000','2500','3000','3500'})
% b1(1).FaceColor=[0.2 0.6 0.8];
% b1(1).EdgeColor = 'none';
% b1(2).FaceColor=[0.8 0.3 0.3];
% b1(2).EdgeColor = 'none';
% hold on,
% for i = 1 : 7
%     line([i-0.15 i-0.15],[data(i,1) data(i,1)+data2(i,1)],'LineWidth',1.2)
%     line([i+0.15 i+0.15],[data(i,2) data(i,2)+data2(i,2)],'LineWidth',1.2)
% end
% xlabel('MAP (mm yr^{-1})')
% ylabel('Biomass (MgC ha^{-1})')
% % legend('MAT<=25^oC','MAT>25^oC','location','best')

plot([600:100:2400]',bsens(1:19,1),'-o','Color',[0.1 0.2 1],'MarkerFaceColor'...
    ,[0.1 0.2 1],'MarkerSize',4.5,'LineWidth',2);
hold on,
p1=plot([2400:100:3100]',bsens(19:26,1),'-','Color',[0.1 0.2 1],'LineWidth',2);
% scatter([600:100:2400]',bsens(1:19,1),30,'MarkerFaceColor',[0.1 0.2 1],'MarkerEdgeColor','none')
% line([0 3600],[0 0],'Color','k','LineStyle','--')
set(gca,'XLim',[0 3600],'YColor',[0.1 0.2 1],'YLim',[-5 15])
ylabel('(MgC ha^{-1} (100mm)^{-1})')
xlabel('MAP (mm yr^{-1})')

yyaxis right
plot([600:100:2400]',bsens(1:19,2),'-o','Color',[1 0.2 0.1],'MarkerFaceColor'...
    ,[1 0.2 0.1],'MarkerSize',4.5,'LineWidth',2);
hold on
p2=plot([2400:100:3100]',bsens(19:26,2),'-','Color',[1 0.2 0.1],'LineWidth',2);
% scatter([600:100:2400]',bsens(1:19,2),30,'MarkerFaceColor',[1 0.2 0.1])
% title('Multi-model mean')
set(gca,'XLim',[0 3600],'YColor',[1 0.2 0.1],'YLim',[-5 15])
ylabel('(MgC ha^{-1} (1^oC)^{-1})')
% legend('Rainfall sensitivity','Temperature sensitivity','location','northwest')
% legend('boxoff')
legendLabel = {'Rainfall sensitivity','Temperature sensitivity'};
ah1=axes('position',get(gca,'position'),...
    'visible','off');
h1 = legend(ah1,[p1 p2],legendLabel{:});
set(h1,'EdgeColor','white','fontsize',8)
% set(gca,'OuterPosition',[-0.18 0.08 0.4319 0.1948])
% get(gca,'OuterPosition')

path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
load([path,'treeFrac_30yrmean_pattern.mat'])
load([path,'Biomass_30yrmean_pattern.mat'])
load([path,'MAP_30yrmean_pattern.mat'])
load([path,'MAT_30yrmean_pattern.mat'])
modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR','Multimodel mean'};
prannpic(isnan(vegcannpic)) = nan;
tasannpic(isnan(vegcannpic)) = nan;
vegcannpic = nanmean(vegcannpic,3);
prannpic = nanmean(prannpic,3);
tasannpic = nanmean(tasannpic,3);

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

bsens = nan(26, 2);
rsqua = nan(26, 1);
pval = nan(26,1);
% starting from 300mm to 3400 mm, ¡À200mm
for i = 600 : 100 : 3100
    xpr = xx(xx >=i-500 & xx <=i+500);
    xta = yy(xx >=i-500 & xx <=i+500);
    yvg = cc(xx >=i-500 & xx <=i+500);
    [b,bint,r,rint,stats] = regress(yvg,[xpr xta]);
    bsens((i-500)/100,1) = b(1)*100;
    bsens((i-500)/100,2) = b(2);
    rsqua((i-500)/100) = stats(1);
    pval((i-500)/100) = stats(3);
end
save mod_sens_para.mat bsens rsqua pval

data = nan(7, 2);
data2 = nan(7, 2);
for i = 1 : 7 % starting from 100mm, every 500mm, 100-600-1100-1600-2100-2600-3100-3600
    idx1 = find(xx >=500*(i-1) & xx < 500+500*(i-1) & yy <= 25);
    idx2 = find(xx >=500*(i-1) & xx < 500+500*(i-1) & yy > 25);
%     length(idx1)
%     length(idx2)
    data(i,1) = mean(cc(idx1));
    data(i,2) = mean(cc(idx2));
    data2(i,1) = std(cc(idx1));
    data2(i,2) = std(cc(idx2));
%     if(i == 1)
%         data = [cc(idx2) cc(idx1)];
%     else
%         data = [data cc(idx2) cc(idx1)];
%     end
end
subplot(2,2,4),
% b1 = bar(data);
% set(gca,'XLim',[0.5 7.7],...
%     'XTick',[1.5:1:7.5],'XTickLabel',{'500','1000','1500','2000','2500','3000','3500'})
% b1(1).FaceColor=[0.2 0.6 0.8];
% b1(1).EdgeColor = 'none';
% b1(2).FaceColor=[0.8 0.3 0.3];
% b1(2).EdgeColor = 'none';
% hold on,
% for i = 1 : 7
%     line([i-0.15 i-0.15],[data(i,1) data(i,1)+data2(i,1)],'LineWidth',1.2)
%     line([i+0.15 i+0.15],[data(i,2) data(i,2)+data2(i,2)],'LineWidth',1.2)
% end
% xlabel('MAP (mm yr^{-1})')
% ylabel('Biomass (MgC ha^{-1})')
% legend('MAT<=25^oC','MAT>25^oC','location','best')
    
plot([600:100:3100]',bsens(1:26,1),'-o','Color',[0.1 0.2 1],'MarkerFaceColor'...
    ,[0.1 0.2 1],'MarkerSize',4.5,'LineWidth',2);
hold on,
p1=plot([2400:100:3100]',bsens(19:26,1),'-','Color',[0.1 0.2 1],'LineWidth',2);
% scatter([600:100:2400]',bsens(1:19,1),30,'MarkerFaceColor',[0.1 0.2 1],'MarkerEdgeColor','none')
% line([0 3600],[0 0],'Color','k','LineStyle','--')
set(gca,'XLim',[0 3600],'YColor',[0.1 0.2 1],'YLim',[-5 15])
ylabel('(MgC ha^{-1} (100mm)^{-1})')
xlabel('MAP (mm yr^{-1})')

yyaxis right
plot([600:100:3100]',bsens(1:26,2),'-o','Color',[1 0.2 0.1],'MarkerFaceColor'...
    ,[1 0.2 0.1],'MarkerSize',4.5,'LineWidth',2);
hold on
p2=plot([2400:100:3100]',bsens(19:26,2),'-','Color',[1 0.2 0.1],'LineWidth',2);
% scatter([600:100:2400]',bsens(1:19,2),30,'MarkerFaceColor',[1 0.2 0.1])
% title('Multi-model mean')
set(gca,'XLim',[0 3600],'YColor',[1 0.2 0.1],'YLim',[-5 15])
ylabel('(MgC ha^{-1} (1^oC)^{-1})')