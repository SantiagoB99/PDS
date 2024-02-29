function debugeador(Fs)
    Rec= audiorecorder(Fs,16,1);

    fprintf('Grabando...\n');
    recordblocking(Rec,2);
    fprintf('Fin de la grabación\n');

    y=getaudiodata(Rec);

%   %Lee audio
%   [y,Fs]=audioread('F:\Facultad\Santi\5to\Procesamiento Digital de Se�ales\Proyecto\Mi grupo\Audios\cuerda5_2k.wav');
%   y = y(:,1);
    clc;
    filtered_signals = filtrar(y, Fs);

    plotear_original(y, Fs);
    plotear_filtradas(filtered_signals, Fs);
    debug_maximos(filtered_signals, Fs);
end
