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