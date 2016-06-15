function A_tp1= update_A(T,cascade_id,cascade_time,I_cas, num_node,lambda3,lambda4,U)
 A_tp1=ones(num_node,num_node);
%???A_tp1.txt???
% fid=fopen('A_tp1.txt','a');
% B=[];
for i=1:num_node;
    for j=1:num_node
        if j==i
            continue;
        end
        down1=0;
        down2=0;
        up=0;
        
       ii=find(I_cas(i,:)==1);
       jj1=find(I_cas(j,ii)==0);
       iii=ii(jj1);
       for i4=1:length(iii)
           c=iii(i4);
           i5=find(cascade_id(:,c)==i);
           %i5=find(data_cas(:,2*c-1)==i);
           i5=min(i5);
           down1=down1+T-cascade_time(i5,c);
           %down1=down1+T-data_cas(i5,2*c);
       end
       down1=lambda3*down1;%sum(T-data_cas(i,ii(jj1)));
       
       jj2=find(I_cas(j,ii)==1);
       iii2=ii(jj2);
       for k=1:length(iii2)
           c2=iii2(k);
           k2=find(cascade_id(:,c2)==i);
           %k2=find(data_cas(:,2*c2-1)==i);
           k2=min(k2);
           k3=find(cascade_id(:,c2)==j);
           %k3=find(data_cas(:,2*c2-1)==j);
           k3=min(k3);
                      
           if cascade_time(k2,c2) < cascade_time(k3, c2) %data_cas(k2,2*c2)<data_cas(k3,2*c2)
               down2=down2+cascade_time(k3,c2) - cascade_time(k2,c2); %data_cas(k3,2*c2)-data_cas(k2,2*c2);
               up=up+1;
           end
       end
       down2=lambda3*down2;
       up=2*up;
       
       down3=lambda4*(norm(U(i,:)-U(j,:)))^2;
       
       if up == 0
           A_tp1(i,j)=0;
       else
           A_tp1(i,j)=up/(down1+down2+down3);
       end
%        fprintf(fid,'%g\t',A_tp1);
    end
%         fprintf(fid,'%g\n',B);
end
% fclose(fid);