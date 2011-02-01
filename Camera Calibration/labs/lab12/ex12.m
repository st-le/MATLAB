clc;
clear;

M=load('Model.txt');
m1=load('data1.txt');
m2=load('data2.txt');
m3=load('data3.txt');
m4=load('data4.txt');
m5=load('data5.txt');
M=[M(:,1:2) ; M(:,3:4) ; M(:,5:6) ; M(:,7:8)];
m1=[m1(:,1:2) ; m1(:,3:4) ; m1(:,5:6) ; m1(:,7:8)];
m2=[m2(:,1:2) ; m2(:,3:4) ; m2(:,5:6) ; m2(:,7:8)];
m3=[m3(:,1:2) ; m3(:,3:4) ; m3(:,5:6) ; m3(:,7:8)];
m4=[m4(:,1:2) ; m4(:,3:4) ; m4(:,5:6) ; m4(:,7:8)];
m5=[m5(:,1:2) ; m5(:,3:4) ; m5(:,5:6) ; m5(:,7:8)];
M=M';
m(:,:,1)=m1';
m(:,:,2)=m2';
m(:,:,3)=m3';
m(:,:,4)=m4';
m(:,:,5)=m5';

[A,Rt] = self_calibration(M,m)