function V_tp1 = update_V(I_rate,V,data_rate,U,num_item,K,lambda2)
V_tp1=ones(num_item,K);
for j=1:num_item
    for p=1:K
      rr=find(I_rate(:,j)==1);
      
      up=0;
      for ii=1:length(rr)
          i=rr(ii);
          up=up+U(i,p)*(data_rate(i,j)-U(ii,:)*V(j,:)'-U(i,p)*V(j,p));
      end
      
      down1=lambda2;
      
      down2=I_rate(:,j)'*U(:,p).^2;
      
      V_tp1(j,p)=up/(down1+down2);
    end
end
 V_tp1=mapminmax(V_tp1,0,1);