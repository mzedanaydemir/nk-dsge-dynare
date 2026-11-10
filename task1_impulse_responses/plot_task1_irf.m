clc; close all;

vars   = {'y','pi','r','eps_r','eps_d','eps_a'};
shocks = {'e_r','e_d','e_a'};

% IRF horizon length (do NOT rely on options_)
probe = [vars{1},'_',shocks{1}];
T = length(oo_.irfs.(probe));

for s = 1:length(shocks)
    figure('Name',['IRF to shock: ',shocks{s}],'Color','w');
    for i = 1:length(vars)
        subplot(3,2,i)
        irf_name = [vars{i},'_',shocks{s}];
        plot(1:T, oo_.irfs.(irf_name),'LineWidth',1.5)
        title(vars{i})
        grid on
    end
    sgtitle(['Impulse responses to ',shocks{s}])
end
