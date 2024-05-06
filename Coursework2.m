% Halil Ortas
% efyho4@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

% Establish communication between MATLAB and Arduino
a = arduino('COM4', 'Uno');

% Connect the GND and 5V pins of the Arduino to the ground bus “–“ and to the power bus “+”
% Connect one of the LEDs to the breadboard, with the two legs on two different lines.
% Using one jumper wire, connect the line where the long LED leg sits to a digital channel of the Arduino.
% Using one 220 Ω resistor, connect the line where the short leg of the LED sits to the ground bus “-“.

% Apply 5V tension to the LED, lightening it
writeDigitalPin(a, 'D13', 1);

% Switch off the LED
writeDigitalPin(a, 'D13', 0);

% Create a loop to make the LED blink
for i = 1:10 % Blink for 10 times
    % Turn on the LED
    writeDigitalPin(a, 'D13', 1);
    pause(0.5); % Pause for 0.5 seconds
    % Turn off the LED
    writeDigitalPin(a, 'D13', 0);
    pause(0.5); % Pause for 0.5 seconds
end


%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

% Establish communication between MATLAB and Arduino
a = arduino('COM4', 'Uno'); % Replace 'COM3' with the correct port

% Define duration and time interval
duration = 600; % seconds
time_interval = 1; % seconds

% Arrays to store acquired data
time_minutes = 0:time_interval:(duration/60); % Time in minutes
temperature_values = zeros(1, duration/time_interval);

% Simulated temperature coefficient and zero-degree voltage
TC = 0.01; % Example temperature coefficient
V0 = 0.5; % Example zero-degree voltage

% Simulate temperature data
for t = 1:length(temperature_values)
    temperature_values(t) = TC * readVoltage(a, 'A0') + V0; % Read analog voltage from A0
    pause(time_interval);
end

% Convert voltage values into temperature values
temperatures_C = (temperature_values - V0) / TC;

% Calculate statistical quantities
min_temp = min(temperatures_C);
max_temp = max(temperatures_C);
avg_temp = mean(temperatures_C);

% Display recorded data
disp('Data logging initiated - 5/3/2024');
disp('Location - Nottingham');
fprintf('\n');

for i = 1:length(time_minutes)
    fprintf('Minute\t\t%d\n', time_minutes(i));
    fprintf('Temperature\t%.2f C\n', temperatures_C(i));
    fprintf('\n');
end

fprintf('Max temp\t%.2f C\n', max_temp);
fprintf('Min temp\t%.2f C\n', min_temp);
fprintf('Average temp\t%.2f C\n', avg_temp);
fprintf('\n');
disp('Data logging terminated');

% Write data to log file
filename = 'cabin_temperature.txt';
fileID = fopen(filename, 'w');
fprintf(fileID, 'Data logging initiated - 5/3/2024\n');
fprintf(fileID, 'Location - Nottingham\n\n');

for i = 1:length(time_minutes)
    fprintf(fileID, 'Minute\t\t%d\n', time_minutes(i));
    fprintf(fileID, 'Temperature\t%.2f C\n\n', temperatures_C(i));
end

fprintf(fileID, 'Max temp\t%.2f C\n', max_temp);
fprintf(fileID, 'Min temp\t%.2f C\n', min_temp);
fprintf(fileID, 'Average temp\t%.2f C\n', avg_temp);

fprintf(fileID, '\nData logging terminated');
fclose(fileID);


%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers here