function X_kalman = x_kalman(P, p0, x, t, C, sig)
    K_t = (diag(p0) - p0 * transpose(p0));
    %K_t = (diag(x) - x * transpose(x));
    for i = 1:t
        K_t = P * K_t * P.';
    end
    R = sig.^2 * x
    X_t = x + sqrt(R) * normrnd(0, 1);
    Y = C * X_t + sig * X_t * normrnd(0, 1);
    %K_C_mul = 
    %Y_X_sub = ;
    %C_K_R_inv = ;
    X_kalman_not_lim  =  x + K_t * C.' * (inv(C * K_t * C.' + R)) * (Y - C * X_t);
    for i = 1:4
        if X_kalman_not_lim(i) > 1
            X_kalman_not_lim(i) = 1
        end
        if X_kalman_not_lim(i) < 0
            X_kalman_not_lim(i) = 0
        end
        X_kalman_not_lim(i) = round( X_kalman_not_lim(i));
        
    end
    
        
    X_kalman = X_kalman_not_lim
    
    %X_kalman = X_kalman / sum(X_kalman);
end
