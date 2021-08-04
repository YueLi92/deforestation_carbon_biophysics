%% read model biomass
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
% load([path,'treeFrac_30yrmean_pattern.mat'])
load([path,'Biomass_30yrmean_pattern_new.mat'])
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
load('biomass_tropics_1deg_glob.mat');
biomass_obs = nan(180,360);
biomass_obs(11:150,:) = biomass;

% for i = 1 : 8
%     figure,imagesc(vegcannpic(:,:,i)*10),
%     colorbar
% end



figure('position',[ 85         126        1155         852]),
clr = flipud(summer(17));
clr = [1 1 1; clr];
lai_bias = nanmean(vegcannpic,3)*10;
lai_bias(landmask ==0) = nan;
haha = lai_bias;
haha(:,1:180) = lai_bias(:,181:360);
haha(:,181:360) = lai_bias(:,1:180);
biomass_mod = haha;
%     haha(haha <= -200) = -199;
%     haha(haha >= 200) = 199;
haha(isnan(haha)) = -10;
haha(haha>180) = 179.9;
R = georasterref('RasterSize', [180 360],'Latlim', [-90 90],'Lonlim', [-180 180],'ColumnsStartFrom', 'north');
subplot(2,1,1)
% axesm('MapProjection','mercator','MapLatLimit',[-60 90])
geoshow(gca,haha,R,'DisplayType','texturemap');

colormap(clr)
caxis([0 180])
h = colorbar;
set(h,'YTick',[20:20:180],'Location','southoutside')
title(h,'(MgC ha^{-1})','FontSize',16)
get(h,'position')
set(h,'position',[0.2055    0.5264    0.6236    0.0246])
load coast
geoshow(lat,long,'Color',[0 0 0],'LineWidth',1.2)
set(gca,'XLim',[-180 180],'XTickLabel',{},'box','on','YLim',[-60 90],...
    'YTick',[-60 90],'YTickLabel',{},'LineWidth',3,'FontSize',13);
% set(gca,'YTickDir','Reverse')
title('CMIP6 model mean AGB','FontSize',16)


lai_bias = biomass_obs*0.5;
lai_bias(isnan(biomass_mod)) = nan;
haha = lai_bias;
%     haha(haha <= -200) = -199;
%     haha(haha >= 200) = 199;
haha(isnan(haha)) = -10;
haha(haha>180) = 179.9;
R = georasterref('RasterSize', [180 360],'Latlim', [-90 90],'Lonlim', [-180 180],'ColumnsStartFrom', 'north');
subplot(2,1,2)
% axesm('MapProjection','mercator','MapLatLimit',[-60 90])
geoshow(gca,haha,R,'DisplayType','texturemap');

colormap(clr)
caxis([0 180])
h = colorbar;
set(h,'YTick',[20:20:180],'Location','southoutside')
title(h,'(MgC ha^{-1})','FontSize',16)
get(h,'position')
set(h,'position',[0.2064    0.0435    0.6219    0.0245])
load coast
geoshow(lat,long,'Color',[0 0 0],'LineWidth',1.2)
set(gca,'XLim',[-180 180],'XTickLabel',{},'box','on','YLim',[-60 90],...
    'YTick',[-60 90],'YTickLabel',{},'LineWidth',3,'FontSize',13);
% set(gca,'YTickDir','Reverse')
title('ESA CCI AGB','FontSize',16)



figure('position',[ 85         126        1155         852]),
% clr = flipud(summer(20));
% clr = [1 1 1; clr];
clr = [255 255 255; 17 47 98; 31 85 158; 42 116 181; 69 147 193; 121 181 214;...
    168 210 219;212 228 238; 241 246 249; 250 244 240; 253 220 199; 250 184 153; 236 142 112;...
    212 97 74; 194 41 52; 160 25 37; 103 12 33]./255;
lai_bias = nanmean(vegcannpic,3)*10;
lai_bias(landmask ==0) = nan;
haha = lai_bias;
haha(:,1:180) = lai_bias(:,181:360);
haha(:,181:360) = lai_bias(:,1:180);
biomass_mod = haha;
haha = biomass_mod - biomass_obs*0.5;
%     haha(haha <= -200) = -199;
%     haha(haha >= 200) = 199;
haha(haha>80) = 79.9;
haha(haha<-80) = -79.9;
haha(isnan(haha)) = -81;
R = georasterref('RasterSize', [180 360],'Latlim', [-90 90],'Lonlim', [-180 180],'ColumnsStartFrom', 'north');
subplot(2,1,1)
% axesm('MapProjection','mercator','MapLatLimit',[-60 90])
geoshow(gca,haha,R,'DisplayType','texturemap');

colormap(clr)
caxis([-90 80])
h = colorbar;
set(h,'YLim',[-80 80],'YTick',[-80:20:80],'Location','southoutside')
title(h,'(MgC ha^{-1})','FontSize',16)
get(h,'position')
set(h,'position',[0.2055    0.5064    0.6236    0.0246])
load coast
geoshow(lat,long,'Color',[0 0 0],'LineWidth',1.2)
set(gca,'XLim',[-180 180],'XTickLabel',{},'box','on','YLim',[-60 90],...
    'YTick',[-60 90],'YTickLabel',{},'LineWidth',3,'FontSize',13);
% set(gca,'YTickDir','Reverse')
title('CMIP6 model mean - ESA CCI biomass','FontSize',16)


lai_bias = nanmean(vegcannpic,3)*10;
lai_bias(landmask ==0) = nan;
haha = lai_bias;
haha(:,1:180) = lai_bias(:,181:360);
haha(:,181:360) = lai_bias(:,1:180);
biomass_mod = haha;
haha = biomass_mod*0.8 - biomass_obs*0.5;
%     haha(haha <= -200) = -199;
%     haha(haha >= 200) = 199;
haha(haha>80) = 79.9;
haha(haha<-80) = -79.9;
haha(isnan(haha)) = -81;
R = georasterref('RasterSize', [180 360],'Latlim', [-90 90],'Lonlim', [-180 180],'ColumnsStartFrom', 'north');
subplot(2,1,2)
% axesm('MapProjection','mercator','MapLatLimit',[-60 90])
geoshow(gca,haha,R,'DisplayType','texturemap');

colormap(clr)
caxis([-90 80])
h = colorbar;
set(h,'YLim',[-80 80],'YTick',[-80:20:80],'Location','southoutside')
title(h,'(MgC ha^{-1})','FontSize',16)
get(h,'position')
set(h,'position',[0.2055    0.0435    0.6236    0.0246])
load coast
geoshow(lat,long,'Color',[0 0 0],'LineWidth',1.2)
set(gca,'XLim',[-180 180],'XTickLabel',{},'box','on','YLim',[-60 90],...
    'YTick',[-60 90],'YTickLabel',{},'LineWidth',3,'FontSize',13);
% set(gca,'YTickDir','Reverse')
title('CMIP6 model mean*0.8 - ESA CCI biomass','FontSize',16)

%% Each model
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
% load([path,'treeFrac_30yrmean_pattern.mat'])
load([path,'Biomass_30yrmean_pattern.mat'])
load('biomass_tropics_1deg_glob.mat');
biomass_obs = nan(180,360);
biomass_obs(11:150,:) = biomass;
modelname = {'BCC-CSM2-MR','CanESM5','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR'};

for mi = 1 : 8
    lai_bias = vegcannpic(:,:,mi)*10;
    lai_bias(landmask ==0) = nan;
    haha = lai_bias;
    haha(:,1:180) = lai_bias(:,181:360);
    haha(:,181:360) = lai_bias(:,1:180);
    biomass_mod = haha;
    
    figure('position',[ 85         126        1155         852]),
    % clr = flipud(summer(20));
    % clr = [1 1 1; clr];
    clr = [255 255 255; 17 47 98; 31 85 158; 42 116 181; 69 147 193; 121 181 214;...
        168 210 219;212 228 238; 241 246 249; 250 244 240; 253 220 199; 250 184 153; 236 142 112;...
        212 97 74; 194 41 52; 160 25 37; 103 12 33]./255;
    
    haha = biomass_mod - biomass_obs*0.5;
    %     haha(haha <= -200) = -199;
    %     haha(haha >= 200) = 199;
    haha(haha>80) = 79.9;
    haha(haha<-80) = -79.9;
    haha(isnan(haha)) = -81;
    R = georasterref('RasterSize', [180 360],'Latlim', [-90 90],'Lonlim', [-180 180],'ColumnsStartFrom', 'north');
    subplot(2,1,1)
    % axesm('MapProjection','mercator','MapLatLimit',[-60 90])
    geoshow(gca,haha,R,'DisplayType','texturemap');
    
    colormap(clr)
    caxis([-90 80])
    h = colorbar;
    set(h,'YLim',[-80 80],'YTick',[-80:20:80],'Location','southoutside')
    title(h,'(MgC ha^{-1})','FontSize',16)
    get(h,'position')
    set(h,'position',[0.2055    0.5064    0.6236    0.0246])
    load coast
    geoshow(lat,long,'Color',[0 0 0],'LineWidth',1.2)
    set(gca,'XLim',[-180 180],'XTickLabel',{},'box','on','YLim',[-60 90],...
        'YTick',[-60 90],'YTickLabel',{},'LineWidth',3,'FontSize',13);
    % set(gca,'YTickDir','Reverse')
    title(['CMIP6 ', modelname{mi},' - ESA CCI biomass'],'FontSize',16)
    
    haha = biomass_mod*0.8 - biomass_obs*0.5;
    %     haha(haha <= -200) = -199;
    %     haha(haha >= 200) = 199;
    haha(haha>80) = 79.9;
    haha(haha<-80) = -79.9;
    haha(isnan(haha)) = -81;
    R = georasterref('RasterSize', [180 360],'Latlim', [-90 90],'Lonlim', [-180 180],'ColumnsStartFrom', 'north');
    subplot(2,1,2)
    % axesm('MapProjection','mercator','MapLatLimit',[-60 90])
    geoshow(gca,haha,R,'DisplayType','texturemap');
    
    colormap(clr)
    caxis([-90 80])
    h = colorbar;
    set(h,'YLim',[-80 80],'YTick',[-80:20:80],'Location','southoutside')
    title(h,'(MgC ha^{-1})','FontSize',16)
    get(h,'position')
    set(h,'position',[0.2055    0.0435    0.6236    0.0246])
    load coast
    geoshow(lat,long,'Color',[0 0 0],'LineWidth',1.2)
    set(gca,'XLim',[-180 180],'XTickLabel',{},'box','on','YLim',[-60 90],...
        'YTick',[-60 90],'YTickLabel',{},'LineWidth',3,'FontSize',13);
    % set(gca,'YTickDir','Reverse')
    title(['CMIP6 ', modelname{mi},'*0.8 - ESA CCI biomass'],'FontSize',16)
    
    
end