function data = parseVoyanticTagformanceData(fileName)
    file = fopen(fileName);
    fileContent = fscanf(file, '%c');
    fclose(file);

    dateHeader = 'Date:';
    dateFormat = 'dd.MM.yyy';
    minDateIndex = 1 + length(dateHeader) + 1; %There is a space after the header and before the date
    maxDateIndex = minDateIndex + length(dateFormat);
    timeHeader = 'Time:';
    timeFormat = 'HH:mm';
    minTimeIndex = maxDateIndex + 3 + length(timeHeader) + 1; %There is a carrier return after date and a space after the header and before the date
    maxTimeIndex = minTimeIndex + length(timeFormat);
    endOfLine = '\r\n';

    frequencySweepsBoundaries = [strfind(fileContent, dateHeader) length(fileContent)];

    timestamp = datetime(datevec(zeros(1, length(frequencySweepsBoundaries) - 1)));
    
    version = textscan(fileContent, '%*s%s%*[^\n\r]', 1, 'Delimiter', '\t', 'TextType', 'string', 'HeaderLines' , 1, 'ReturnOnError', false, 'EndOfLine', endOfLine);
    version = version{1,1};

    for index = 1:length(frequencySweepsBoundaries) - 1
        if index == 59
            a = 1;
        end
        innerFile = fileContent(frequencySweepsBoundaries(index):frequencySweepsBoundaries(index + 1) - 2);
        switch version
            case '1.3'
                headerLine = 10;
            case '1.4'
                headerLine = 11;
        end
        % TODO: Unify parsing across 1.3 file (with 10 header lines) and 1.4 file (with 11 header lines)
        innerFileContent = textscan(innerFile, '%s%s%s%s%s%s%s%s%s%s%*[^\n\r]', 'Delimiter', '\t', 'TextType', 'string', 'HeaderLines' , headerLine, 'ReturnOnError', false, 'EndOfLine', endOfLine);
        frequency{index} = str2double(strrep(innerFileContent{1,1}, ',', '.'));
        power{index} = str2double(strrep(innerFileContent{1,2}, ',', '.'));
        RSSI{index} = str2double(strrep(innerFileContent{1,3}, ',', '.'));
        phase{index} = str2double(strrep(innerFileContent{1,4}, ',', '.'));
        electricField{index} = str2double(strrep(innerFileContent{1,5}, ',', '.'));
        deltaRCS{index} = str2double(strrep(innerFileContent{1,6}, ',', '.'));
        powerOnTagForward{index} = str2double(strrep(innerFileContent{1,7}, ',', '.'));
        powerOnTagReverse{index} = str2double(strrep(innerFileContent{1,8}, ',', '.'));
        readRangeForward{index} = str2double(strrep(innerFileContent{1,9}, ',', '.'));
        readRangeReverse{index} = str2double(strrep(innerFileContent{1,10}, ',', '.'));

        %TIMESTAMP EXTRACTION
        date = datetime(innerFile(minDateIndex:maxDateIndex), 'InputFormat', dateFormat);
        time = datetime(innerFile(minTimeIndex:maxTimeIndex), 'InputFormat', timeFormat);
        tempDate = datenum(date);
        tempDate = addtodate(tempDate, hour(time), 'hour');
        tempDate = addtodate(tempDate, minute(time), 'minute');
        timestamp(index) = datetime(datevec(tempDate));
        
        %METADATA EXTRACTION
        metadataLineContent = textscan(innerFile, '%s%s%s%s%s%s%*s%*[^\n\r]', 1, 'Delimiter', '\t', 'TextType', 'string', 'HeaderLines' , 8, 'ReturnOnError', false, 'EndOfLine', '\r\n');
        comment{index} = metadataLineContent{1,2};
        angle(index) = str2double(strrep(metadataLineContent{1,4}, ',', '.'));
        antenna(index) = str2double(strrep(metadataLineContent{1,6}, ',', '.'));
    end
    
    comment = comment';
    angle = angle';
    antenna = antenna';
    frequency = frequency';
    power = power';
    RSSI = RSSI';
    phase = phase';
    electricField = electricField';
    deltaRCS = deltaRCS';
    powerOnTagForward = powerOnTagForward';
    powerOnTagReverse = powerOnTagReverse';
    readRangeForward = readRangeForward';
    readRangeReverse = readRangeReverse';
    data = table(timestamp, comment, angle, antenna, frequency, power, RSSI, phase, electricField, deltaRCS, powerOnTagForward, powerOnTagReverse, readRangeForward, readRangeReverse);
end

