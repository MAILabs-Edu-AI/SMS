function X_neline = x_neline(x, C, sig)
    Y = C.' * x.' + sig.' * x.' * normrnd(0, 1);
    x_new = zeros(4);
    for i = 1:4
        x_new(i) = x(i) / sig(i) * normpdf((Y - C(i)) / sig(i));
    end
    X_neline = x_new / sum(x_new);
end