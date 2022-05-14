P = [0.2 0, 0.8;
    0.2, 0.3 0.5
    0.1, 0, 0.9]
mc = dtmc(P)
mc.P
%graphplot(mc);
%figure
graphplot(mc,'ColorEdges',true);
figure();
rng(1); % For reproducibility
numSteps = 5;
X = simulate(mc,numSteps)
simplot(mc,X,'Type','transitions');
figure();