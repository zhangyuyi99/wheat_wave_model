% This code models the effect of wind on a line of 20 wheat plants. 
% The wind is assumed to be travelling in the direction of the wheat line.
% Each wheat plant experiences a variation in wind due to their position 
% and the travelling nature of the wind. The resulting model is named 
% 'travelling_wind_rectangle' and uses pulse generators in Simulink to 
% represent the wind effect on each individual wheat plant.

% Check if the model 'travelling_wind_rectangle' exists. If it does, close and delete it.
if bdIsLoaded('travelling_wind_rectangle')
    close_system('travelling_wind_rectangle', 1)
end

% Create a new Simulink model named 'travelling_wind_rectangle' and open it.
new_system('travelling_wind_rectangle')
open_system('travelling_wind_rectangle')

% Define the parameters for the wind model
wind_amplitude = 1;
wind_frequency = 2; % 1/sec
wind_phase_cycle = 5;

% Add Pulse Generator blocks to the model to simulate the wind effect on each wheat plant.
% The phase delay of each pulse generator increases with the wheat plant's position, simulating 
% the travelling nature of the wind.
for i=1:20
    add_block('simulink/Sources/Pulse Generator', ['travelling_wind_rectangle/Pulse Generator' num2str(i)]);
    set_param(['travelling_wind_rectangle/Pulse Generator' num2str(i)], 'Amplitude', 'wind_amplitude', 'Period', '1/wind_frequency', 'PulseWidth', '50', 'PhaseDelay', ['1/wind_phase_cycle*' num2str(i)]);
end

% Add a Mux block to combine the outputs of the Pulse Generators and a To Workspace block 
% to save the combined signal to the MATLAB workspace.
add_block('simulink/Signal Routing/Mux', 'travelling_wind_rectangle/Mux');
set_param('travelling_wind_rectangle/Mux', 'Inputs', '20');
add_block('simulink/Sinks/To Workspace', 'travelling_wind_rectangle/To Workspace');
set_param('travelling_wind_rectangle/To Workspace', 'VariableName', 'output');

% Connect the Pulse Generator blocks to the Mux and then connect the Mux to the To Workspace block.
for i=1:20
    add_line('travelling_wind_rectangle', ['Pulse Generator' num2str(i) '/1'], ['Mux/' num2str(i)]);
end
add_line('travelling_wind_rectangle', 'Mux/1', 'To Workspace/1');

% Save the model named 'travelling_wind_rectangle' and close it.
save_system('travelling_wind_rectangle')
close_system('travelling_wind_rectangle')
