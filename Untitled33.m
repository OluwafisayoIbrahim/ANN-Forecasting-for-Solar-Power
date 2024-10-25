% Load the solar data files for each day
    data_monday = readtable('solar_data_mon_27th.csv');
    data_tuesday = readtable('solar_data_tue_28th.csv');
    data_wednesday = readtable('solar_data_wed_29th.csv');
    data_thursday = readtable('solar_data_thu_30th.csv');
    data_friday = readtable('solar_data_fri_31st.csv');
    
% Define the input and output variables for each day
inputs_monday = [data_monday.SolarIrradiance, data_monday.Current, data_monday.Voltage, data_monday.Temperature, data_monday.Humidity];
targets_monday = data_monday.Power;

inputs_tuesday = [data_tuesday.SolarIrradiance, data_tuesday.Current, data_tuesday.Voltage, data_tuesday.Temperature, data_tuesday.Humidity];
targets_tuesday = data_tuesday.Power;

inputs_wednesday = [data_wednesday.SolarIrradiance, data_wednesday.Current, data_wednesday.Voltage, data_wednesday.Temperature, data_wednesday.Humidity];
targets_wednesday = data_wednesday.Power;

inputs_thursday = [data_thursday.SolarIrradiance, data_thursday.Current, data_thursday.Voltage, data_thursday.Temperature, data_thursday.Humidity];
targets_thursday = data_thursday.Power;

inputs_friday = [data_friday.SolarIrradiance, data_friday.Current, data_friday.Voltage, data_friday.Temperature, data_friday.Humidity];
targets_friday = data_friday.Power;


% Define the time variables 
time_monday = data_monday.Time;
time_monday = datetime(time_monday, 'InputFormat', 'HH:mm');
time_tuesday = data_tuesday.Time;
time_tuesday = datetime(time_tuesday, 'InputFormat', 'HH:mm');
time_wednesday = data_wednesday.Time;
time_wednesday = datetime(time_wednesday, 'InputFormat', 'HH:mm');
time_thursday = data_thursday.Time;
time_thursday = datetime(time_thursday, 'InputFormat', 'HH:mm');
time_friday = data_friday.Time;
time_friday = datetime(time_friday, 'InputFormat', 'HH:mm');

% Train and test the ANN model for each day
[mae_monday, rmse_monday, r2_monday, outputs_monday] = train_and_test_ann(inputs_monday, targets_monday, inputs_monday, targets_monday);
[mae_tuesday, rmse_tuesday, r2_tuesday, outputs_tuesday] = train_and_test_ann(inputs_tuesday, targets_tuesday, inputs_tuesday, targets_tuesday);
[mae_wednesday, rmse_wednesday, r2_wednesday, outputs_wednesday] = train_and_test_ann(inputs_wednesday, targets_wednesday, inputs_wednesday, targets_wednesday);
[mae_thursday, rmse_thursday, r2_thursday, outputs_thursday] = train_and_test_ann(inputs_thursday, targets_thursday, inputs_thursday, targets_thursday);
[mae_friday, rmse_friday, r2_friday, outputs_friday] = train_and_test_ann(inputs_friday, targets_friday, inputs_friday, targets_friday);

predicted_monday = (data_monday.Current .* data_monday.Voltage);
predicted_tuesday = (data_tuesday.Current .* data_tuesday.Voltage);
predicted_wednesday = (data_wednesday.Current .*data_wednesday.Voltage);
predicted_thursday = (data_thursday.Current .* data_thursday.Voltage);
predicted_friday = (data_friday.Current .* data_friday.Voltage);

% Plot the predicted vs actual solar power generation for each day
figure;
plot(time_monday, targets_monday, 'b-','LineWidth', 2);
hold on;
plot(time_monday, predicted_monday, 'r-', 'LineWidth', 2);
hold on;
my_orange = [255, 165, 0] / 255;
plot(time_tuesday, targets_tuesday, 'Color', my_orange, 'LineWidth', 2)
hold on;
plot(time_tuesday, predicted_tuesday, 'k-', 'LineWidth', 2);
hold on;
plot(time_wednesday, targets_wednesday, 'g-', 'LineWidth', 2);
hold on;
my_dark_green = [0, 100, 0] / 255;
plot(time_wednesday, predicted_wednesday, 'Color', my_dark_green, 'LineWidth', 2);
hold on;
plot(time_thursday, targets_thursday, 'c', 'LineWidth', 2);
hold on;
plot(time_thursday, predicted_thursday, 'r', 'LineWidth', 2);
hold on;
my_purple = [128, 0, 128] / 255;
plot(time_friday, targets_friday, 'Color', my_purple, 'LineWidth', 2);
hold on;
my_pink = [255, 192, 203] / 255;
plot(time_friday, predicted_friday, 'Color',my_pink, 'LineWidth', 2);
xlabel('Time (hr)');
ylabel('Power (W)');
title('Solar Power Generation - Week 3');
legend('Monday Actual', 'Monday Predicted', 'Tuesday Actual', 'Tuesday Predicted', 'Wednesday Actual', 'Wednesday Predicted', 'Thursday Actual', 'Thursday Predicted', 'Friday Actual', 'Friday Predicted', 'Location', 'northwest');
grid on,


% Calculate the overall performance metrics for the whole week
mae_week = mean([mae_monday, mae_tuesday, mae_wednesday, mae_thursday, mae_friday]);
rmse_week = mean([rmse_monday, rmse_tuesday, rmse_wednesday, rmse_thursday, rmse_friday]);
r2_week = mean([r2_monday, r2_tuesday, r2_wednesday, r2_thursday, r2_friday]);

fprintf('Overall performance metrics for the week:\n');
fprintf('MAE: %.2f W\n', mae_week);
fprintf('RMSE: %.2f W\n', rmse_week);
fprintf('R^2: %.2f\n', r2_week);

% Define a function for training and testing the ANN model
function [mae, rmse, r2, outputs] = train_and_test_ann(inputs_training, targets_training, inputs_testing, targets_testing)
    % Normalize the input and target data
    [inputs_training_normalized, input_settings] = mapminmax(inputs_training');
    [targets_training_normalized, target_settings] = mapminmax(targets_training');

    inputs_testing_normalized = mapminmax('apply', inputs_testing', input_settings);
    targets_testing_normalized = mapminmax('apply', targets_testing', target_settings);
    
    % Design ANN model architecture
    num_inputs = size(inputs_training_normalized, 5);
    hidden_layer_size = 10;
    net = fitnet(hidden_layer_size);
    net.layers{1}.transferFcn = 'tansig';
    net.layers{2}.transferFcn = 'purelin';
    save('net');
    load('net.mat');

    % Select training algorithm and train the ANN model
    net.trainFcn = 'trainlm'; % Levenberg-Marquardt algorithm
    net.trainParam.epochs = 8000;
    net.trainParam.goal = 1e-250;
    net = train(net, inputs_training_normalized, targets_training_normalized);

    % Predict solar power generation using the trained ANN model
    outputs_normalized = sim(net, inputs_testing_normalized);
    outputs = mapminmax('reverse', outputs_normalized, target_settings);

    data_monday = readtable('solar_data_mon_13th.csv');
    data_tuesday = readtable('solar_data_tue_14th.csv');
    data_wednesday = readtable('solar_data_wed_15th.csv');
    data_thursday = readtable('solar_data_thu_16th.csv');
    data_friday = readtable('solar_data_fri_17th.csv');

    
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
    r2 = 1 - sum((predicted - targets).^2)/sum((targets-mean(targets)).^2);
end
