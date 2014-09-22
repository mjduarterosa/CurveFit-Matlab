function [k,fitresult,gof] = fitcurve(D, V, M, A, disp)
%FITCURVE(D,V,M)
%  Fit model M to data D,V
%
%  Input:
%      X Input Data  : D
%      Y Output Data : V
%      M Model       : 'hyper' or 'exp'
%      A Parameter
%  Output:
%      k : model coefficient
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.

% Prepare data to fit.
[xData, yData] = prepareCurveData(D,V);

% Choose model
switch M   
    case 'hyper'
        curve = 'A/(1+a*x)';
    case 'exp'
        curve = 'A*exp(-a*x)';   
end

% Set up fit options.
fo = fitoptions( 'Method', 'NonlinearLeastSquares','StartPoint',0);
ft = fittype(curve,'coeff',{'a'},'indep','x','depen','y','problem','A','options',fo);

% Fit model to data.
[fitresult, gof] = fit(xData,yData,ft,'problem',A);
k = fitresult.a;

if disp
    
    % Plot fit with data.
    figure('Name', 'Model fit');
    plot(xData,yData,'o');
    hold on
    plot(fitresult,'m');
    legend({'Data','Model fit'});
    title(sprintf('Model fit: D vs V / k = %d A = %d',k,A));
    
    % Label axes
    xlabel('D');
    ylabel('V');
    xlim([min(xData)-1,max(xData)+1]);
    ylim([min(yData)-1,max(yData)+1]);
    grid on
    hold off
    
end