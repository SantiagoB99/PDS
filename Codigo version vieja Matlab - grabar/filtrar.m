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