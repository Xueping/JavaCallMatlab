function A_tp1= update_A(T,data_cas,I_cas, num_node,lambda3,lambda4,U)
A_tp1=ones(num_node,num_node);

for i=1:num_node;
    for j=1:num_node
        if j==i
            continue;
        end
        down1=0;
        down2=0;
        up=0;
        
       ii=find(I_cas(i,:)==0);
       jj1=find(I_cas(j,ii)==1);
       iii=ii(jj1);
       for i4=1:length(iii)
           c=iii(i4);
           i5=find(data_cas(:,2*c-1)==i);
           i5=min(i5);
           down1=down1+T-data_cas(i5,2*c);
       end
       down1=lambda3*down1;%sum(T-data_cas(i,ii(jj1)));
       
       jj2=find(I_cas(j,ii)==0);
       iii2=ii(jj2);
       for k=1:length(iii2)
           c2=iii2(k);
           k2=find(data_cas(:,2*c2-1)==i);
           k2=min(k2);
           k3=find(data_cas(:,2*c2-1)==j);
           k3=min(k3);
                      
           if data_cas(k2,2*c2)<data_cas(k3,2*c2)
               down2=down2+data_cas(k3,2*c2)-data_cas(k2,2*c2);
               up=up+1;
           end
       end
       down2=lambda3*down2;
       up=2*up;
       
       down3=lambda4*(norm(U(i,:)-U(j,:)))^2;
       
       if up == 0
           A_tp1(i,j)=0.0001;
       else
           A_tp1(i,j)=up/(down1+down2+down3);
       end
    end
end