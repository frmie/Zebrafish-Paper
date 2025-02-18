function [Mean1,Var1] = One_component_Normal_Distribution_MlE(Velocity_Data)
%Maximum likelyhood estimation for one component normal distribution.
% This function calculates the Estimators and Confidence Intervals

Velocity_Data=Velocity_Data(Velocity_Data<1);
Velocity_Data=Velocity_Data(Velocity_Data>0.1);
if length(Velocity_Data) == 1
    Velocity_Data=[Velocity_Data Velocity_Data+0.1];
end

% One component normal distribution
pdf_normmixture = @(x,mu1,sigma1) ...
normpdf(x,mu1,sigma1);

% Mle options
options = statset('MaxIter',10000, 'MaxFunEvals',10000);

%Bounds
lb = [0 0];
ub = [1 1];

% Start Parameters
muStart = mean(Velocity_Data);
sigmaStart = std(Velocity_Data);
start = [muStart sigmaStart];

%Perform MLE
[Ests] = mle(Velocity_Data, 'pdf',pdf_normmixture, 'start',start, ...
'lower',lb, 'upper',ub, 'options',options);
Mean1=Ests(1);
Var1=Ests(2);
end

