    data_monday = readtable('solar_data_mon_6th.csv');
    data_tuesday = readtable('solar_data_tue_7th.csv');
    data_wednesday = readtable('solar_data_wed_8th.csv');
    data_thursday = readtable('solar_data_thu_9th.csv');
    data_friday = readtable('solar_data_fri_10th.csv');

    
    targets_monday = table2array(data_monday(:, 7));
    targets_tuesday = table2array(data_tuesday(:, 7));
    targets_wednesday = table2array(data_wednesday(:, 7));
    targets_thursday = table2array(data_thursday(:, 7));
    targets_friday = table2array(data_friday(:, 7));
    
    targets = cat(1, targets_monday, targets_tuesday, targets_wednesday, targets_thursday, targets_friday);
    
    predicted_monday = (data_monday.Current .* data_monday.Voltage);
    predicted_tuesday = (data_tuesday.Current .* data_tuesday.Voltage);
    predicted_wednesday = (data_wednesday.Current .*data_wednesday.Voltage);
    predicted_thursday = (data_thursday.Current .* data_thursday.Voltage);
    predicted_friday = (data_friday.Current .* data_friday.Voltage);

    predicted = cat(1,predicted_monday, predicted_tuesday,predicted_wednesday,predicted_thursday, predicted_friday);
    
   % Evaluate the accuracy of the ANN model
    mae = mean(abs(predicted - targets));
    rmse = sqrt(mean((predicted - targets).^2));
    mape = mean(abs((predicted - targets) ./ targets)) * 100;
    r2 = 1 - sum((predicted - targets).^2)/sum((targets-mean(targets)).^2);
    
    fprintf('Overall performance metrics for the week:\n');
fprintf('MAE: %.2f W\n', mae);
fprintf('RMSE: %.2f W\n', rmse);
fprintf('MAPE: %.2f%%\n', mape);
fprintf('R^2: %.2f\n', r2);
