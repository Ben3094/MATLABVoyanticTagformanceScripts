function data = makefrequencyConsistent(data)
    availableFrequencies = intersect(data.frequency{1,1}, data.frequency{2,1});
    for row = 3:size(data,1)
        availableFrequencies = intersect(availableFrequencies, data.frequency{row,1});
    end
    for row = 1:size(data, 1)
        rowAvailableFrequenciesIndexes = false(length(data.frequency{row,1}),1);
        for frequencyIndex = 1:length(data.frequency{row,1})
            rowAvailableFrequenciesIndexes(frequencyIndex) = any(data.frequency{row,1}(frequencyIndex) == availableFrequencies);
        end

        %Keep only widely available frequency results
        data.frequency{row, 1} = data.frequency{row, 1}(rowAvailableFrequenciesIndexes);
        data.power{row, 1} = data.power{row, 1}(rowAvailableFrequenciesIndexes);
        data.RSSI{row, 1} = data.RSSI{row, 1}(rowAvailableFrequenciesIndexes);
        data.phase{row, 1} = data.phase{row, 1}(rowAvailableFrequenciesIndexes);
        data.electricField{row, 1} = data.electricField{row, 1}(rowAvailableFrequenciesIndexes);
        data.deltaRCS{row, 1} = data.deltaRCS{row, 1}(rowAvailableFrequenciesIndexes);
        data.powerOnTagForward{row, 1} = data.powerOnTagForward{row, 1}(rowAvailableFrequenciesIndexes);
        data.powerOnTagReverse{row, 1} = data.powerOnTagReverse{row, 1}(rowAvailableFrequenciesIndexes);
        data.readRangeForward{row, 1} = data.readRangeForward{row, 1}(rowAvailableFrequenciesIndexes);
        data.readRangeReverse{row, 1} = data.readRangeReverse{row, 1}(rowAvailableFrequenciesIndexes);
    end
end