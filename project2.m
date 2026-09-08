% ENGR 240 project 2, Application of Curve Fitting Algorithms
%this script uses GLLS and fminsearch to fit 2 equations to experimental
%thermal conductivity for copper

% T - Tempature (K)
% k - thermal conductivity (W/m/k)
% c1 - Curve fit coefficient
% c2 - Curve fit coefficient
%c3 - Curve fit coefficient
% Sr - Sum of squared residuals
% St - Total sum of squares
%SE - Standard error
% r2 - Coefficient of determination


clear
clc
close all

% Load data
data = load('therm_con.dat');

%collum 1 is going to be temp and column 2 is conductivity
T = data(:,1);
k = data(:,2);
%number of data points
n = length(T);

% Total sum of squares
St = sum((k-mean(k)).^2);


%% Equation 1  GLLS

%inverse of k to linearize eq 1

y = 1./k;
% x matrix for eq 1
X = [1./T T.^2];

% Solving for coefficients 
c = X\y;

%store values
c1g1 = c(1);
c2g1 = c(2);

%calc predicted conductivity values
kg1 = 1./(c1g1./T + c2g1.*T.^2);

% Calc error
Sr_g1 = sum((k-kg1).^2);
SE_g1 = sqrt(Sr_g1/(n-2));

% calc r squared
r2_g1 = (St-Sr_g1)/St;


%% Equation 1 -fminsearch

%function for sum of square 
f1 = @(c) sum((k - 1./(c(1)./T + c(2).*T.^2)).^2);

%GLLS coefficients for starting guess
guess1 = [c1g1 c2g1];

%fminsearch to find c1 and c2
c = fminsearch(f1,guess1);

%store cofficients
c1f1 = c(1);
c2f1 = c(2);

%calc sum of squared residuals
kf1 = 1./(c1f1./T + c2f1.*T.^2);

% Calc error
Sr_f1 = sum((k-kf1).^2);
SE_f1 = sqrt(Sr_f1/(n-2));
r2_f1 = (St-Sr_f1)/St;


%% Equation 2 GLLS

%Inverse k to linearize eq 2
y = 1./k;
%x matrix for eq 2
X = [1./T T T.^2];

%solve for coefficient
c = X\y;

%store values
c1g2 = c(1);
c2g2 = c(2);
c3g2 = c(3);

%calc predicted conductivity values
kg2 = 1./(c1g2./T + c2g2.*T + c3g2.*T.^2);

% Calculate error
Sr_g2 = sum((k-kg2).^2);
SE_g2 = sqrt(Sr_g2/(n-3));
r2_g2 = (St-Sr_g2)/St;


%% Equation 2 fminsearch

%function for sum of squared
f2 = @(c) sum((k - 1./(c(1)./T + c(2).*T + c(3).*T.^2)).^2);

%GLSS coefficients for starting guesses
guess2 = [c1g2 c2g2 c3g2];

%fminsearch to find c1 c2 and c3
c = fminsearch(f2,guess2);

%store coefficients
c1f2 = c(1);
c2f2 = c(2);
c3f2 = c(3);

%calc predicted conductivity values
kf2 = 1./(c1f2./T + c2f2.*T + c3f2.*T.^2);

% Calculate error
Sr_f2 = sum((k-kf2).^2);
SE_f2 = sqrt(Sr_f2/(n-3));
r2_f2 = (St-Sr_f2)/St;


%% Tables
%names
Names = ["Equation 1 - GLLS";
         "Equation 1 - Fminsearch";
         "Equation 2 - GLLS";
         "Equation 2 - Fminsearch"];

%standard error and r squared values together
SE = [SE_g1; SE_f1; SE_g2; SE_f2];
r2 = [r2_g1; r2_f1; r2_g2; r2_f2];

%first table
Table1 = table(Names,SE,r2)


%all coficcients together and eq. 1 dosnt have v3 so im using 0
c1 = [c1g1; c1f1; c1g2; c1f2];
c2 = [c2g1; c2f1; c2g2; c2f2];
c3 = [0; 0; c3g2; c3f2];

%second table
Table2 = table(Names,c1,c2,c3)



%save tables
writetable(Table1,'CurveFitResults.csv');
writetable(Table2,'CurveFitCoefficients.csv');


%% Plot
%temp points for smoother curves
Tplot = linspace(min(T),max(T),300)';
%calc eq1 curves
kg1plot = 1./(c1g1./Tplot + c2g1.*Tplot.^2);
kf1plot = 1./(c1f1./Tplot + c2f1.*Tplot.^2);
%calc eq2 curves
kg2plot = 1./(c1g2./Tplot + c2g2.*Tplot + c3g2.*Tplot.^2);

kf2plot = 1./(c1f2./Tplot + c2f2.*Tplot + c3f2.*Tplot.^2);
%new figure
figure
%experimental data plotting
plot(T,k,'ko')
hold on
%all four curve fits
plot(Tplot,kg1plot,'LineWidth',1.5)
plot(Tplot,kf1plot,'LineWidth',1.5)
plot(Tplot,kg2plot,'LineWidth',1.5)
plot(Tplot,kf2plot,'LineWidth',1.5)
%graph label
xlabel('Temperature (K)')
ylabel('Thermal Conductivity (W/m/K)')
title('Copper Thermal Conductivity Curve Fits')
%legend
legend('Experimental Data', ...
       'Equation 1 - GLLS', ...
       'Equation 1 - fminsearch', ...
       'Equation 2 - GLLS', ...
       'Equation 2 - fminsearch','Location','best')

grid on
hold off
