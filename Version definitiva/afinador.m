function afinador(Fs)

    [ui_gauge, label] = ui_medidor();

    figure('OuterPosition', [0.5, 0, 0.5, 1]);

   Rec=audiorecorder(Fs,16,1);

   while(true)


        recordblocking(Rec,0.25);

        % transforma el audio en la variable y
        y=getaudiodata(Rec);

        % test the program with a white noise generator
        % y = wgn(1, 100000, 1);
        % pause(0.5)
        



%       %Lee audio
%       [y,Fs]=audioread('F:\Facultad\Santi\5to\Procesamiento Digital de Se�ales\Proyecto\Mi grupo\Audios\cuerda1_2k.wav');
%       y = y(:,1);
        filtered_signals = filtrar(y, Fs);
        
        [cuerda, frecuencia] = analizar(filtered_signals, Fs);

        % Limpio texto para que solo figure el resultado de la cuerda
        clc;
        texto = afinar(cuerda, frecuencia);
        ui_gauge.Value = frecuencia;
        label.Text = texto;
        % ui_update_gauge(ui_gauge, frecuencia, cuerda);

        % plotear_original(y, Fs);
        plotear_filtradas(filtered_signals, Fs, y, cuerda);


   end
end