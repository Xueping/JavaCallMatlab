function [result U_star V_star]=main_ParemeterChoose(lambda1, lambda2, lambda3, lambda4, K, count)

load data_sample.mat

diff_conver=100;
T_window=1;
R_sum_star=10000;
longestlen=3000;

[cascade_id cascade_time data_rate I_cas I_rate cas_len num_item num_node T_window sparsity] = datareform_movielens(data_sample,longestlen);
A_t=ones(num_node,num_node);
result=[];
result1=[];
tic;
%initialization
U_t=eye(num_node,K);
V_t=eye(num_item,K);

f_value_t=calculate_f(A_t,T_window,cascade_id,cascade_time,cas_len,I_cas, num_item);
F_value_t=calculate_MF(A_t,I_rate,data_rate,U_t,V_t,num_node,lambda1,lambda2,lambda3,lambda4,f_value_t);
c=0;
diff=1000; 
while abs(diff) > diff_conver  && c < count
    %update A, U, V.
    A_tp1= update_A(T_window,cascade_id,cascade_time,I_cas,num_node,lambda3,lambda4,U_t);
    aa=max(A_tp1);
    aa=max(aa);
    A_tp1=A_tp1/aa;
    
    U_tp1 = update_U(I_rate,V_t,data_rate,U_t,A_tp1,num_node,K,lambda1,lambda4);
    V_tp1 = update_V(I_rate,V_t,data_rate,U_tp1,num_item,K,lambda2);
    
    % calculate value of the main function
    f_value_tp1=calculate_f(A_tp1,T_window,cascade_id,cascade_time,cas_len,I_cas,num_item);
    [F_value_tp1, f1] =calculate_MF(A_tp1,I_rate,data_rate,U_tp1,V_tp1,num_node,lambda1,lambda2,lambda3,lambda4,f_value_tp1);
    diff=F_value_t-F_value_tp1;
    % A_t=A_tp1;
    U_t=U_tp1;
    V_t=V_tp1;
    F_value_t=F_value_tp1;
    
    c=c+1;
    
    [RMSE, MAE]=matrics(data_rate, I_rate, U_t, V_t);
    time=toc;
    R_sum=RMSE+MAE;
    
    result1=[R_sum RMSE MAE c lambda1 lambda2 lambda3 lambda4 K F_value_tp1 time]
    result=[result;result1];
      
    if R_sum < R_sum_star
        R_sum_star = R_sum;
        U_star= U_t;
        V_star= V_t;
    end
    
end
                    
