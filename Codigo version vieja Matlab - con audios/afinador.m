function afinador(Fs)
%    while(true)

%         Rec=audiorecorder(Fs,16,1);
% 
%         recordblocking(Rec,0.5);
% 
%         % transforma el audio en la variable y
%         y=getaudiodata(Rec);


        %Lee audio
        [y,Fs]=audioread('F:\Facultad\Santi\5to\Procesamiento Digital de Señales\Proyecto\Mi grupo\Audios\cuerda1_2k.wav');
        y = y(:,1);
        filtered_signals = filtrar(y, Fs);
        
        [cuerda, frecuencia] = analizar(filtered_signals, Fs);

        % Limpio texto para que solo figure el resultado de la cuerda
        %clc;
        afinar(cuerda, frecuencia);
%    end
end