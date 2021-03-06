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
Ts = 1e-5; % sec
% DC link voltage
Vdc = 540; % Volts
% switching frequency
fsw = 2e3; % Hz
% Load
pf = 0.9;
% fundamental
efficiency = 0.99;
ma1 = 0.8;
Pout_fund = 4e3; % VA
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
 ma3 = 0;
%ma3 = 0.475;
phase3 = 30*pi/180;
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
injvoltmagn = 0; % V
injfreq = 300*2*pi; % rad/sec
injphase = 225*pi/180; % rad

phase3 = 0;
%phasegrid = 120;

% tic
% num = 360;
% capacitor_sixth = zeros(1,num);
% for k = 1:num
%     injphase = k*pi/180; % rad
%     sim('sixth_harmonic_concen.slx');
%     capacitor_sixth(k) = cap_six(numel(cap_six));
% end
% toc
phasegrid = 35.5;
% for k = 1:60
%     phasegrid = k;
%     sim('sixth_harmonic_concen2.slx');
%     myfaz(k) = rectifiers(numel(rectifiers));
% end

sim('sixth_harmonic_makale.slx');

%%
gridangle = 1:60;
figure;
plot(gridangle,myfaz,'b -','Linewidth',1.5);
grid on;
set(gca,'FontSize',12);
xlabel('Grid phase shift (degrees)','FontSize',12,'FontWeight','Bold')
ylabel('DC link input sixth harmonic phase (degrees)','FontSize',12,'FontWeight','Bold')


%%
angle = 1:360;
figure;
plot(angle,capacitor_sixth,'b -','Linewidth',1.5);
grid on;
set(gca,'FontSize',12);
xlabel('Phase shift (degrees)','FontSize',12,'FontWeight','Bold')
ylabel('Capacitor sixth Harmonic (A)','FontSize',12,'FontWeight','Bold')


%%
Vp1 = Vll_rms_fund*sqrt(2);
Ip1 = Iline_fund*sqrt(2);
Vp3 = Vll_rms_three*sqrt(2);
Ip3 = Iline_three*sqrt(2);
phi1rad = acos(pf);
pf3 = Rload/Zload_three;
phi3rad = acos(pf3);
phi1 = phi1rad*180/pi;
phi3 = phi3rad*180/pi;

tfinal = 0.1;
timeaxis = 0:Ts:0.1;
ptotal1 = (3/2)*Vp1*Ip1*cos(phi1rad)*ones(1,numel(timeaxis));
ptotal2 = (3/2)*Vp3*Ip3*cos(phi3rad)*ones(1,numel(timeaxis));
ptotal3 = (3/2)*Vp3*Ip3*cos(6*wout_fund*timeaxis-phi3rad);
ptotal = ptotal1+ptotal2+ptotal3;

itotal1 = (3/2)*Vp1*Ip1*cos(phi1rad)/Vdc;
itotal2 = (3/2)*Vp3*Ip3*cos(phi3rad)/Vdc;
itotaldc = itotal1+itotal2;
itotal3 = (3/2)*Vp3*Ip3/Vdc;
idcsixthphaserad = -pi/2-phi3rad;
idcsixthphase = idcsixthphaserad*180/pi;


%%
idcfig = idc(:,2)';
pdcfig = Vdc*idcfig;
figure;
plot(timeaxis,10*ptotal3,'b -','Linewidth',1.5);
hold on;
plot(timeaxis,pdcfig,'r -','Linewidth',1.5);
hold off;
grid on;
set(gca,'FontSize',12);
xlabel('Time (Sec)','FontSize',12,'FontWeight','Bold')
ylabel('DC Link Power (W)','FontSize',12,'FontWeight','Bold')
xlim([0.08 0.1])

%%
% power factor
frequency_fundamental = 50;
power_factor_fundamental = 0:0.01:1;
Vdc = 400;
ma1 = 0.8;
Pout_fund = 2e3; % VA
Sout_fund = Pout_fund./power_factor_fundamental; % VA
wout_fund = 2*pi*frequency_fundamental; % rad/sec
Vll_rms_fund = ma1*Vdc/sqrt(2); % Volts
Iline_fund = Sout_fund/(Vll_rms_fund); % Amps
Zload = Vll_rms_fund./Iline_fund; % Ohms
Rload = Zload.*power_factor_fundamental; % Ohms
Xload = sqrt(Zload.^2-Rload.^2); % Ohms
Lload = Xload/wout_fund; % Henries

Xthird_harm = Xload*3;
Zthird_harm = sqrt(Rload.^2+Xthird_harm.^2);
power_factor_thirdharm = Rload./Zthird_harm;

figure;
plot(power_factor_fundamental,power_factor_thirdharm,'b -','Linewidth',1.5);
grid on;
set(gca,'FontSize',12);
xlabel('Fundamental power factor','FontSize',12,'FontWeight','Bold')
ylabel('Third harmonic power factor','FontSize',12,'FontWeight','Bold')
%xlim([0.08 0.1])

phase_sixth_harmonic = (-acos(power_factor_thirdharm)-pi/2)*180/pi;


figure;
plot(power_factor_fundamental,phase_sixth_harmonic,'r -','Linewidth',1.5);
grid on;
set(gca,'FontSize',12);
xlabel('Fundamental power factor','FontSize',12,'FontWeight','Bold')
ylabel('Sixth harmonic phase','FontSize',12,'FontWeight','Bold')
%xlim([0.08 0.1])

