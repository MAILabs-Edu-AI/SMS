function K_kalman = k_kalman(P, x, C, sig, K_t_1)
    R = sig.^2 * x;
    K_t = P * K_t_1 * P.' + R;
    X_t = x + sqrt(R)* normrnd(0, 1);
    K_kalman = K_t - K_t * C.' * (inv(C * K_t * C.' + (sig * X_t) * (sig * X_t))) * C * K_t; 
end
