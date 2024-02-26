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