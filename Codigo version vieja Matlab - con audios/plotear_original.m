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