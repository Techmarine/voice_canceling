close all;
clear all;
clc;

% filename = 'Moelleux.mp3';                  %Igorrr - Moelleux
% filename = 'Caros.mp3';                     %Igorrr - Caros
% filename = 'Dorma.mp3';                     %Corpo-Mente - Dorma
filename = 'Ostina.mp3';                    %Whourkr - Ostina
[data,sample_rate] = audioread(filename);   %decoding
left = data(:,1);                           %left channel
right = data(:,2);                          %right channel
%Cut off frequencies-------------------------------------------------------
f1 = 300;                                   %for Caros Dorma and Ostina
% f1 = 400;                                   %for Moelleux
% f2 = 1100;                                  %for Caros and Dorma 
f2 = 800;                                   %for Ostina
% f2 = 1500;                                  %for Moelleux
%--------------------------------------------------------------------------
fleft = BandstopFilter(left,sample_rate,f1,f2);         %filtering left channel
fright = BandstopFilter(right,sample_rate,f1,f2);       %filtering right channel
fdata = [fleft,fright];                                 %combining filtered data into matrix
new_filename = strrep(filename,'.mp3','_filtered.wav'); %generating filename for new wav file
audiowrite(new_filename,fdata,sample_rate);             %encoding