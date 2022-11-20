clc
clear all
cd ('C:\Users\thain\Documents\graduacao\TG\Dados de saida\estudo de caso\Estudo de caso BH');

%RADIOSSONDA PTU
% rad_hor = xlsread('rad_bh_2019_hora.xlsx');

%INMET PTU
inmet_hor = xlsread('inmet_bh_2020.xlsx');

%INMET_chuva
inmet_pluv = xlsread('inmet_bh_2020_pluv.xlsx');

%GPM_chuva
gpm_pluv = xlsread('BH_Giovanni_2020.xlsx');

%IWV
iwv = xlsread('iwv_2020.xlsx');

%%
tstart = datetime(2019,07,03);
tend = datetime(2019,07,07);

t1 = datetime(2019,07,03,0,0,0);
t2 = datetime(2019,07,08,0,0,0);
t3 = datetime(2019,07,08,0,0,0);
t4 = datetime(2019,07,08,0,0,0);
t5 = datetime(2019,07,07,23,55,0);
% tstart = datetime(2020,02,08);
% tend = datetime(2020,02,12);
% 
% t1 = datetime(2020,02,08,0,0,0);
% t2 = datetime(2020,02,12,12,0,0);
% t3 = datetime(2020,02,12,16,0,0);
% t4 = datetime(2020,02,12,23,55,0);

% tstart = datetime(2019,11,21);
% tend = datetime(2019,11,25);
% 
% t1 = datetime(2019,11,21,0,0,0);
% t2 = datetime(2019,11,25,12,0,0);
% t3 = datetime(2019,11,25,16,0,0);
% t4 = datetime(2019,11,25,23,55,0);
 
% tstart = datetime(2020,01,22);
% tend = datetime(2020,01,26);
% 
% t1 = datetime(2020,01,22,0,0,0);
% t2 = datetime(2020,01,26,12,0,0);
% t3 = datetime(2020,01,26,16,0,0);
% t4 = datetime(2020,01,26,23,55,0);

t_rad = t1:12/24:t2; %radiossonda com intervalo de 12 horas entre os dados
t_rad = t_rad';

t_inmet = t1:8/24:t3; %Inmet com intervalo de 6 horas entre os dados
t_inmet = t_inmet';

t_iwv = t1:0.08333333/24:t5; %IWV com intervalo de 6 horas entre os dados
t_iwv = t_iwv';

t_gpm = t1:0.5/24:t5; %giovanni com intervalo de 12 horas entre os dados
t_gpm = t_gpm';

t_pluv = t1:24/24:t4; %inmet pluv com intervalo de 12 horas entre os dados
t_pluv = t_pluv';

%interpolação dos dados pluviométricos do INMET
% xq = 1:1:240;
% aux(:,1) = inmet_pluv(:,3);
% aux(:,2) = inmet_pluv(:,2); %mudar conforme componente na tabela do Excel
% % aux(isnan(aux(:,2)))=[];
% aux(any(isnan(aux), 2), :) = [];
% a = aux(:,1);
% v = aux(:,2);
% vq2 = interp1(a,v,xq);
% vq2 = vq2';

%PRESSÃO
figure('units','normalized','outerposition',[0 0 1 1])
subplot(5,1,1)
% plot(t_rad,rad_hor(:,3),'-*','linewidth',2); %Radiossonda pressão
hold on;
grid on;
plot(t_inmet,inmet_hor(:,4),'linewidth',2); %inmet pressão
hold on;
datetick('x','dd-mmm-yy','keeplimits');
xticklabels({ });
% xlim([tstart tend]);
% xticklabels({'03/Jul/19','04/Jul/19','05/Jul/19','06/Jul/19','07/Jul/19'});
ylabel('Pressão (hPa)','FontSize', 15);
legend('Radiossonda','INMET','Orientation','horizontal','Fontsize',15);
hold off

%TEMPERATURA
subplot(5,1,2)
% plot(t_rad,rad_hor(:,4),'-*','linewidth',2); %Radiossonda temperatura
hold on;
grid on;
plot(t_inmet,inmet_hor(:,2),'linewidth',2); %inmet temp
hold on;
datetick('x','dd-mmm-yy','keeplimits');
xticklabels({ });
% xlim([tstart tend]);
% xticklabels({'03/Jul/19','04/Jul/19','05/Jul/19','06/Jul/19','07/Jul/19'});
ylabel('Temperatura (°C)','FontSize', 15);
% legend('Dados horários (00h e 12h)','Média diária','Orientation','horizontal','Fontsize',15);
% title('INMET','Fontsize',15);
hold off

%HUMIDADE
subplot(5,1,3)
% plot(t_rad,rad_hor(:,5),'-*','linewidth',2); %Radiossonda umi
hold on;
grid on;
plot(t_inmet,inmet_hor(:,1),'linewidth',2); %inmet umid
hold on;
datetick('x','dd-mmm-yy','keeplimits');
xticklabels({ });
% xlim([tstart tend]);
% xticklabels({'03/Jul/19','04/Jul/19','05/Jul/19','06/Jul/19','07/Jul/19'});
% xticklabels({'22/Jan/20','23/Jan/20','24/Jan/20','25/Jan/20','26/Jan/20'});
% xticklabels({'21/Nov/19','21/Nov/19','21/Nov/19','21/Nov/19','21/Nov/19'});
ylabel('Umidade (%)','FontSize', 15);
% legend('Dados horários (00h e 12h)','Média diária','Orientation','horizontal','Fontsize',15);
% title('INMET','Fontsize',15);
hold off

%Precipitação
subplot(5,1,5)
plot(t_pluv,inmet_pluv(:,2),'-*','linewidth',2); %Radiossonda umi
ylabel('Precipitação (mm)','FontSize', 15);
hold on;
grid on;
yyaxis right
plot(t_gpm,gpm_pluv(:,1),'linewidth',2); %inmet umid
ylabel('Precipitação (mm/hr)','FontSize', 15);
hold on;
datetick('x','dd-mmm-yy','keeplimits');
% xticklabels({ });
% xlim([tstart tend]);
% xticklabels({'08/Fev/20','09/Fev/20','10/Fev/20','11/Fev/20','12/Fev/20','13/Fev/20'});
% xticklabels({'03/Jul/19','04/Jul/19','05/Jul/19','06/Jul/19','07/Jul/19','08/Jul/19'});
xticklabels({'22/Jan/20','23/Jan/20','24/Jan/20','25/Jan/20','26/Jan/20','27/Nov/20'});
% xticklabels({'21/Nov/19','22/Nov/19','23/Nov/19','24/Nov/19','25/Nov/19'});
legend('INMET','GPM(IMERG)','Orientation','horizontal','Fontsize',15);
% title('INMET','Fontsize',15);
hold off

%IWV
subplot(5,1,4)
plot(t_iwv,iwv(:,3),'-*','linewidth',2); %Radiossonda umi
ylabel('IWV (mm)','FontSize', 15);
hold on;
grid on;
datetick('x','dd-mmm-yy','keeplimits');
xticklabels({ });
% xlim([tstart tend]);
% xticklabels({'08/Fev/20','09/Fev/20','10/Fev/20','11/Fev/20','12/Fev/20','13/Fev/20'});
% xticklabels({'03/Jul/19','04/Jul/19','05/Jul/19','06/Jul/19','07/Jul/19','08/Jul/19'});
% xticklabels({'22/Jan/20','23/Jan/20','24/Jan/20','25/Jan/20','26/Jan/20'});
% xticklabels({'21/Nov/19','21/Nov/19','21/Nov/19','21/Nov/19','21/Nov/19'});
% legend('INMET','Orientation','horizontal','Fontsize',15);
% title('INMET','Fontsize',15);
hold off