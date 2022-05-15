function K_kalman = k_kalman(P, p0, x, t, C, sig)
    K_t = (diag(p0) - p0 * transpose(p0));
    %K_t = (diag(x) - x * transpose(x));
    for i = 1:t
        K_t = P.' * K_t * P;
    end
    R = transpose(sig) * diag(x) * sig;
    K_C_mul = K_t * C;
    K_kalman = K_t - K_C_mul * (inv(C.' * K_C_mul + R)) * C.' * K_t; 
end
