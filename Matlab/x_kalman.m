function X_kalman = x_kalman(P, p0, x, t, C, sig)
    K_t = (diag(p0) - p0 * transpose(p0));
    %K_t = (diag(x) - x * transpose(x));
    for i = 1:t
        K_t = P.' * K_t * P;
    end
    R = transpose(sig) * diag(x) * sig;
    Y = C.' * x.' + sig.' * x.' * normrnd(0, 1);
    %K_C_mul = 
    %Y_X_sub = ;
    %C_K_R_inv = ;
    X_kalman = x + (K_t * C).' * (inv(C.' * K_t * C + R)) * (Y - C.' * x.');
    %X_kalman = X_kalman / sum(X_kalman);
end
