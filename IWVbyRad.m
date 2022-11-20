%Determinação do IWV a partir de dados medidos pelas radiossondas e P,T,U medidos
%input data: arquivos de medições das radiosondas;
%output data: 
%       - IWV calculado a partir das radiossondas;
%       - Pressão, temperatura e umidade para cada nível;
%       - Pressão, temperatura e umidade medidos na superfície.

%Leitura dos arquivos
%PRESS: Pressão atmosférica em hPa;
%HGHT: Altura Ortométrica em metros;
%TEMP: Temperatura em Celsius;
%RELH: Umidade relativa em %; 

clc
clear all
[Prf, DOY, mes] = leitura_radiossondas_teste();

for i=1:length(Prf)
    %Leitura dos dados de cada dia "i"
    HGHT=[]; PRES=[]; TEMP=[]; RELH=[];
    DOY_d = DOY(i,1);
    mes_d = mes(i,1);
    HGHT =[HGHT; Prf(i).h];
    PRES =[PRES; Prf(i).P];
    TEMP =[TEMP; Prf(i).TEMP];
    RELH =[RELH; Prf(i).Relh]; 
    
    tam = length(HGHT);
    HGHTS=HGHT(2:tam)/1000; % altitude em km
    TEMPS=TEMP(2:tam);
    RELHS=RELH(2:tam);
    PRESS=PRES(2:tam);
    
    %Cálculo do IWV para o dia "i"
    [Dt,iwv_acumulado] = IWV_rad_modify(DOY_d,mes_d,HGHTS,PRESS,TEMPS,RELHS);
    
    IWV(i,1) = DOY_d;
    IWV(i,2) = mes_d;
    IWV(i,3) = iwv_acumulado(1,3);
    
        
    PTU(i,1) = DOY_d;
    PTU(i,2) = mes_d;
    PTU(i,3) = Dt(1,4);
    PTU(i,4) = Dt(1,5);
    PTU(i,5) = Dt(1,6);
end
doy_i = IWV(1,1);
doy_f = IWV(end,1);
a = 1;
j = 1;
k = 1;
for p = doy_i:1:doy_f
    day(k) = p;
    k = k+1;
end
ll=length(day);
res = zeros(ll,3);
day = day';
for i=1:ll
    if j == length(IWV)
        return
    else
        if day(i,1) == IWV(j,1)
            res(a,:) = IWV(j,:);
            a = a+1;
            j = j+1;
        else
            res(a,:) = NaN;
            a = a+1;
        end
    end
end
% %Salva os arquivos no Excel
cd = 'C:\Users\thain\Documents\VIII SBGEA\out_datas';
% xlswrite('IWV_MG_rad', IWV); %Mudar para cada estação
% xlswrite('PTU_ufpr_new',PTU);  %Mudar para cada estação