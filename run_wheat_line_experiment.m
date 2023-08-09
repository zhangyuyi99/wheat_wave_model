clc
clear
time = 10;
time_step = 0.05;
time_vector = 0:time_step:time;
time_count = length(time_vector);

field_length = 4; %m
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

gain = -800; % Applied force per height difference

F = [time_vector' 2*ones(time_count,10)];

sim('wheat_line','StartTime','0','StopTime',num2str(time),'FixedStep',num2str(time_step));
