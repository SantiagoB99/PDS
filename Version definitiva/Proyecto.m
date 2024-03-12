clc;
close all;
clear all;

Fs=4000;

% debugeador(Fs);
% afinador(Fs);

main_panel = figure();
button1 = uicontrol(main_panel, 'Style', 'pushbutton', 'String', 'Debugeador', 'Position', [50 50 100 30], 'Callback', @(~,~) debugeador(Fs));
button2 = uicontrol(main_panel, 'Style', 'pushbutton', 'String', 'Afinador', 'Position', [200 50 100 30], 'Callback', @(~,~) afinador(Fs));




