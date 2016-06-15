function [RMSE, MAE]=matrics(data_rate, I_rate, U_star, V_star)
%U_star: n*k
%V_star: m*k
R_hat=U_star*V_star';
% R_hat=mapminmax(R_hat,0,1);

diff=data_rate-R_hat;
diff=I_rate.*diff;

nnn=find(I_rate==1);
nn=length(nnn);

RMSE=sum(sum((diff).^2));
RMSE=RMSE/nn;
RMSE=sqrt(RMSE);

MAE=sum(sum(abs(diff)));
MAE=MAE/nn;
