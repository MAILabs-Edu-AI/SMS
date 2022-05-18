

n = 1
P=[0 1 0 0;
    sin(pi*n/5).^2 0 cos(pi*n/5).^2 0;
    0 0 0 1;
    cos(pi*n/10).^2 0 sin(pi*n/10).^2 0
    ];
p0 = [1/2*sin(pi*n/6).^2 1/2*cos(pi*n/6).^2 1/2*sin(pi*n/12).^2 1/2*cos(pi*n/12).^2];
mc = dtmc(P);

% 
% n = 1
% P=[0 1 0 0;
%     sin(pi*n/10).^2 0 cos(pi*n/10).^2 0;
%     0 0 0 1;
%     cos(pi*n/20).^2 0 sin(pi*n/20).^2 0
%     ];
% p0 = [1/2*sin(pi*n/15).^2;1/2*cos(pi*n/15).^2; 1/2*cos(pi*n/25).^2; 1/2*sin(pi*n/25).^2];
% mc = dtmc(P);







display('Матрица Интенсивностей переходов')
mc.P
figure;
graphplot(mc,'ColorEdges',true);
%rng(42); % For reproducibility
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
Pi_t = redistribute(mc,numSteps,'X0',x0);

figure;
distplot(mc, Pi_t);
figure
simplot(mc,X);

% ТРИВИАЛЬНАЯ ОЦЕНКА

display('Тривиальная оценка')
X_t = zeros(1, 4);
X_t(X(numSteps)) = 1;
delta_t =  Pi_t(numSteps) - X_t ;
display(transpose(delta_t) * delta_t / 3);

t = linspace(1, numSteps, numSteps);
X_t_i = [];
for i = 1:numSteps
    X_t = zeros(1, 4);
    X_t(X(i)) = 1;
    X_t_i = [X_t_i; X_t];
    
end;
figure();
plot(t, Pi_t(1:numSteps, 1));
hold on
plot(t, X_t_i(1:numSteps, 1)) ;
set(gca,'fontname','Arial Cyr') 
title('Тривиальная оценка состояния 1');
figure();

plot(t, Pi_t(1:numSteps, 2));
hold on
plot(t, X_t_i(1:numSteps, 2)) ;
set(gca,'fontname','Arial Cyr') 
title('Тривиальная оценка состояния 2');
figure();

plot(t, Pi_t(1:numSteps, 3));
hold on
plot(t, X_t_i(1:numSteps, 3)) ;
set(gca,'fontname','Arial Cyr') 
title('Тривиальная оценка состояния 3');
figure();

plot(t, Pi_t(1:numSteps, 4));
hold on
plot(t, X_t_i(1:numSteps, 4)) ;
set(gca,'fontname','Arial Cyr') 
title('Тривиальная оценка состояния 4');






% Линейная оценка
C = [1 2 3 4];
sig = [1 10 100 1000] ;
%sig = [0.01 0.015 0.02 0.025 ]

display('Линейная оценка ошибки')
K_kalman = k_kalman(P, p0, Pi_t(numSteps, 1:4), numSteps, C.', sig.');
display(K_kalman);

X_kalman_i = [];
for i = 1:numSteps
    X_kalman = x_kalman(P, p0, Pi_t(i, 1:4), i, C.', sig.');
    X_kalman_i = [X_kalman_i; X_kalman];
end;

figure();

plot(t, X_kalman_i(1:numSteps, 1));
hold on
plot(t, X_t_i(1:numSteps, 1)) ;
set(gca,'fontname','Arial Cyr') 
title('Линейная оценка состояния 1');
figure();

plot(t, X_kalman_i(1:numSteps, 2));
hold on
plot(t, X_t_i(1:numSteps, 2)) ;
set(gca,'fontname','Arial Cyr') 
title('Линейная оценка состояния 2');
figure();

plot(t, X_kalman_i(1:numSteps, 3));
hold on
plot(t, X_t_i(1:numSteps, 3)) ;
set(gca,'fontname','Arial Cyr') 
title('Линейная оценка состояния 3');
figure();

plot(t, X_kalman_i(1:numSteps, 4));
hold on
plot(t, X_t_i(1:numSteps, 4)) ;
set(gca,'fontname','Arial Cyr') 
title('Линейная оценка состояния 4');





% Линейная оценка
C = [1 2 3 4];
sig = [1 10 100 1000] ;
%sig = [0.01 0.015 0.02 0.025 ]




X_neline_i = [];
for i = 1:numSteps
    X_neline = x_neline(Pi_t(i, 1:4), C.', sig.');
    X_neline_i = [X_neline_i; X_neline.'];
end;

figure();

plot(t, X_neline_i(1:numSteps, 1));
hold on 
plot(t, X_t_i(1:numSteps, 1)) ;
set(gca,'fontname','Arial Cyr') 
title('Нелинейная оценка состояния 1');
figure();

plot(t, X_neline_i(1:numSteps, 2));
hold on 
plot(t, X_t_i(1:numSteps, 2)) ;
set(gca,'fontname','Arial Cyr') 
title('Нелинейная оценка состояния 2');
figure();

plot(t, X_neline_i(1:numSteps, 3));
hold on 
plot(t, X_t_i(1:numSteps, 3)) ;
set(gca,'fontname','Arial Cyr') 
title('Нелинейная оценка состояния 3');
figure();

plot(t, X_neline_i(1:numSteps, 4));
hold on 
plot(t, X_t_i(1:numSteps, 4)) ;
set(gca,'fontname','Arial Cyr') 
title('Нелинейная оценка состояния 4');



display('Нелинейная оценка ошибки')
display(diag(X_neline_i(numSteps, 1:4)) - X_neline_i(numSteps, 1:4) * X_neline_i(numSteps, 1:4).');








