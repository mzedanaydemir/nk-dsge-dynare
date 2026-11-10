clc; clear;

gdp = readtable('GDPC1.csv');
cpi = readtable('CPIAUCSL.csv');
ffr = readtable('FEDFUNDS.csv');

gdp.Properties.VariableNames(1:2) = {'DATE','GDP'};
cpi.Properties.VariableNames(1:2) = {'DATE','CPI'};
ffr.Properties.VariableNames(1:2) = {'DATE','FFR'};

gdp.DATE = datetime(gdp.DATE);
cpi.DATE = datetime(cpi.DATE);
ffr.DATE = datetime(ffr.DATE);

gdp_tt = table2timetable(gdp,'RowTimes','DATE');
cpi_tt = table2timetable(cpi,'RowTimes','DATE');
ffr_tt = table2timetable(ffr,'RowTimes','DATE');

gdp_q = retime(gdp_tt,'quarterly','mean');
cpi_q = retime(cpi_tt,'quarterly','mean');
ffr_q = retime(ffr_tt,'quarterly','mean');

all_q = synchronize(gdp_q, cpi_q, ffr_q, 'intersection');

y_obs  = diff(log(all_q.GDP));        % GDP growth
pi_obs = diff(log(all_q.CPI));        % inflation
i_obs  = all_q.FFR(2:end) / 100;      % interest rate (decimal)

disp([length(y_obs) length(pi_obs) length(i_obs)])

save('model_data.mat','y_obs','pi_obs','i_obs');
disp('OK: model_data.mat olustu')
disp(['Obs sayisi = ', num2str(length(y_obs))])
