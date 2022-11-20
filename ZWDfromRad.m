%Cálculo do ZHD e obtenção do ZHD
clc 
clear all
cd = 'C:\Users\thain\Documents\FAPESP\3_Renovação\ZWD from ZTD\dados_de_saida\RADIOSSONDA\dados_interpolado_5min\YMHB';
data = xlsread('YMHB_2019_PTU_rad_5min');  %PTU radiossonda interpolado
cd = 'C:\Users\thain\Documents\FAPESP\3_Renovação\ZWD from ZTD\dados_de_saida\IGS\YMHB_ZTD_IGS_EXCEL';
ztd = xlsread('YMHB_IGS_2019'); %ZTD EMBRACE

% ESCOLA POLITÉCNICA DA USP-POLI
% lat = [mat2deg([23 28 53.58165 -1])]; %(graus decimais)
% lon = [mat2deg([46 29 58.90888 -1])]; %(graus decimais)
% alt = 730.622; %(metros)

% AOPR - San Juan
% lat = [mat2deg([18 20 47.65 1])]; %(graus decimais)
% lon = [mat2deg([66 45 13.28 -1])]; %(graus decimais)
% alt = 350.689; %(metros)

% YMML - Melbourne (Austrália)
% lat = [mat2deg([37 49 23.80 -1])]; %(graus decimais)
% lon = [mat2deg([144 58 24.10 1])]; %(graus decimais)
% alt = 40.578; %(metros)

% YPPH - Perth (Australia)
% lat = [mat2deg([31 59 58 -1])]; %(graus decimais)
% lon = [mat2deg([115 53 9.68 1])]; %(graus decimais)
% alt = 24; %(metros)

% NAUS - Manaus
% lat = [mat2deg([03 01 22.51079 -1])]; %(graus decimais)
% lon = [mat2deg([60 03 18.05992 -1])]; %(graus decimais)
% alt = 93.890; %(metros)

% BOAV - Boa Vista
% lat = [mat2deg([02 50 42.65645 1])]; %(graus decimais)
% lon = [mat2deg([60 42 4.01375 -1])]; %(graus decimais)
% alt = 69.478; %(metros)
% 
% % ONRJ - Rio de Janeiro
% lat = [mat2deg([22 53 44.52202 -1])]; %(graus decimais)
% lon = [mat2deg([43 13 27.59375 -1])]; %(graus decimais)
% alt = 35.636; %(metros)

% CUIB - Cuiaba
% lat = [mat2deg([15 33 18.94678 -1])]; %(graus decimais)
% lon = [mat2deg([56 04 11.51958 -1])]; %(graus decimais)
% alt = 237.444; %(metros)

% % POAL - Porto Alegre
% lat = [mat2deg([30 04 26.55276 -1])]; %(graus decimais)
% lon = [mat2deg([51 07 11.15324 -1])]; %(graus decimais)
% alt = 76.745; %(metros)

% RNNA - Natal
% lat = [mat2deg([05 50 10.10620 -1])]; %(graus decimais)
% lon = [mat2deg([35 12 27.74853 -1])]; %(graus decimais)
% alt = 45.965; %(metros)

% Hobart
lat = [mat2deg([42 53 12.46 -1])]; %(graus decimais)
lon = [mat2deg([147 19 21.06 1])]; %(graus decimais)
alt = 41.1; %(metros)
% NN = length(data);

% Belo Horizonte
% lat = [mat2deg([19 56 30.84 -1])]; %(graus decimais)
% lon = [mat2deg([43 55 29.63 -1])]; %(graus decimais)
% alt = 974.85; %(metros)

NN = length(data);

for i = 1:1:length(data)
    %Zerar variáveis
    Esu = zeros([1 NN]);
    e = zeros([1 NN]);
    w = zeros([1 NN]);
    Zw = zeros([1 NN]);
    w1 = zeros([1 NN]);
    w2 = zeros([1 NN]);
    Dw = zeros([1 NN]);
    ZTD = zeros([1 NN]);
    D = zeros([1 NN]);
    DZW = zeros([1 NN]);
    
    PRES = data(i,6);
    TEMP = data(i,4);
    RELH = data(i,5);
    mes = data(i,2);
    DOY = data(i,1);
    hora = data(i,3);
    
    %% CÁLCULO DO ATRASO
    %CÁLCULO DA PRESSÃO PARCIAL DO VAPOR D'ÁGUA
    lati = (lat*pi)/180; %Latitude(rad). Muda conforme a estação
    h = alt/1000; %Altitude (km)
    gm = (1-0.0026*cos(2*lati) - 0.00028*h);
    PRESS = PRES;

    %Cálculo da componente hidrostática --- ref: Sapucci, 2001
    PRESS(isnan(PRESS))=0;
    ro = PRESS/gm;
    DZH = (2.27683157*10^-3)*ro;
    
    %Cálculo da componente úmida-------Ref: Sapucci, 2001   
        Esu = 6.1078*(10^((7.5*TEMP)/(237.3+TEMP)));%Pressão saturação do vapor d'água(hPa)
        e = (RELH * Esu)/ 100; %Pressão parcial do vapor d'água (Mendes, 1999, pg. 41)
        w = 1 - (0.01317 * TEMP) + (0.000175*(TEMP^2)) + (0.00000144*(TEMP^3));
        Zw = 1 + ((1650*(e/((TEMP + 273.15)^3))) * w);
        %Caculo do k'2: k'2=k2-(k1*(Rh/Rw))=k2-(k1*(Mw/Mh))=71.2952-(77.6890*(18.0152/28.9644))=22.9744 (Rueger, 2002 and Davis,1985) 
        w1 = 0.0000229744*((e/(TEMP+273.15))*Zw);% 10^-6*(k'2) (Rueger, 2002)
        w2 = 0.375463*((e/((TEMP+273.15)^2))*Zw); %10^-6*k3 (Rueger, 2002)
        Dw = w1 + w2; %Equação 3.24 - sapucci
        Dw = Dw';
     %Cálculo do atraso zenital total
     ZTD = DZH + Dw; 
    %Salvando o atraso acumulado correpondente ao doy 'i'
    atraso_acumulado(i,1) = mes;
    atraso_acumulado(i,2) = DOY; %Dia do ano
    atraso_acumulado(i,3) = hora;
    atraso_acumulado(i,4) = DZH; %ZHD para o DOY
    atraso_acumulado(i,5) = Dw; %ZWD para o DOY
    atraso_acumulado(i,6) = ZTD; 
    
    %Subtração do ZTD (Embrace) com ZHD (radiossonda)
    ZTD_e = ztd(i,4);
    ZWD_e = ZTD_e - atraso_acumulado(i,4);
    
    atraso_final(i,1) = mes;
    atraso_final(i,2) = DOY;
    atraso_final(i,3) = hora;
    atraso_final(i,4) = DZH;
    atraso_final(i,5) = ZTD_e;
    atraso_final(i,6) = ZWD_e;
    
    clear mes DOY hora DZH DZW ZTD ZTD_e ZWD_e
end
for k = 1:1:length(atraso_final)
    x(k) = k;
end

%Buscar os dias em que não tem dados de radiossonda e colocar NaN na linha
n = find(~atraso_final(:,4));
for k = 1:1:length(n)
    atraso_final(n,:) = NaN;
end
x = x';
figure(1)
plot(x,atraso_final(:,4),'linewidth',1);
title('ZHD');
hold on;
grid on;
figure(2)
plot(x,atraso_final(:,5),'linewidth',1);
title('ZTD');
hold on;
grid on;
figure(3)
plot(x,atraso_final(:,6),'linewidth',1);
title('ZWD');
hold on;
grid on;
% xlswrite('BH_2019_delay_radiosonde.xlsx', atraso_acumulado); %Mudar aqui
akb = 1;
aka=1;
for ii = 1:1:181
    for iii = 0:1:287
        atraso_final(aka,1) = akb;
        aka=aka+1;
    end
    akb = akb + 1;
end
xlswrite('YMHB2019_ZWD.xlsx', atraso_final); %Mudar aqui