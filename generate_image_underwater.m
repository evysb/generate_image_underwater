%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% If you use this code, please cite our paper. Thanks.                                                                                               %%
%% Li C, Anwar S, Porikli F. Underwater scene prior inspired deep underwater image and video enhancement[J]. Pattern Recognition, 2020, 98: 107038.   %%
%% If you have any questions, please contact Chongyi Li (lichongyi25@gmail.com).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
clc
folder1 = 'C:\Users\evelyn\Documents\DOC\NYU_GT';
save_in = 'C:\Users\evelyn\Documents\DOC\results';

type_I=[0.85,0.961,0.982];
type_IA=[0.84,0.955,0.975];
type_IB=[0.83,0.95,0.968];
type_II=[0.80,0.925,0.94];
type_III=[0.75,0.885,0.89];
type_1=[0.75,0.885,0.875];
type_3=[0.71,0.82,0.8];
type_5=[0.67,0.73,0.67];
type_7=[0.62,0.61,0.5];
type_9=[0.55,0.46,0.29];

TYPE=type_I; %% change the types

for i=1:1

image=double(imread(fullfile(folder1,strcat('REAL_',num2str(i),'.png'))))/255; % read image
%image0=image(10:1:end-11, 10:1:end-11, :); % resize and remove edge 
image0=image;
depth=imread(fullfile(folder1,strcat('DEPTH_',num2str(i),'.png'))); % read depth. 
%depth0=double(depth(10:1:end-11,10:1:end-11,:))/255; % Depth is between 0 and 1. 
depth0=double(depth(:,:,:))/255;

Number=10; % any numbers as you want (a kind of data augmentation)

deep = 5-2*rand(1,Number);
horization = 15-14.5*rand(1,Number);

for j=1:Number
A(:,:,1)=1.5*TYPE(1).^deep(j);
A(:,:,2)=1.5*TYPE(2).^deep(j);
A(:,:,3)=1.5*TYPE(3).^deep(j);
t(:,:,1)=TYPE(1).^(depth0.*horization(j));
t(:,:,2)=TYPE(2).^(depth0.*horization(j));
t(:,:,3)=TYPE(3).^(depth0.*horization(j));

%generate underwater image

I(:,:,1)=A(:,:,1).*image0(:,:,1).*t(:,:,1) + (1-t(:,:,1))*A(:,:,1);
I(:,:,2)=A(:,:,2).*image0(:,:,2).*t(:,:,2)+(1-t(:,:,2))*A(:,:,2);
I(:,:,3)=A(:,:,3).*image0(:,:,3).*t(:,:,3)+(1-t(:,:,3))*A(:,:,3);

%%if mean(I(:))>0.15 % you can change this parameter when you want to filter out some low instense images. %%

   imwrite(depth0,fullfile(save_in,'transmission_map',[strcat(num2str((i))),  '_deep_',  strcat(num2str((deep(j)))),'_hori_' strcat(num2str((horization(j)))) ,'_.bmp']));
   imwrite(image0,fullfile(save_in,'gt',[strcat(num2str((i))),   '_deep_',  strcat(num2str((deep(j)))),'_hori_' strcat(num2str((horization(j)))) ,'_.bmp']));
   imwrite(I,fullfile(save_in,'underwater_image',[strcat(num2str((i))),   '_deep_',  strcat(num2str((deep(j)))),'_hori_' strcat(num2str((horization(j)))) ,'_.bmp']));
%end
end
end
