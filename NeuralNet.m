
% Define the file names
file_names = {'solar_data_mon_27th.csv', 'solar_data_tue_28th.csv', 'solar_data_wed_29th.csv','solar_data_thu_30th.csv', 'solar_data_fri_31st.csv'};

% Initialize an empty table
data = table();

% Loop through the files
for i = 1:length(file_names)
    % Load the file data
    file_data = readtable(file_names{i});
    
    % Convert the 'Time' variable to a numeric data type
    file_data.Time = datenum(file_data.Time);
    
    % Concatenate the data to the overall table
    data = [data; file_data];
end

% Split the data into input and output variables
X = data{:, 1:end-1}; % input variables
Y = data{:, end}; % output variable

% Split the data into training, testing, and validation sets
[trainInd,testInd,valInd] = dividerand(size(X,1),0.8,0.1,0.1);

X_train = X(trainInd, :);
Y_train = Y(trainInd, :);

X_test = X(testInd, :);
Y_test = Y(testInd, :);

X_val = X(valInd, :);
Y_val = Y(valInd, :);

% Define the neural network architecture
hidden_layer_size = 10;
net = fitnet(hidden_layer_size);

% Train the neural network
net.trainFcn = 'trainlm'; % Levenberg-Marquardt optimization algorithm
net.trainParam.epochs = 9000;
net.trainParam.goal = 1e-250;
net.trainParam.lr=0.0001;
net = train(net, X_train', Y_train');

% Test the neural network
Y_pred = net(X_test');
mse = mean((Y_test - Y_pred').^2);
rmse = sqrt(mse);
mape = mean(abs((Y_test - Y_pred')./Y_test))*100;

% Validate the neural network
Y_val_pred = net(X_val');
mse_val = mean((Y_val - Y_val_pred').^2);
rmse_val = sqrt(mse_val);
mape_val = mean(abs((Y_val - Y_val_pred')./Y_val))*100;

% Print the performance metrics
fprintf('Testing performance metrics:\n');
fprintf('MSE: %.4f\n', mse);
fprintf('RMSE: %.4f\n', rmse);
fprintf('MAPE: %.4f%%\n\n', mape);

fprintf('Validation performance metrics:\n');
fprintf('MSE: %.4f\n', mse_val);
fprintf('RMSE: %.4f\n', rmse_val);
fprintf('MAPE: %.4f%%\n', mape_val);
