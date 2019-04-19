clear all, close all, clc;

% Import the data from excel into a table
DATA = xlsread('data.xlsx',1);
X = DATA(:,1);
Y = DATA(:,2);


% Generate the figure
figure
hold on
plot(X, Y, 'ks','MarkerFaceColor','k','MarkerSize',7, 'DisplayName','Data Plot')



% Polyfit and correlation coefficent
R = corrcoef(X,Y);
r2 = (R(1,2)).^2;
p = polyfit(X,Y,1);

% Make a string with the equation and the correlation coefficient
% If the second coefficient is negative, make it so that it doesnt show +
% -number
if p(2) > 0
    eqn = ['y = ' sprintf('%3.3fx + %3.3f', p(1), p(2))];
else
    eqn = ['y = ' sprintf('%3.3fx - %3.3f', p(1), abs(p(2)))];
end
r2 = ['r^{2} = ' sprintf('%3.3f', r2)];
stats = {eqn, r2};

% Set the xlim and ylim here
% xlim([0 10])
% ylim([0 10])

% Get coordinates where put the stats on graph
xlim = get(gca,'XLim');
ylim = get(gca,'YLim');

% Plot the regression over the range
XrangeFit = xlim(1):0.01:xlim(2);
pf = polyval(p,XrangeFit);
plot(XrangeFit, pf,'--k', 'Linewidth',1,'DisplayName','Linear Fit');


% Custom fittype
% myfittype = fittype('a*exp(-b*x)+c',...
%     'dependent',{'y'},'independent',{'x'},...
%     'coefficients',{'a','b','c'});
% myfit = fit(X,Y,myfittype);
% plot(myfit,'--r');
% v = coeffvalues(myfit);
% customFit = ['y = ' sprintf('%3.3f e^{%3.3f x} + %3.3f', v(1),v(2),v(3))];
% stats{end+1} = customFit;


% Plot the stats on the graph
t = text(xlim(1) + (xlim(2)-xlim(1))*0.5 ,ylim(1) + (ylim(2)-ylim(1))*0.9 , stats);
t.FontSize = 20;
t.FontSmoothing = 'on';



% Plot the legend
lgd = legend;
lgd.FontSize = 15;
lgd.Title.String = 'Legend';
lgd.Location = 'best';

% Title and labels
title({'Title'}, 'FontSize', 18)
ylabel('Molar Conductivity, \Lambda, (Sm^{-1}M^{-1})', 'FontSize', 14)
xlabel('Square root molar concentration, c^{1/2}, (M^{1/2})', 'FontSize', 14)

% Add the grid
grid on


hold off