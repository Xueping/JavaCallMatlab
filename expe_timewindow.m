
% load('result_train_set_1w_douban.mat')
index_1=find(result(:,1)==min(result(:,1)));
index_2=find(result(:,2)==min(result(:,2)));
index_3=find(result(:,3)==min(result(:,3)));
best=result([index_1;index_2;index_3],:);


% R_hat=U_t*V_t'; 
% save R_hat_3m_movielens R_hat U_t V_t;
% R_hat=R_hat*50;

%   test_set=test_set_1d;
 %test_set=test_set_1w;
% test_set=test_set_2w;
test_set=test_set_3w;




[mr,nr]=size(R_hat);

[mt,nt]=size(test_set);
count=0;
rmse=0;
mae=0;
for i=1:mt
    us=test_set(i,1);
    it=test_set(i,2);
    if us<mr+1 && it< nr+1
        diff=test_set(i,3)-R_hat(us,it);
        count=count+1;
    else
        continue;
    end
    rmse=rmse+diff^2;
    mae=mae+abs(diff);
end

 mae=mae/count/50
 rmse=sqrt(rmse/count)/50