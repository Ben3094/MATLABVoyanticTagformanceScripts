function data = frequencyFilter(data, frequencies)
    for row = 1:size(data, 1)
        frequenciesIndexes = data.frequency{row, 1} == frequencies;
        if all(frequenciesIndexes == 0)
            data.frequency{row, 1} = NaN;
            data.power{row, 1} = NaN;
            data.RSSI{row, 1} = NaN;
            data.phase{row, 1} = NaN;
            data.electricField{row, 1} = NaN;
            data.deltaRCS{row, 1} = NaN;
            data.powerOnTagForward{row, 1} = NaN;
            data.powerOnTagReverse{row, 1} = NaN;
            data.readRangeForward{row, 1} = NaN;
            data.readRangeReverse{row, 1} = NaN;
        else
            data.frequency{row, 1} = data.frequency{row, 1}(frequenciesIndexes);
            data.power{row, 1} = data.power{row, 1}(frequenciesIndexes);
            data.RSSI{row, 1} = data.RSSI{row, 1}(frequenciesIndexes);
            data.phase{row, 1} = data.phase{row, 1}(frequenciesIndexes);
            data.electricField{row, 1} = data.electricField{row, 1}(frequenciesIndexes);
            data.deltaRCS{row, 1} = data.deltaRCS{row, 1}(frequenciesIndexes);
            data.powerOnTagForward{row, 1} = data.powerOnTagForward{row, 1}(frequenciesIndexes);
            data.powerOnTagReverse{row, 1} = data.powerOnTagReverse{row, 1}(frequenciesIndexes);
            data.readRangeForward{row, 1} = data.readRangeForward{row, 1}(frequenciesIndexes);
            data.readRangeReverse{row, 1} = data.readRangeReverse{row, 1}(frequenciesIndexes);
        end
    end
end

