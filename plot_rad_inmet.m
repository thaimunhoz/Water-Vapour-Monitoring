clc
clear all

cd ('C:\Users\thain\Documents\graduacao\TG\Dados de saida');

%RADIOSSONDA
rad_hor = xlsread('RAD_SP.xlsx');
rad_media = xlsread('rad_mean_sp.xls');

%vector = [LINE TEMP UMID PRESS TEMP_MEAN UMID_MEAN PRESS_MEAN]
vec(:,1) = rad_hor(:,8); %lines
vec(:,2) = rad_hor(:,4); %temperatura
vec(:,3) = rad_hor(:,5); %umidade
vec(:,4) = rad_hor(:,3); %pressão
a = 1;
for i = 1:2:length(rad_hor)
   vec(i,5) = rad_media(a,4); %temperatura
   vec(i,6) = rad_media(a,5); %umidade
   vec(i,7) = rad_media(a,3); %pressão
   a = a+1;
end

vec(vec == 0) = NaN;
x = vec(:,1);

%Função de interpolação
xq = 1:1:734;
aux(:,1) = rad_media(:,9);
aux(:,2) = rad_media(:,4); %mudar conforme componente na tabela do Excel
% aux(isnan(aux(:,2)))=[];
aux(any(isnan(aux), 2), :) = [];
a = aux(:,1);
v = aux(:,2);
vq2 = interp1(a,v,xq,'spline');
vq2 = vq2';

n = find(all(isnan(vec(:,2)),2)); %identifica os dias sem dados
for k = 1:1:length(n)
    vq2(n,:) = NaN;
end

%% INMET
inmet_hor = xlsread('INMET_SP.xlsx');
inmet_media = xlsread('inmet_mean_sp.xls');

%vector = [LINE TEMP UMID PRESS TEMP_MEAN UMID_MEAN PRESS_MEAN]
vec_inmet(:,1) = inmet_hor(:,7); %line
vec_inmet(:,2) = inmet_hor(:,2); %temperatura
vec_inmet(:,3) = inmet_hor(:,1); %umidade
vec_inmet(:,4) = inmet_hor(:,4); %pressão
a2 = 1;

for i = 1:3:length(inmet_hor)
   vec_inmet(i,5) = inmet_media(a2,2); %temp_media
   vec_inmet(i,6) = inmet_media(a2,1); %umid_media
   vec_inmet(i,7) = inmet_media(a2,4); %press_media
   a2 = a2+1;
end

vec_inmet(vec_inmet == 0) = NaN;
x2 = vec_inmet(:,1);

%Função de interpolação
xq22 = 1:1:1101;
aux2(:,1) = inmet_media(:,7); %lines
aux2(:,2) = inmet_media(:,2); %mudar conforme a componente
% aux(isnan(aux(:,2)))=[];
aux2(any(isnan(aux2), 2), :) = [];
a2 = aux2(:,1);
v2 = aux2(:,2);
vq22 = interp1(a2,v2,xq22,'spline');
vq22 = vq22';

n2 = find(all(isnan(vec_inmet(:,2)),2)); %identifica os dias sem dados
for k = 1:1:length(n2)
    vq22(n2,:) = NaN;
end

%%

% t = datetime(2019,02,28,00) + caldays(1:366) + hours(12);
tstart = datetime(2019,02,28);
tend = datetime(2020,03,02);

% a = datenum({'03-Mar-2019 00:00:00';'03-Mar-2020 12:00:00'});
% Out = datevec(a(1):12/24:a(2));

t1 = datetime(2019,03,01,0,0,0);
t2 = datetime(2020,03,01,12,0,0);
t3 = datetime(2020,03,01,16,0,0);
t = t1:12/24:t2; %radiossonda com intervalo de 12 horas entre os dados
t = t';
tt = t1:8/24:t3; %Inmet com intervalo de 6 horas entre os dados
tt = tt';

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,1,1)
plot(t,vec(:,2),'-*g','linewidth',1); %Mudar conforme a componente
hold on;
grid on;
plot(t,vq2,'linewidth',2);
% plot(x,v,'o',xq,vq2,':.');
hold on;
datetick('x','mmm-yy','keeplimits');
xticklabels({ });
xlim([tstart tend]);
xticklabels({'Mar/19','Abr/19','Mai/19','Jun/19','Jul/19','Ago/19','Set/19','Out/19','Nov/19','Dez/19','Jan/20','Fev/20'});
ylabel('Pressão (hPa)','FontSize', 15);
legend('Dados horários (00h e 12h)','Média diária','Orientation','horizontal','Fontsize',15);
title('Radiossonda','Fontsize',15);
hold off

subplot(2,1,2)
plot(tt,vec_inmet(:,2),'-*g','linewidth',1);
hold on;
grid on;
plot(tt,vq22,'linewidth',2);
% plot(x,v,'o',xq,vq2,':.');
hold on;
datetick('x','mmm-yy','keeplimits');
xticklabels({ });
xlim([tstart tend]);
xticklabels({'Mar/19','Abr/19','Mai/19','Jun/19','Jul/19','Ago/19','Set/19','Out/19','Nov/19','Dez/19','Jan/20','Fev/20'});
ylabel('Pressão (hPa)','FontSize', 15);
legend('Dados horários (00h e 12h)','Média diária','Orientation','horizontal','Fontsize',15);
title('INMET','Fontsize',15);
hold off