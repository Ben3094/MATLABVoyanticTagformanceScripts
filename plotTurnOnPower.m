function fig = plotTurnOnPower(data, legendColumn)
    data = readRange2thresholdData(data);
    fig = figure;
    hold on;
    for row = 1:size(data,1)
        plot(data.frequency{row,1}, data.power{row,1});
    end
    hold off;
    xlabel("Frequency (MHz)");
    ylabel("Turn-on power (dBm)");
    legend(string(data.(legendColumn)));
end