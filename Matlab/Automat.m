
n = 2;
P=[0 1 0 0;
    sin(pi*n/5).^2 0 cos(pi*n/5).^2 0;
    0 0 0 1;
    cos(pi*n/10).^2 0 sin(pi*n/10).^2 0
    ];
p0 = [1/2*sin(pi*n/6).^2 1/2*cos(pi*n/6).^2 1/2*sin(pi*n/12).^2 1/2*cos(pi*n/12).^2].';
mc = dtmc(P);


mdl1 = arima('Constant',1,'Variance',5);
mdl2 = arima('Constant',2,'Variance',6);
mdl3 = arima('Constant',3,'Variance',7);
mdl4 = arima('Constant',4,'Variance',8);
mdl = [mdl1; mdl2; mdl3; mdl4];


Mdl = msVAR(mc,mdl);

R = rand();
s = 0;
number = -1;
for i = 1:4
    s = s + p0(i);
    disp(s)
    if R <= s
        number = i;
        break
    end
end

x0 = zeros(1, mc.NumStates);
x0(number) = 1;

numSteps = 100;


[Y,~,SP] = simulate(Mdl,numSteps);

FS = filter(Mdl,Y,'X',X);
SS = smooth(Mdl,Y,'X',X);


figure
subplot(3,1,1)
plot(SP,'m')
yticks([1 2 3])
legend({'Simulated states'})
subplot(3,1,2)
plot(FS,'--')
legend({'Filtered s1','Filtered s2','Filtered s3'})
subplot(3,1,3)
plot(SS,'-')
legend({'Smoothed s1','Smoothed s2','Smoothed s3'})

