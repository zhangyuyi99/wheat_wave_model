% This script models the effect of wind on a line of 20 wheat plants using Simulink.
% The wind is represented as a sine wave that travels in the direction of the wheat line.
% Each wheat plant experiences a phased variation in wind due to its position in the line and 
% the sinusoidal nature of the traveling wind. The model produced is named 'travelling_wind_sine' 
% and employs sine wave generators in Simulink to mimic the wind's effect on each individual wheat.

% Check if the model 'travelling_wind_sine' exists. If so, close and delete it.
if bdIsLoaded('travelling_wind_sine')
    close_system('travelling_wind_sine', 1)
end

% Create and open a new Simulink model named 'travelling_wind_sine'.
new_system('travelling_wind_sine')
open_system('travelling_wind_sine')

% Define parameters for the wind's sinusoidal model.
wind_amplitude = 1;
wind_frequency = 5;
wind_phase_cycle = 10;

% Add Sine Wave blocks to the model, simulating the phased wind effect on each wheat plant.
% The phase of each sine wave changes according to the plant's position, simulating 
% the traveling nature of the wind.
for i=1:20
    add_block('simulink/Sources/Sine Wave', ['travelling_wind_sine/Sine Wave' num2str(i)]);
    set_param(['travelling_wind_sine/Sine Wave' num2str(i)], 'Amplitude', 'wind_amplitude', 'Frequency', 'wind_frequency', 'Phase', ['2*pi/wind_phase_cycle*' num2str(i)]);
end

% Add a Mux block to combine the outputs of the Sine Waves, and a To Workspace block 
% to save the combined signal to the MATLAB workspace.
add_block('simulink/Signal Routing/Mux', 'travelling_wind_sine/Mux');
set_param('travelling_wind_sine/Mux', 'Inputs', '20');
add_block('simulink/Sinks/To Workspace', 'travelling_wind_sine/To Workspace');
set_param('travelling_wind_sine/To Workspace', 'VariableName', 'output');

% Connect the Sine Wave blocks to the Mux, and then connect the Mux to the To Workspace block.
for i=1:20
    add_line('travelling_wind_sine', ['Sine Wave' num2str(i) '/1'], ['Mux/' num2str(i)]);
end
add_line('travelling_wind_sine', 'Mux/1', 'To Workspace/1');

% Save and close the model named 'travelling_wind_sine'.
save_system('travelling_wind_sine')
close_system('travelling_wind_sine')
