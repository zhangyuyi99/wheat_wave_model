% Introduction:
% This script is designed to measure the natural frequency of a single wheat model 
% in MATLAB Simulink. To achieve this, forces of varying frequencies are applied 
% to the wheat model, and the resulting system response is observed. By analyzing 
% the response, we can deduce the natural frequency, which characterizes how 
% the system (in this case, the wheat) oscillates in the absence of any 
% external forces.

% Clear the command window and workspace
clc
clear

% Define simulation time parameters
time = 10; % Total simulation time in seconds
time_step = 0.05; % Time step for simulation
time_vector = 0:time_step:time; % Vector containing all time points
time_count = length(time_vector); % Number of time points in the simulation

% Set up wheat field properties
field_length = 4; % Total length of the wheat field in meters
edge = 0.1; % Edge margin of the field, not specifically used in this code segment

% Wheat stem rotational characteristics
wheat_rotational_stiffness = 1.05; % Stiffness in N*m/deg
wheat_rotational_damping = 0.0025; % Damping in N*m/(deg*s)

% Wheat physical characteristics
wheat_radius = 0.006; % Radius of the wheat stem in meters
wheat_stem_height = 0.8; % Height of the wheat stem in meters

wheat_stem_density = 600; % Density of the wheat stem in kg/m^3
wheat_grain_density = 600; % Density of the grain

wheat_grain_height = 0.15; % Height of the grain
wheat_grain_radius = 0.03; % Radius of the grain

wheat_gap = wheat_stem_height/2; % Gap or distance between wheat stems, set to half of wheat stem height

% Define the control parameters
gain = -800; % Applied force per height difference in wheat

force_amplitude = 5; % Amplitude of the force applied on wheat in Newtons

% Define a list of force frequencies to be tested
force_frequency_list= 1:0.5:10*pi;
result = []; % Initialize result vector to store the system response for each force frequency

% Loop through each frequency in the list and simulate the system response
for force_frequency=force_frequency_list
    % Simulate the system for each frequency using the 'single_wheat' Simulink model
    out = sim('single_wheat','StartTime','0','StopTime',num2str(time),'FixedStep',num2str(time_step));
    
    % Append the simulation result to the result vector
    result = [result out];
    
    % Save the results to a MAT file for analysis
    save('natural_freq_x.mat', 'result', 'force_frequency_list');
end
