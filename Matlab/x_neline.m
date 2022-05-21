function X_neline = x_neline(x, C, sig)
    x_new = zeros(4);
    X_t = x + normrnd(0, 1);
    Y = C * X_t + sig * X_t * normrnd(0, 1);
    for i = 1:4
        x_new(i) = X_t(i) / sig(i) * normpdf((Y - C(i)) / sig(i));
    end
    X_neline = x_new / sum(x_new);
end