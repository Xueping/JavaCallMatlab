function U_tp1 = update_U(I_rate,V,data_rate,U,A,num_node,K,lambda1,lambda4)
U_tp1=ones(num_node,K);
% fid=fopen('A_tp1.txt','r');
for i=1:num_node
%      A_tp1_i = fgetl(fid);  
%      A_tp1_i=str2num(A_tp1_i);
    for p=1:K
        rr=find(I_rate(i,:)==1);
        
        up1=0;
        for jj=1:length(rr)
            j=rr(jj);
            up1=up1+V(j,p)*(data_rate(i,j)-U(i,:)*V(j,:)'-U(i,p)*V(j,p));
        end
        
        up2=lambda4*A(i,:)*U(:,p);%lambda4*A(i,:)*U(:,p);
        
        down1=I_rate(i,:)*V(:,p).^2;
        
        down2=lambda1;
        
        down3=lambda4*sum(A(i,:));%lambda4*sum(A(i,:));
        
        U_tp1(i,p)=(up1+up2)/(down1+down2+down3);
    end
end
 U_tp1=mapminmax(U_tp1,0,1); 



