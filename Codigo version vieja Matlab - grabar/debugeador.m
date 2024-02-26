function debugeador(Fs)
    Rec= audiorecorder(Fs,16,1);

    fprintf('Grabando...\n');
    recordblocking(Rec,4);
    fprintf('Fin de la grabaciÃ³n\n');

    y=getaudiodata(Rec);

%   %Lee audio
%   [y,Fs]=audioread('F:\Facultad\Santi\5to\Procesamiento Digital de Señales\Proyecto\Mi grupo\Audios\cuerda5_2k.wav');
%   y = y(:,1);

    filtered_signals = filtrar(y, Fs);

    plotear_original(y, Fs);
    plotear_filtradas(filtered_signals, Fs);
    debug_maximos(filtered_signals, Fs);
end
