function [Dt,iwv_acumulado] = IWV_rad_modify(DOY_d,mes_d,HGHT,PRES,TEMP,RELH)
    NN = length(RELH); %linhas do arquivo
    
    %Zerar variáveis
    iwv_acumulado = [];
    Dt = [];
    Esu = zeros([1 NN]);
    Rms = zeros([1 NN]);
    M = 0;
    P = 0;
    aux = 0;
    soma = 0;
    
    %Ref: Sapucci, 2001
    for f = 1:NN
        Esu(f) = 6.1078*(10^((7.5*TEMP(f))/(237.3+TEMP(f))));%Pressão saturação do vapor d'água(hPa)
        Rms(f) = (622*Esu(f))/(PRES(f)-Esu(f)); %razão de mistura do ar saturado
    end
    Esu = Esu';
    Rms = Rms';
    
    %Ref: Singh, Ghosh, Koshyap, 2014
    for j = 2:NN
        n = j - 1;
        M = (Rms(n) + Rms(j))/2;
        P = PRES(n) - PRES(j);
        aux = M*P;
        soma = soma + aux;
    end
    g0 = 98.0665; %m/s^2
    PWV = (1/g0)*soma;      
    %Salvando o IWV correpondente ao doy 'i'
    iwv_acumulado(1,1) = mes_d;
    iwv_acumulado(1,2) = DOY_d; %Dia do ano
    iwv_acumulado(1,3) = PWV; %ZHD para o DOY
    
       %PTU medidos na superfície
        Dt(1,3) = HGHT(1,1);
        Dt(1,1) = mes_d(1,1);
		Dt(1,2) = DOY_d(1,1);
        Dt(1,4) = PRES(1,1);
        Dt(1,5) = TEMP(1,1);
        Dt(1,6) = RELH(1,1);
        
%       dlmwrite(['C:\Users\thain\Documents\VIII SBGEA\out_datas\PTU_by_height\pove\pove',num2str(DOY_d),'.txt'],[HGHT PRES TEMP RELH],'\t')
end
