function data = readRange2thresholdData(data)
    for row = 1:size(data, 1)
        frequencies = unique(data.frequency{row, 1});
        turnOnPowerIndexes = zeros(length(frequencies), 1);
        for index = 1:length(frequencies)
            frequencyFilter = data.frequency{row,1} == frequencies(index); %Filter frequency
            powers = data.power{row,1};
            powers(~frequencyFilter) = NaN;
            
            turnOnPowers = powers;
            turnOnPowers(isnan(data.RSSI{row,1})) = NaN;
            if ~all(isnan(turnOnPowers(:)))
                [~, turnOnPowerIndex] = min(turnOnPowers,[],'omitnan'); %TODO: fill data.power with nan where logical operation return 0
            else
                [~, turnOnPowerIndex] = max(powers);
            end
            turnOnPowerIndexes(index) = turnOnPowerIndex;
        end
        data.frequency{row,1} = data.frequency{row,1}(turnOnPowerIndexes);
        data.power{row,1} = data.power{row,1}(turnOnPowerIndexes);
        data.RSSI{row,1} = data.RSSI{row,1}(turnOnPowerIndexes);
        data.phase{row,1} = data.phase{row,1}(turnOnPowerIndexes);
        data.electricField{row,1} = data.electricField{row,1}(turnOnPowerIndexes);
        data.deltaRCS{row,1} = data.deltaRCS{row,1}(turnOnPowerIndexes);
        data.powerOnTagForward{row,1} = data.powerOnTagForward{row,1}(turnOnPowerIndexes);
        data.powerOnTagReverse{row,1} = data.powerOnTagReverse{row,1}(turnOnPowerIndexes);
        data.readRangeForward{row,1} = data.readRangeForward{row,1}(turnOnPowerIndexes);
        data.readRangeReverse{row,1} = data.readRangeReverse{row,1}(turnOnPowerIndexes);
    end
end