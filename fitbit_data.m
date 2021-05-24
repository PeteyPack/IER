clc
clear all
close all

FITBITDATA = readmatrix('Data_analysis_Data_IER.csv');
App = FITBITDATA(:, [6,29,30,31,32,33,34,35]);  %Only choose the steps counted by the App
Om  = FITBITDATA(:, [6,43,47,51,55,59,63,67]);  %Only choose the steps counted by Om
App2019 = App([1:94],[1:8]);    %Choose the steps counted by the app in 2019
App2019(isnan(App2019))=0;      %Remove NaN value and replace it with 0

Om2019  = Om([1:94],[1:8]);     %Choose the steps counted by the app in 2020
Om2019(isnan(Om2019))=0;        %Remove NaN value and replace it with 0

App2020 = App([95:193],[1:8]);  %Choose the steps counted by Om in 2019
App2020(isnan(App2020))=0;      %Remove NaN value and replace it with 0

Om2020  = Om([95:193],[1:8]);   %Choose the steps counted by Om in 2020
Om2020(isnan(Om2020))=0;        %Remove NaN value and replace it with 0


TotstepApp2019 = sum(App2019,2);    %sum all the steps taken in the week 
TotstepApp2020 = sum(App2020,2);    %sum all the steps taken in the week 
TotstepOm2019 = sum(Om2019,2);      %sum all the steps taken in the week 
TotstepOm2020 = sum(Om2020,2);      %sum all the steps taken in the week 

pdA19 = fitdist(TotstepApp2019, 'Normal')  %find Standard deviaton and the mean from the App2019 data
pdA20 = fitdist(TotstepApp2020, 'Normal')  %find Standard deviaton and the mean from the App2020 data
pdO19 = fitdist(TotstepOm2019, 'Normal')   %find Standard deviaton and the mean from the Om2019 data
pdO20 = fitdist(TotstepOm2020, 'Normal')   %find Standard deviaton and the mean from the Om2020 data

muA19 =pdA19.mu                            %stores the mean found in pdA19
muA20 =pdA20.mu                            %stores the mean found in pdA20
 
muO19 =pdO19.mu                            %stores the mean found in pdO19
muO20 =pdO20.mu                            %stores the mean found in pdO20

sigA19 =pdA19.sigma;                        %stores the standard deviation found in pdA19
sigA20 =pdA20.sigma;                        %stores the standard deviation found in pdA20
 
sigO19 =pdO19.sigma;                        %stores the standard deviation found in pdO19
sigO20 =pdO20.sigma;                        %stores the standard deviation found in pdO20

DiffA1920 = (muA19-muA20)/muA19*100         %Calculate the difference in steps between 2019 and 2020 collected by the App
DiffO1920 = (muO19-muO20)/muO19*100         %Calculate the difference in steps between 2019 and 2020 collected by the OMRON

DiffsigA1920 = (sigA19-sigA20)/sigA19*100   %Calculate the difference in standard deviation between 2019 and 2020 collected by the App
DiffsigO1920 = (sigO19-sigO20)/sigO19*100   %Calculate the difference in standard deviation between 2019 and 2020 collected by the OMRON     

figure
a = histfit(TotstepApp2019,94);
title('App 2019')
xlabel('Amount of steps')
ylabel('Amount of people')

figure
b = histfit(TotstepApp2020,99);
title('App 2020')
xlabel('Amount of steps')
ylabel('Amount of people')

figure
c = histfit(TotstepOm2019,94);
title('Om 2019')
xlabel('Amount of steps')
ylabel('Amount of people')

figure
d = histfit(TotstepOm2020,99);
title('Om 2020')
xlabel('Amount of steps')
ylabel('Amount of people')


DataCan = (40.5+22.4)/2;            %Average activity decline taken from the study 'The Impact of COVID-19 on Physical Activity Behavior and Well-Being of Canadians' https://doi.org/10.3390/ijerph17113899 
DataGer = 44.5;                     %Average activity decline taken from the study 'Alteration of physical activity during COVID-19 pandemic lockdown in young adults' https://translational-medicine.biomedcentral.com/articles/10.1186/s12967-020-02591-7
DataIta = 65;                       %Average activity decline taken from the study 'COVID-19 lockdown: Physical activity, sedentary behaviour and sleep in Italian medicine students' https://doi-org.tudelft.idm.oclc.org/10.1080/17461391.2020.1842910
DataChi = (30.6+37.0+18.0+22.5)/4;  %Average activity decline taken from the study 'Obesity and activity patterns before and during COVID-19 lockdown among youths in China' https://doi.org/10.1111/cob.12416

X = categorical({'Ned App','Ned Om','Canada','Germany','Italy','China'});
X = reordercats(X,{'Ned App','Ned Om','Canada','Germany','Italy','China'});
y = [DiffsigA1920 DiffsigO1920 DataCan DataGer DataIta DataChi]
figure
bar(X,y)
ylabel('Percentage difference')
xlabel('Countries')


