% This script models and simulates the behavior of a line containing 20 wheat plants 
% when subjected to traveling wind forces. The simulation investigates the swaying response 
% of the wheat plants due to variations in wind frequencies. Both rectangular pulse wind and 
% sinusoidal wind can be considered.

% Clear command window and workspace for clean start
clc
clear

% Define simulation time settings
time = 30;
time_step = 0.001;
time_vector = 0:time_step:time;
time_count = length(time_vector);

% Define the wheat field and individual wheat characteristics
field_length = 8; %m
edge = 0.1;
wheat_rotational_stiffness = 1.05; % N*m/deg
wheat_rotational_damping = 0.0025; % N*m/(deg*s)
wheat_radius = 0.006; % m
wheat_stem_height = 0.8; 
wheat_stem_density = 600; % kg/m^3
wheat_grain_density = 600;
wheat_grain_height = 0.15;
wheat_grain_radius = 0.03;
wheat_gap = wheat_stem_height/2;

% Define the wind force acting on the plant
% The force is a combination of a fixed component (alpha*wind) 
% and a component based on the height difference (beta*height difference*wind)
beta = 0;   
alpha = 50;
gain = -800;

% Define the wind's characteristics
wind_amplitude = 1;
wind_frequency = 10;
wind_phase_cycle = 10;
wind_amplitude = 1;
wind_frequency = 50; % 1/sec
wind_phase_cycle = wind_frequency*5;

% Specify type of wind: 0 for rectangular pulse wind, 1 for sinusoidal wind
if_wind_sine = 0;

% Define external force parameters on wheat
force_amplitude = 5; %N

% Define frequency list for wind
wind_frequency_list = 2.0:0.1:3.0;
step_size = 0.01; % your fixed step size
wind_period_list = 1 ./ wind_frequency_list;
wind_period_discrete = round(wind_period_list ./ step_size) * step_size;
wind_frequency_discrete = 1 ./ wind_period_discrete;

% Initialize results container
result = [];

% Run the simulation for each wind frequency
for wind_frequency=wind_frequency_discrete
    wind_phase_cycle = wind_frequency*5;
    out = sim('wheat_line_20_travelling_wind_2019b','StartTime','0','StopTime',num2str(time),'FixedStep',num2str(time_step));
    result = [result out];    
end

% Save the simulation results
save('wheat_line_travelling_wind_rectangular_alpha_50_beta_0_near_freq.mat', 'result', 'wind_frequency_list', 'time_vector');
