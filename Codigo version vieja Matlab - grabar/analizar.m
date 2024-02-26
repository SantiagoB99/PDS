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