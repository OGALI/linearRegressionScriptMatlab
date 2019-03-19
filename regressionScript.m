clear all, close all, clc

% Import the data from excel into a table
DATA = xlsread('data.xlsx',1);
X = DATA(:,1)
Y = DATA(:,2)
c = [32.02 20.28 12.06 8.64 2.85 1.24 0.83];
c_sqrt = sqrt([32.02 20.28 12.06 8.64 2.85 1.24 0.83]);
A = [ 50.26 51.99 54.01 55.75 57.99 58.44 58.67];

figure
hold on
plot(c_sqrt, A, '*')

% Title and labels
title('\Lambda_m versus c^{1/2} for NaI')
ylabel('Molar Conductivity, \Lambda, (Sm^{-1}M^{-1})')
xlabel('Square root molar concentration, c^{1/2}, (M^{1/2})')

% Polyfit and correlation coefficent
R = corrcoef(c_sqrt,A);
r2 = (R(1,2)).^2;
p = polyfit(c_sqrt,A,1);

% Make a string with the eqn and the correlation coefficient
eqn = ['y = ' sprintf('%3.3fx^%1.0f + ',[p ;length(p)-1:-1:0])];
r2 = ['r^{2} = ' sprintf('%3.3f', r2)];
stats = {eqn, r2};

% Set the xlim and ylim here
% xlim([0 10])
% ylim([0 10])

% Get coordinates where put the stats on graph
xlim = get(gca,'XLim');
ylim = get(gca,'YLim');

% Plot the regression over the range
X = xlim(1):0.01:xlim(2);
pf = polyval(p,X);
plot(X, pf,'--')

% Plot the stats on the graph
text(xlim(1) + (xlim(2)-xlim(1))*0.7 ,ylim(1) + (ylim(2)-ylim(1))*0.9 , stats)

% Plot the legend
legend('Data points','Linear fit','Location','best')

% Add the grid
grid on

hold off