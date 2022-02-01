%% 1. Image processing
clear,clc;
[img, ref] = geotiffread('D:\Study\rainfall_deforestation\进一步工作\1.Biomass_map_comp\Baccini_2012D\AGB_prj.tif');
img = double(img);
img(img > 32760) = nan;
% aggregate the map into a certain extent
% Lat: 23S-23N, Lon: 180W-180E
biomass = nan(46,360);
for i = 1 : 46
    i,
    ilat1 = (90-67)-i+1;
    ilat2 = (90-67)-i;
    i1 = uint64(floor((ref.LatitudeLimits(2) - ilat1)/ref.CellExtentInLatitude));
    i2 = uint64(floor((ref.LatitudeLimits(2) - ilat2)/ref.CellExtentInLatitude));
    
    for j = 1 : 360
        
        ilon1 = -180+j-1;
        ilon2 = -180+j;
        
        if(ilon1 < ref.LongitudeLimits(1) || ilon2 > ref.LongitudeLimits(2))
            continue;
        end
        
        j1 = uint64(floor((ilon1 - ref.LongitudeLimits(1))/ref.CellExtentInLongitude));
        j2 = uint64(floor((ilon2 - ref.LongitudeLimits(1))/ref.CellExtentInLongitude));
        
        tmp = img(i1:i2,j1:j2);
        biomass(i,j) = nansum(nansum(tmp)) / ((i2-i1+1)*(j2-j1+1));
    end
end

save AGB_Baccini.mat biomass

%% 2. scatter_plot
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
biomass(landmask ==0) = nan;
rain(landmask==0) = nan;
tair(landmask==0) = nan;
% figure,imagesc(biomass)
% figure,imagesc(rain)
% figure,imagesc(tair)
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
% datam = [amaprldef conprldef asaprldef; amaprlpic conprlpic asaprlpic];
color = [1 0.6 0.2; 0.6 1 0.2; 0.2 0.6 1];
% obspr = [2314, 1627, 3311];
obspr = [2240 1510 2910];
dtt2 = [-150 -41 -38];
txt = {'Amazon','Congo','tropAsia'};
intv = [100 -100 100];
for i = 1 : 3
%     dtt = datam(:,i);
    line([obspr(i) obspr(i)],[12.2 31],'Color',color(i,:),'LineStyle','-','LineWidth',1.5)
    line([obspr(i)+dtt2(i) obspr(i)+dtt2(i)],[12.2 31],'Color',color(i,:),'LineStyle','--','LineWidth',1.5)
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
% line([750 750],[14 16],'Color','k','LineStyle','-','LineWidth',1.5)
% line([250 250],[14 16],'Color','k','LineStyle','--','LineWidth',1.5)
% subplot(2,2,1),
scatter(xx,yy,8,cc,'o','filled')
cmp = flipud(parula);
colormap(cmp)
colorbar,
caxis([0 170])
box on
hcb = colorbar;
title('AGB (Baccini\_2012)')
colorTitleHandle = get(hcb,'Title');
titleString = '   MgC ha^{-1}';
set(colorTitleHandle ,'String',titleString);
set(gca,'XLim',[0 3600],'YLim',[12.2 31])
% caxis([0 250])
% colorbar('off')
xlabel('MAP (mm yr^{-1})')
ylabel('MAT (^oC)')



%% box plot - Observations
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

% starting from 300mm to 3400 mm, ±200mm
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
bsens(23:26,:) = 0; % because p value > 0.001
save Baccini_sens_para.mat bsens rsqua pval

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
figure('position',[680 558 560 210]),
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
    ,[0.1 0.2 1],'MarkerSize',4.5,'LineWidth',2);
hold on,
% p1=plot([2400:100:3100]',bsens(19:26,1),'-','Color',[0.1 0.2 1],'LineWidth',2);
% scatter([600:100:2400]',bsens(1:19,1),30,'MarkerFaceColor',[0.1 0.2 1],'MarkerEdgeColor','none')
% line([0 3600],[0 0],'Color','k','LineStyle','--')
set(gca,'XLim',[0 3600],'YColor',[0.1 0.2 1],'YLim',[-3 8])
ylabel('MgC ha^{-1} /100mm yr^{-1}')
xlabel('MAP (mm yr^{-1})')

yyaxis right
p2=plot([600:100:2400]',bsens(1:19,2),'-o','Color',[1 0.2 0.1],'MarkerFaceColor'...
    ,[1 0.2 0.1],'MarkerSize',4.5,'LineWidth',2);
hold on
% p2=plot([2400:100:3100]',bsens(19:26,2),'-','Color',[1 0.2 0.1],'LineWidth',2);
% scatter([600:100:2400]',bsens(1:19,2),30,'MarkerFaceColor',[1 0.2 0.1])
% title('Multi-model mean')
set(gca,'XLim',[0 3600],'YColor',[1 0.2 0.1],'YLim',[-3 8])
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
