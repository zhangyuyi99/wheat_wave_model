clc
clear
time = 20;
time_step = 0.05;
time_vector = 0:time_step:time;
time_count = length(time_vector);

field_length = 4; %m
edge = 0.1;
wheat_rotational_stiffness = 1.05; % N*m/deg
wheat_rotational_damping = 0.005; % N*m/(deg*s)

wheat_radius = 0.006; % m
wheat_stem_height = 0.8; 

wheat_stem_density = 600; % kg/m^3
wheat_grain_density = 600;

wheat_grain_height = 0.15;
wheat_grain_radius = 0.03;

wheat_gap = wheat_stem_height/2;

x_wind_gain = -300; % Applied force per height difference
x_wind_amplitude = 0.7;
x_wind_bias = 0;
x_wind_frequency = 4; % rad/s

y_wind_gain = -300; % Applied force per height difference
y_wind_amplitude = x_wind_amplitude;
y_wind_bias = x_wind_bias;
y_wind_frequency = x_wind_frequency; % rad/s

F = [time_vector' 2*ones(time_count,10)];

sim('wheat_field_sine_wind','StartTime','0','StopTime',num2str(time),'FixedStep',num2str(time_step));

smwritevideo('wheat_field_sine_wind', 'videos/wheat_field_sine_wind',...
'PlaybackSpeedRatio', 1.0, 'FrameRate', 10, 'VideoFormat', 'mpeg-4');
