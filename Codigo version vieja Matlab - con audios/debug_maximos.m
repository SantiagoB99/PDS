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