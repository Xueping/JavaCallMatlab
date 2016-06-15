function A_tp1= update_A(T,data_cas,I_cas, num_node,lambda3,lambda4,U)
A_tp1=ones(num_node,num_node);
for i=1:num_node;
    for j=1:num_node
        if j==i
            continue;
        end
        %down1=0;
        down2=0;
        up=0;
        
       ii=find(I_cas(i,:)==0);
       jj1=find(I_cas(j,ii)==1);
       down1=lambda3*sum(T-data_cas(i,ii(jj1)));
       
       jj2=find(I_cas(j,ii)==0);
       for k=1:length(jj2)
           kk=jj2(k);
           if data_cas(i,2*ii(kk))<data_cas(j,2*ii(kk))
               down2=down2+data_cas(j,ii(kk))-data_cas(i,ii(kk));
               up=up+1;
           end
       end
       down2=lambda3*down2;
       up=2*up;
       
       down3=lambda4*(norm(U(i,:)-U(j,:)))^2;
       
       if down1+down2+down3 == 0
           A_tp1(i,j)=0;
       else
           A_tp1(i,j)=up/(down1+down2+down3);
       end
    end
end