function plotear_filtradas(filtered_signals, Fs, y, cuerda)

    clf();
    furY = fft(y);
    f = 0:length(furY)-1;
    subplot(3, 3, 1:3);
    plot(f*Fs/max(f), abs(furY));
    xlim([0, 500]);
    title('FFT of Original Signal');
    xlabel('Frequency');
    ylabel('Amplitude');

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
        title(['FFT of Filtered Signal ' num2str(i)]);
        xlabel('Frequency');
        ylabel('Amplitude');
    end

    subplot(4, 3, 10:12);

    hold on;
    for i = 1:size(filtered_signals, 2)
        furY = fft(filtered_signals{i});
        f = 0:length(furY)-1;
        
        plot(f*Fs/max(f), abs(furY));
        
        xlim([0, 500]);
        title(['FFT of Filtered Signal ' num2str(i)]);
        xlabel('Frequency');
        ylabel('Amplitude');
    end
    hold off;
    legend('Cuerda 1', 'Cuerda 2', 'Cuerda 3', 'Cuerda 4', 'Cuerda 5', 'Cuerda 6');

end