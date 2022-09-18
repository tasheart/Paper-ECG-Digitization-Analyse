%% Digitize Picture:

%% 

%PAPER ECG DIGITIZER, PART II: CALIBRATION AND ANALYSIS 
%%produced by Ahmet Tas (ahmettas.cor@gmail.com)

% A = input('type variable file name here:  ')
A = data
% YATAY= input('number of big boxes in paper record?  ')
YATAY = 10
figure(1)
plot(A(:,1)*YATAY/(max(A(:))-min(A(:))),A(:,2)...
    ,"LineWidth",1,"Color",'r')
yline(-2: 0.1 : 4,"Color",'#002B5C');
xline(0: 2 : 20,"Color",'#002B5C','LineStyle','-');
xline(0,"LineWidth",1,"Color",'#002B5C','LineStyle','--')
yline(0,"LineWidth",1,"Color",'#002B5C')
ylabel('mV (per big sq)')
xlabel('0,2 ms (per big sq)')

%% Voltage Calibration
Y = A(:,2)

title('Please mark (click) upper and lower points of reference segment mV of your choice:  ')
Choose_Reference_Segment_Borders = ('Please mark (click) upper and lower points of reference segment mV of your choice:  ')
mVreference_UP = ginput(1)
mVreference_DOWN = ginput(1)
R = mVreference_UP(1,2)-mVreference_DOWN(1,2)


ReferenceSegmentmV = input('Please enter reference segment mV of your choice:  ')

title('Please choose(click) a point on isoelectric line')

%yeni plot - voltaj kalibre
figure(2);
plot(A(:,1)*YATAY/(max(A(:))-min(A(:))),Y*(ReferenceSegmentmV/R)...
    ,"LineWidth",1,"Color",'r')
yline(-2: 0.1 : 4,"Color",'#002B5C');
% xline(0: 0.2 : 20,"Color",'#002B5C','LineStyle','-');
% xline(0,"LineWidth",1,"Color",'#002B5C','LineStyle','--')
yline(0,"LineWidth",1,"Color",'#002B5C')
ylabel('mV (per big sq)')
xlabel('0,2 ms (per big sq)')
%% Isoelectric Line
zoom(1.2)
title('Please choose a point on isoelectric line  ')
isoelectric_choose = ('Please choose a point on isoelectric line')
isoelectric = ginput(1)


figure(3)
plot(A(:,1)*YATAY/(max(A(:))-min(A(:))),Y*(ReferenceSegmentmV/R)-isoelectric...
    ,"LineWidth",1,"Color",'g')

yline(-2: 0.1 : 4,"Color",'#002B5C');
% xline(0: 0.2 : 20,"Color",'#002B5C','LineStyle','-');
% xline(0,"LineWidth",1,"Color",'#002B5C','LineStyle','--')
yline(0,"LineWidth",1,"Color",'#002B5C')
ylabel('mV (per big sq)')
xlabel('0,2 ms (per big sq)')



%% 


% %% ST Shift
% format shortG;
% zoom(1.5)
% zoom('on')
% title('click J point:')
% J= ginput(1)
% mVST = num2str(J(1,2))
% stmat = ['ST shift  ',mVST,'  mV.']
% disp(stmat)

%% ST Shift and ST AREA
hold on;
figure(3);
brush
title('brush the ST segment by holding left click')
STintegralMatris= input('copy brushed data here. Place brackets as shown: [ data ]')



yi= smooth(STintegralMatris(:,2));
plot(STintegralMatris(:,1),yi,'LineWidth',1,'Color','b')
SeciliSegmentAlanBoya = area(STintegralMatris(:,1),STintegralMatris(:,2));
STintegral = trapz(STintegralMatris(:,1),STintegralMatris(:,2))
hold on;
area(STintegralMatris(:,1),STintegralMatris(:,2))
mVST = STintegralMatris(1,2)

%% 

% %% T PEAK AND AREA


hold on;
figure(3);
brush
title('brush the entire T wave by holding left click')
TwaveMatris= input('copy brushed data here. Place brackets as shown: [ data ]')



yi= smooth(TwaveMatris(:,2));
hold on;
plot(TwaveMatris(:,1),yi,'LineWidth',1,'Color','b')
area(TwaveMatris(:,1),TwaveMatris(:,2));
T_wave_area = trapz(TwaveMatris(:,1),TwaveMatris(:,2))
T_Amplitude = max(abs(TwaveMatris(:,2)))


%% QT 
figure(4);
brush
zoom(2)
plot(A(:,1)*YATAY/(max(A(:))-min(A(:))),Y*(ReferenceSegmentmV/R)-isoelectric...
    ,"LineWidth",1,"Color",'g')

yline(-2: 0.1 : 4,"Color",'#002B5C');
% xline(0: 0.2 : 20,"Color",'#002B5C','LineStyle','-');
% xline(0,"LineWidth",1,"Color",'#002B5C','LineStyle','--')
yline(0,"LineWidth",1,"Color",'#002B5C')
ylabel('mV (per big sq)')
xlabel('0,2 ms (per big sq)')
title('brush from beginning of Q to end of T wave')
QTmatrix= input('copy brushed data here. Place brackets as shown: [ data ]')

QT = (max(QTmatrix(:,1)) - min(QTmatrix(:,1)))*0.2



%%
% APPROVE RESULTS

Results = [round(STintegralMatris(1,2),2) round(STintegral,4) round(T_Amplitude,2) round(T_wave_area,4) round(QT,2)]
open("Results")
% text('type clear before prooceding next patient')
% FINAL REPORT IN EXCEL FORMAT
% open('...')
