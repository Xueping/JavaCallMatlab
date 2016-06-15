function [F_value f1]=calculate_MF(A,I_rate,data_rate,U,V,num_node,lambda1,lambda2,lambda3,lambda4,f_value)

f1=I_rate.*(data_rate-U*V');
f1=1/2*sum(f1.^2);
f1=sum(f1);

f2=lambda1/2*sum(U.^2);
f2=sum(f2);

f3=lambda2/2*sum(V.^2);
f3=sum(f3);

f4=lambda3/2*f_value;

f5=0;
% fid=fopen('A_tp1.txt','r');
for i=1:num_node;
%     A_tp1_i=fgetl(fid);    
%     A_tp1_i=str2num(A_tp1_i);
    for j=i+1:num_node;
        uu=norm(U(i,:)-U(j,:));
        f5=f5+(A(i,j)+A(j,i))*uu^2;%f5=f5+A(i,j)*uu^2;
    end
end
f5=lambda4/2*f5;
% fclose(fid);

F_value=f1+f2+f3+f4+f5;
