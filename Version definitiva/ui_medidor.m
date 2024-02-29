% function for creating and updating gauge using uigauge and drawing the frequency
function [ui_gauge, label] = ui_medidor()

    gauge = uifigure("Name", "Afinador de guitarras", "Position", [100 100 300 300]);
    ui_gauge = uigauge(gauge, 'Value', 0, 'Limits', [0 500]);

    % build a ui label
    label = uilabel(gauge, 'Position', [0 250 300 50], 'FontSize', 16, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');

    pause(0.1)
    gauge.WindowState = 'maximized';
end