n = 1;
P=[0 1 0 0;
    sin(pi*n/5).^2 0 cos(pi*n/5).^2 0;
    0 0 0 1;
    cos(pi*n/10).^2 0 sin(pi*n/10).^2 0
    ];
p0 = [1/2*sin(pi*n/6).^2 1/2*cos(pi*n/6).^2 1/2*sin(pi*n/12).^2 1/2*cos(pi*n/12).^2].'
p0



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

x0 = zeros(1, 4);
x0(number) = 1;



X = [0.5 0.5 0 0];
for i = 1:101
    X = X * P;
end

X
sum(X)