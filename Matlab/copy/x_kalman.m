function X_kalman = x_kalman(P, x, C, sig, K_t_1, X_t_1)
    R = sig.^2 * x;
    K_t = P * K_t_1 * P.' + R;
    X_t = x + sqrt(R)* normrnd(0, 1);
    
    Y = C * X_t + sig * X_t * normrnd(0, 1);
    %K_C_mul = 
    %Y_X_sub = ;
    %C_K_R_inv = ;
    noise_ = (sig * X_t) * (sig * X_t)

    X_kalman = x + K_t * C.' * (inv(C * K_t * C.' + noise_)) * (Y - C * x);
    %X_kalman = X_kalman / sum(X_kalman);
end
