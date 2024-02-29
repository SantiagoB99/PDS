function plotear_original(y, Fs)

    furY = fft(y);
    f = 0:length(furY)-1;
    subplot(4, 3, 1:4);
    plot(f*Fs/max(f), abs(furY));
    xlim([0, 700]);
    title('FFT of Original Signal');
    xlabel('Frequency');
    ylabel('Amplitude');
end