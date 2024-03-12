function plotear_filtradas(filtered_signals, Fs, y, cuerda)

    clf();
    furY = fft(y);
    f = 0:length(furY)-1;
    subplot(4, 3, 1:3);
    plot(f*Fs/max(f), abs(furY));
    xlim([0, 500]);
    ylim([0, 20]);
    title('FFT: Señal orignal');
    xlabel('Frecuencia');
    ylabel('Amplitud');

    % figure;
    for i = 1:size(filtered_signals, 2)
        furY = fft(filtered_signals{i});
        f = 0:length(furY)-1;
        
        if(i == cuerda)
            color = 'r';
        else
            color = 'b';
        end
        subplot(4, 3, i + 3);
        plot(f*Fs/max(f), abs(furY), "Color", color);
        xlim([0, 500]);
        ylim([0, 20]);
        title(['Señal N° ' num2str(i)]);
        xlabel('Frecuencia');
        ylabel('Amplitud');
    end

    subplot(4, 3, 10:12);

    hold on;
    for i = 1:size(filtered_signals, 2) - 1
        furY = fft(filtered_signals{i});
        f = 0:length(furY)-1;
        
        plot(f*Fs/max(f), abs(furY));
        
        xlim([0, 500]);
        ylim([0, 20]);
        title(['Suma de todos los filtros']);
        xlabel('Frecuencia');
        ylabel('Amplitud');
    end
    hold off;
    legend('Cuerda 1', 'Cuerda 2', 'Cuerda 3', 'Cuerda 4', 'Cuerda 5', 'Cuerda 6');

end