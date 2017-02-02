%%
% 6th harmonic reduction idea
Ts = 1e-6; % sec
% DC link voltage
Vdc = 400; % Volts
% switching frequency
fsw = 10e3; % Hz
% Load
pf = 0.95;

% fundamental
ma1 = 0.8;
Pout_fund = 10e3; % VA
Sout_fund = Pout_fund/pf; % VA
fout_fund = 50; % Hz
wout_fund = 2*pi*fout_fund; % rad/sec
Vll_rms_fund = ma1*Vdc*0.612; % Volts
Iline_fund = Sout_fund/(Vll_rms_fund*sqrt(3)); % Amps
Zload = Vll_rms_fund/(Iline_fund*sqrt(3)); % Ohms
Rload = Zload*pf; % Ohms
Xload = sqrt(Zload^2-Rload^2); % Ohms
Lload = Xload/wout_fund; % Henries
Vp1 = ma1*Vdc/2; % Volts
Ip1 = Iline_fund*sqrt(2); % Amps

% third harmonic
ma3 = 0.3;

fout_three = 3*fout_fund; % Hz
wout_three = 2*pi*fout_three; % rad/sec
Vll_rms_three = ma3*Vdc*0.612; % Volts
Xload_three = Lload*wout_three; % Ohms
Rload_three = Rload; % Ohms
Zload_three = sqrt(Rload_three^2+Xload_three^2); % Ohms
Iline_three = Vll_rms_three/(Zload_three*sqrt(3)); % Amps
pf3 = Rload_three/Zload_three;
Vp3 = ma3*Vdc/2; % Volts
Ip3 = Iline_three*sqrt(2); % Amps

sim('sixth_harmonic.slx');

P1 = Vp1*Ip1*3/2;
P3 = Vp3*Ip3*3/2;
P6 = Vp3*Ip3*3/2;

%%
% Analytical sixth harmonic simulation

phase1f = [0 -2*pi/3 2*pi/3];
phase2f = [0 -2*pi/3 2*pi/3];
phase3f = [0 -2*pi/3 2*pi/3];

% phase1t = [0 -2*pi/3 2*pi/3];
% phase2t = [0 -2*pi/3 2*pi/3];
% phase3t = [0 -2*pi/3 2*pi/3];

phase1t = [0 0 0];
phase2t = [0 0 0];
phase3t = [0 0 0];

%%
% Concentrated winding
Ts = 1e-6; % sec
% DC link voltage
Vdc = 400; % Volts
% switching frequency
fsw = 10e3; % Hz
% Load
pf = 0.95;
% fundamental
efficiency = 0.99;
ma1 = 0.8;
Pout_fund = 2e3; % VA
Sout_fund = Pout_fund/pf; % VA
fout_fund = 50; % Hz
wout_fund = 2*pi*fout_fund; % rad/sec
Vll_rms_fund = ma1*Vdc/sqrt(2); % Volts
Iline_fund = Sout_fund/(Vll_rms_fund); % Amps
Zload = Vll_rms_fund/(Iline_fund); % Ohms
Rload = Zload*pf; % Ohms
Xload = sqrt(Zload^2-Rload^2); % Ohms
Lload = Xload/wout_fund; % Henries
Vp1 = Vll_rms_fund*sqrt(2); % Volts
Ip1 = Iline_fund*sqrt(2); % Amps

% third harmonic
ma3 = 0.5;

fout_three = 3*fout_fund; % Hz
wout_three = 2*pi*fout_three; % rad/sec
Vll_rms_three = ma3*Vdc/sqrt(2); % Volts
Xload_three = Lload*wout_three; % Ohms
Rload_three = Rload; % Ohms
Zload_three = sqrt(Rload_three^2+Xload_three^2); % Ohms
Iline_three = Vll_rms_three/(Zload_three); % Amps
pf3 = Rload_three/Zload_three;
Vp3 = Vll_rms_three*sqrt(2); % Volts
Ip3 = Iline_three*sqrt(2); % Amps

R1 = 5; % Ohm
Rrefl = Vdc^2/(3*Pout_fund/efficiency);
V1 = Vdc*(R1+Rrefl)/Rrefl; % V
Cdc = 100e-6; % F

% harmonic inject
injvoltmagn = 20; % V
injfreq = 300*2*pi; % rad/sec
%injphase = 225*pi/180; % rad

num = 2;
capacitor_sixth = zeros(1,num);
for k = 1:num
    injphase = k*pi/180; % rad
    sim('sixth_harmonic_concen.slx');
    capacitor_sixth(k) = cap_six(numel(cap_six));
end

%%
sim('sixth_harmonic_concen.slx');

