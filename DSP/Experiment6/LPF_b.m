function [bd,ad]=LPF_b(wp,ws,Rp,As,Fs)
T=1/Fs;
Omgp=(2/T)*tan(wp/2);
Omgs=(2/T)*tan(ws/2);
[n,Omgc]=buttord(Omgp,Omgs,Rp,As,'s')
% [z0,p0,k0]=buttap(n);
% ba1=k0*real(poly(z0));
% aa1=real(poly(p0));
% [ba,aa]=lp2lp(ba1,aa1,Omgc);
[ba,aa]=butter(n,Omgc,'s');% 直接求模拟滤波器系数

[bd,ad]=bilinear(ba,aa,Fs);%双线性变换法


% [bd,ad]=impinvar(ba,aa,Fs);% 脉冲响应不变法
