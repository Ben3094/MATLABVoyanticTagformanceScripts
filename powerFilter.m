function data = powerFilter(data, power)
    for row = 1:size(data, 1)
        powerIndexes = data.power{row,1} == power;
        data.frequency{row, 1} = data.frequency{row, 1}(powerIndexes);
        data.power{row, 1} = data.power{row, 1}(powerIndexes);
        data.RSSI{row, 1} = data.RSSI{row, 1}(powerIndexes);
        data.phase{row, 1} = data.phase{row, 1}(powerIndexes);
        data.electricField{row, 1} = data.electricField{row, 1}(powerIndexes);
        data.deltaRCS{row, 1} = data.deltaRCS{row, 1}(powerIndexes);
        data.powerOnTagForward{row, 1} = data.powerOnTagForward{row, 1}(powerIndexes);
        data.powerOnTagReverse{row, 1} = data.powerOnTagReverse{row, 1}(powerIndexes);
        data.readRangeForward{row, 1} = data.readRangeForward{row, 1}(powerIndexes);
        data.readRangeReverse{row, 1} = data.readRangeReverse{row, 1}(powerIndexes);
    end
end

