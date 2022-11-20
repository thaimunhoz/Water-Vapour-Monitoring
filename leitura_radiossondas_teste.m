function [Prf,DOY, mes] = leitura_radiossondas_teste()
    clear all
    clc

    base_dir = 'C:\Users\thain\Documents\FAPESP\2º Renovação\Dados de Entrada\Radiossonda\Parâmetros de entrada';
    filename = 'SP_2020'; % Aqui você mudará para cada estação
    filepath = fullfile(base_dir, filename);
    arquivo = fopen(filepath);

    MthSTRall={'Jan';'Feb';'Mar';'Apr';'May';'Jun';'Jul';'Aug';'Sep';'Oct';'Nov';'Dec'};
    iDate=0;
    a = 1;
    while 1
        line=fgetl(arquivo); % Lê o arquivo
        if ~ischar(line)
            break
        end
        if(length(line)>11 & strcmp(line(6:21),'Observations at '))%Quando encontrar essa frase que aparece antes dos dados começa a contar
            dozeZ=line(22:24); %12Z ou 00Z
            if (dozeZ == '00Z')
                continue
            end
            Day=str2num(line(26:27)); %dia
            MthSTR=line(29:31);%mês String
            Yr=str2num(line(33:36)); %ano
            Mth=find(strcmp(MthSTR,MthSTRall)==1);%transforma string enm numero
            fgetl(arquivo);%pula 4 linhas
            fgetl(arquivo);
            fgetl(arquivo);
            fgetl(arquivo);

            iDate=iDate+1;
            t = datetime(Yr,Mth,Day); %gera uma data em formato DD-MM-YY
            doy = day( datetime(t, 'InputFormat', 'dd-MMM-yyyy' ), 'dayofyear' ); %função do Matlab que calcula o doy
            Prf(iDate,1).Doy = doy;
            DOY(a) = doy
            mes(a) = Mth;
            a = a + 1;

            ih=0;
            idData=0; 
            while (idData==0)
                line=fgetl(arquivo);
                if(length(line)>11 & strcmp(line(1:40),'Station information and sounding indices'))% Quando encontra a frase começa a contar colunas pra ler variaveis
                    idData=1;
                    continue
                end
                ih=ih+1;
                PRES=str2num(line(2:7));   %Pressão atmosférica em hPa
                HGHT=str2num(line(9:14));  %HGHT: Altura Ortométrica em metros;
                TEMP=str2num(line(16:21)); %TEMP: Temperatura em Celsius;
                Dwpt=str2num(line(23:28)); %DWPT: Temperatura do Ponto de Orvalho em Celsius;
                RELH=str2num(line(30:35)); %FRPT: Frost Point Temperature em Celsius;
                Frpt=str2num(line(37:42)); %RELH: Umidade relativa em %;
                Reli=str2num(line(43:49)); %RELI: Umidade relativa em relação ao gelo em %;
                Mixr=str2num(line(51:56)); %MIXR: Massa de ar seco em g/kg;
                Drct=str2num(line(59:63)); %DRCT: Direção do vento em graus;
                Sknt=str2num(line(66:70)); %SKNT: Velocidade do vento em nós;
                Thta=str2num(line(72:77)); %THTA: Temperatura pote ncial em Kelvin;
%                 Thte=str2num(line(79:84)); %THTE: Temperatura potencial equivalente em Kelvin;
%                 Thtv=str2num(line(86:91)); %THTV: Temperatura potencial virtual em Kelvin.

                %Caso seja vazio essas variaveis ele não irá ler...só se todas
                %tiverem valor...
                if(~isempty(PRES) & ~isempty(HGHT) & ~isempty(TEMP) & ~isempty(Dwpt) & ~isempty(Frpt) & ~isempty(RELH) & ~isempty(Reli) & ~isempty(Mixr) & ~isempty(Drct) & ~isempty(Sknt) & ~isempty(Thta))
                Prf(iDate,1).P(ih,1)=PRES;
                Prf(iDate,1).h(ih,1)=HGHT;
                Prf(iDate,1).TEMP(ih,1)=TEMP;
                Prf(iDate,1).Dwpt(ih,1)=Dwpt;
                Prf(iDate,1).Frpt(ih,1)=Frpt;
                Prf(iDate,1).Relh(ih,1)=RELH;
                Prf(iDate,1).Reli(ih,1)=Reli;
                Prf(iDate,1).Mixr(ih,1)=Mixr;
                Prf(iDate,1).Drct(ih,1)=Drct;
                Prf(iDate,1).Sknt(ih,1)=Sknt;
                Prf(iDate,1).Thta(ih,1)=Thta;
%                 Prf(iDate,1).Thte(ih,1)=Thte;
%                 Prf(iDate,1).Thtv(ih,1)=Thtv;

                end
            end

        end
    end
    fclose (arquivo);
    DOY = DOY';
    mes = mes';
    %Deleta as linhas do arquivo Prf correspondente as leituras 00Z
%     Prf(1:2:end,:) = [];
%     DOY(1:2:end,:) = [];
%     mes(1:2:end,:) = [];
end
