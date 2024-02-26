clc;
close all;
clear all;

Fs=4000;

% debugeador(Fs);
afinador(Fs);

function debugeador(Fs)
    Rec= audiorecorder(Fs,16,1);

    fprintf('Grabando...\n');
    recordblocking(Rec,4);
    fprintf('Fin de la grabación\n');

    y=getaudiodata(Rec);

    filtered_signals = filtrar(y, Fs);

    plotear_original(y, Fs);
    plotear_filtradas(filtered_signals, Fs);
    debug_maximos(filtered_signals, Fs);
end

function afinador(Fs)
    while(true)

        Rec=audiorecorder(Fs,16,1);

        recordblocking(Rec,0.5);

        % transforma el audio en la variable y
        y=getaudiodata(Rec);

        filtered_signals = filtrar(y, Fs);
        
        [cuerda, frecuencia] = analizar(filtered_signals, Fs);

        % Limpio texto para que solo figure el resultado de la cuerda
        clc;
        afinar(cuerda, frecuencia);
    end
end

function filtered_signals = filtrar(y, Fs)
    %Cuerda 1
    cuerda1_freq_inf = 310.7;
    cuerda1_freq_sup = 369.96;

    %Cuerda 2
    cuerda2_freq_inf = 220;
    cuerda2_freq_sup = 285.30;

    %Cuerda 3
    cuerda3_freq_inf = 169.64;
    cuerda3_freq_sup = 220;

    %Cuerda 4
    cuerda4_freq_inf = 127;
    cuerda4_freq_sup = 169.64;

    %Cuerda 5
    cuerda5_freq_inf = 95.21;
    cuerda5_freq_sup = 127;

    %Cuerda 6
    cuerda6_freq_inf = 150.22;
    cuerda6_freq_sup = 180.42;                                                           % Frecuencia normalizada

    cuerdas = [
        [cuerda1_freq_inf cuerda1_freq_sup];
        [cuerda2_freq_inf cuerda2_freq_sup];
        [cuerda3_freq_inf cuerda3_freq_sup];
        [cuerda4_freq_inf cuerda4_freq_sup];
        [cuerda5_freq_inf cuerda5_freq_sup];
        [cuerda6_freq_inf cuerda6_freq_sup]
    ];

    % normalize the frequency
    for i = 1:size(cuerdas, 1)
        cuerdas(i, :) = cuerdas(i, :)/(Fs/2);
    end

    % Filter each channel and output to an array
    filtered_signals = cell(1, size(cuerdas, 1));
    for i = 1:size(cuerdas, 1)
        [B, A] = butter(4, cuerdas(i, :), 'bandpass');
        BP = {B, A};
        filtered_signals{i} = filter(BP{1}, BP{2}, y);
    end
end


function [cuerda, frecuencia] = analizar(filtered_signals, Fs)

    maximos = cell(1, size(filtered_signals, 2));

    % Calculate single-sided amplitude spectrum
    for i = 1:size(filtered_signals, 2)
        P2 = abs(fft(filtered_signals{i})/length(filtered_signals{i}));
        P1 = P2(1:length(filtered_signals{i})/2+1);
        P1(2:end-1) = 2*P1(2:end-1);
        
        f = Fs*(0:(length(filtered_signals{i})/2))/length(filtered_signals{i});
        
        % Find frequency with maximum amplitude
        [max_amplitude, index_max] = max(P1);
        freq_max_amplitude = f(index_max);

        maximos{i} = [max_amplitude, freq_max_amplitude];

        % fprintf('La frecuencia con la amplitud m�xima de la se�al de salida filtrada para el filtro %i es %.2f Hz y su amplitud es %f\n', i, freq_max_amplitude, max_amplitude);
    end
    
    % check for the maximum amplitude on maximos to determine the cuerda. Then say the cuerda
    max_amplitude = 0;
    cuerda = 0;
    for i = 1:size(maximos, 2)
        if maximos{i}(1) > max_amplitude
            max_amplitude = maximos{i}(1);
            cuerda = i;
            frecuencia = maximos{i}(2);
        end
    end

    fprintf('La cuerda que se est� tocando es la %i\n', cuerda)
    
end

function afinar(cuerda, frecuencia)
    freq_cuerda_1 = 329.63;
    freq_cuerda_2 = 246.94;
    freq_cuerda_3 = 196.00;
    freq_cuerda_4 = 146.83;
    freq_cuerda_5 = 110.00;
    freq_cuerda_6 = 164.82;

    frecuencias = [
        freq_cuerda_1;
        freq_cuerda_2;
        freq_cuerda_3;
        freq_cuerda_4;
        freq_cuerda_5;
        freq_cuerda_6
    ];

    % check if the frecuency is within 2% of the cuerda frequency using a loop
    for i = 1:6

        if cuerda == i 
            frec_conocida = frecuencias(i);

            if frecuencia > frec_conocida*0.98 && frecuencia < frec_conocida*1.02
                fprintf('La cuerda %i est� afinada\n', cuerda);
            else
                fprintf('La cuerda %i no est� afinada\n', cuerda);

                if frecuencia < frec_conocida
                    fprintf('Ajuste la cuerda\n');
                else
                    fprintf('Afloje la cuerda\n');
                end

            end
        end
    end
end

function plotear_original(y, Fs)

    figure;
    furY = fft(y);
    f = 0:length(furY)-1;
    plot(f*Fs/max(f), abs(furY));
    xlim([0, 700]);
    title('FFT of Original Signal');
    xlabel('Frequency');
    ylabel('Amplitude');
end

function plotear_filtradas(filtered_signals, Fs)

    figure;
    for i = 1:size(filtered_signals, 2)
        furY = fft(filtered_signals{i});
        f = 0:length(furY)-1;
        
        subplot(2, 3, i);
        plot(f*Fs/max(f), abs(furY));
        xlim([0, 700]);
        title(['FFT of Filtered Signal ' num2str(i)]);
        xlabel('Frequency');
        ylabel('Amplitude');
    end
end

function debug_maximos(filtered_signals, Fs)

    maximos = cell(1, size(filtered_signals, 2));

    fprintf('Las frecuencias maximas y sus amplitudes son:\n');
    % Calculate single-sided amplitude spectrum
    for i = 1:size(filtered_signals, 2)
        P2 = abs(fft(filtered_signals{i})/length(filtered_signals{i}));
        P1 = P2(1:length(filtered_signals{i})/2+1);
        P1(2:end-1) = 2*P1(2:end-1);
        
        f = Fs*(0:(length(filtered_signals{i})/2))/length(filtered_signals{i});
        
        % Find frequency with maximum amplitude
        [max_amplitude, index_max] = max(P1);
        freq_max_amplitude = f(index_max);

        maximos{i} = [max_amplitude, freq_max_amplitude];   

        fprintf('Filtro %i: \t %.2f Hz \t Amp: %f\n', i, freq_max_amplitude, max_amplitude);
    end


end