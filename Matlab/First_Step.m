

n =2
P=[0 1 0 0;
    sin(pi*n/5).^2 0 cos(pi*n/5).^2 0;
    0 0 0 1;
    cos(pi*n/10).^2 0 sin(pi*n/10).^2 0
    ];
p0 = [1/2*sin(pi*n/6).^2 1/2*cos(pi*n/6).^2 1/2*sin(pi*n/12).^2 1/2*cos(pi*n/12).^2];
mc = dtmc(P);
mc.P
figure
graphplot(mc,'ColorEdges',true);
rng(42); % For reproducibility
numSteps = 100;


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
% for i = 1:4
%     s1 = sum(p0(1:i));
%     s2 = sum(p0(1:i+1));
%     if i == 1
%         s1 = 0;
%     end
%     if (R < s2) && (R > s1)  
%         number = i;
%         break
%     end
% end

%p0 = [0.5, 0.5, 0, 0];
X = simulate(mc, numSteps, 'X0', x0);
Pi_t = redistribute(mc,numSteps,'X0',p0);
figure;
distplot(mc, Pi_t);
figure
simplot(mc,X);

cov_i = [];
delta_t_i = [];

display('COV')
X_t = zeros(1, 4)
X_t(X(100)) = 1
delta_t =  Pi_t(100) - X_t 
display(transpose(delta_t) * delta_t / 3)

t = linspace(1,numSteps);
X_t_i = [];
for i = 1:100
    X_t = zeros(1, 4)
    X_t(X(i)) = 1;
    X_t_i = [X_t_i; X_t];
    
end;

figure();

plot(t, Pi_t(1:100, 1), t, X_t_i(1:100, 1)) 
title('X1')
figure();

plot(t, Pi_t(1:100, 2), t, X_t_i(1:100, 2)) 
title('X2')
figure();

plot(t, Pi_t(1:100, 3), t, X_t_i(1:100, 3)) 
title('X3')
figure();

plot(t, Pi_t(1:100, 4), t, X_t_i(1:100, 4))
title('X4')