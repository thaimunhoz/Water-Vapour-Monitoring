clc
clear all
cd ('C:\Users\thain\Documents\graduacao\TG\Dados de saida');
inmet = xlsread('INMET_pluviometria.xlsx');
cemaden = xlsread('CEMADEN_pluviometria.xlsx');
ana = xlsread('ANA_pluviometria.xlsx');

inmet(any(isnan(inmet), 2), :) = [];

t = datetime(2019,02,28) + caldays(1:367);
tstart = datetime(2019,02,28);
tend = datetime(2020,03,02);

%CEMADEN
figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,1,1)
plot(t,cemaden(:,5),'-*b','linewidth',2);
hold on;
grid on;
datetick('x','mmm-yy','keeplimits');
xticklabels({ });
xlim([tstart tend]);
ylabel('Chuva(mm)','FontSize', 15);
title('CEMADEN','Fontsize',15);
hold off
%INMET
subplot(3,1,2)
plot(t,inmet(:,2),'-*b','linewidth',2);
hold on;
grid on;
datetick('x','mmm-yy','keeplimits');
xticklabels({ });
xlim([tstart tend]);
ylabel('Chuva(mm)','FontSize', 15);
title('INMET','Fontsize',15);
hold off
%ANA
subplot(3,1,3)
plot(t,ana(:,3),'-*g','linewidth',1);
hold on;
grid on;
datetick('x','mmm-yy','keeplimits');
xlim([tstart tend]);
xticklabels({'Mar/19','Abr/19','Mai/19','Jun/19','Jul/19','Ago/19','Set/19','Out/19','Nov/19','Dez/19','Jan/20','Fev/20'});
ylabel('Chuva(mm)','FontSize', 15);
title('ANA','Fontsize',15);
hold off
