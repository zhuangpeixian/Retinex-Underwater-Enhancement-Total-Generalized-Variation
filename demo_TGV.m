%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cited IEEE ISPA 2019 paper: Underwater Image Enhancement with Total Generalized Variation Illumination Prior, 
%% Zhengjie Zhao, Yuxiang Dai, Peixian Zhuang, 2019.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Code written by Peixian Zhuang, Nanjing University of Information Science and Technology
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;  clc; clear all;

%% Input Raw Image
img1 = double(imread('Ori2.jpg'));

%% Color Correction
img   = double(color(img1,2.5));


%% RGB TurnTo HSV
cform = makecform('srgb2lab'); 
lab = applycform(uint8(img), cform);
LL=lab(:,:,1);
A=lab(:,:,2);
B=lab(:,:,3);


%% Retinex Variational Enhancement
[R, L] = retinex_variation_enhancement_TGV(img, LL);


%% Post-Processing
[L11] = illumination_adjust(L,15,230); 
R11  = adapthisteq(R);  


%% HSV ReTurnTo RGB
lab(:,:,1)   = L11.*R11;
cform  = makecform('lab2srgb'); 
enhanced2 = applycform(lab, cform);
enhanced2 = cast(enhanced2, 'uint8');


%% Output Display
figure,imshow(uint8([img1, enhanced2]));

