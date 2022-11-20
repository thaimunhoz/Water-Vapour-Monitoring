%Gráficos do atraso
clc
clear all
cd ('C:\Users\thain\Documents\graduacao\TG\Dados de saida');
%leitura dos dados
subplot = @(m,n,p) subtightplot (m, n, p, [0.03 0.03], [0.09 0.05], [0.1 0.02]);

sp = xlsread('pluv_data.xlsx',1);
bh = xlsread('pluv_data.xlsx',2);
%[DOY MES PRESS TEMP UMID ALT]
t = datetime(2019,02,28) + caldays(1:366);
tstart = datetime(2019,02,28);
tend = datetime(2020,03,02);
%*****************************umidade******************************************************
figure('units','normalized','outerposition',[0 0 1 1])
% subplot(3,1,1)
plot(t,sp(:,4),'-*r','linewidth',1);
hold on;
grid on;
plot(t,bh(:,4),'-*b','linewidth',1);
hold on;
set(gca,'xticklabel',[]) 
datetick('x','mmm-yy','keeplimits');
xticklabels({ });
xlim([tstart tend]);
xticklabels({'Mar/19','Abr/19','Mai/19','Jun/19','Jul/19','Ago/19','Set/19','Out/19','Nov/19','Dez/19','Jan/20','Fev/20'});
ylabel('Chuva(mm)','FontSize', 15);
legend('São Paulo','Belo Horizonte','Orientation','horizontal','Fontsize',15);
hold off

% **********************temperatura***********************************************
% subplot(3,1,2)
% plot(t,sp(:,4),'-*r','linewidth',1);
% hold on;
% grid on;
% plot(t,bh(:,4),'-*b','linewidth',1);
% hold on;
% set(gca,'xticklabel',[]) 
% datetick('x','mmm-yy','keeplimits');
% xticklabels({ });
% legend('São Paulo','Belo Horizonte','Orientation','horizontal','Fontsize',15);
% ylabel('Temperatura(C°)','FontSize',15);
% hold off
% 
% %*****************************presao*********************************
% subplot(3,1,3)
% plot(t,sp(:,6),'-*r','linewidth',1);
% hold on;
% grid on;
% plot(t,bh(:,6),'-*b','linewidth',1);
% hold on;
% set(gca,'xticklabel',[]) 
% datetick('x','mmm-yy','keeplimits');
% legend('São Paulo','Belo Horizonte','Orientation','horizontal','Fontsize',15);
% xlim([tstart tend]);
% xticklabels({'Mar/19','Abr/19','Mai/19','Jun/19','Jul/19','Ago/19','Set/19','Out/19','Nov/19','Dez/19','Jan/20','Fev/20'});
% ylabel('Pressao (hPa)','FontSize', 15);
% hold off

% out_figP = ['C:\Users\thain\Documents\FAPESP\2º Renovação\Dados de saída\Gráficos/dif_ztd.tif'];
% print('-dtiff','-r1000', out_figP);