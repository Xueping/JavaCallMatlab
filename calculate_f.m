% infer the impact network
function sum_f=calculate_f(A,T,cascade_id,cascade_time,cas_len,I_cas, num_item)

% U_tp1=ones(num_node,K);


sum_f=0;
for c=1:num_item
    for i=1:cas_len(c)
        ii=cascade_id(i,c);
       
        AA=0;
        for k=i+1:cas_len(c)
            kk=cascade_id(k,c);
            
%             fid=fopen('A_tp1.txt','r');
%             for kkk=1:kk
%                 A_tp1_k = fgetl(fid);  
%             end
%             fclose(fid);
%             A_tp1_k=str2num(A_tp1_k);
            
%             ii=find(data_cas(:,2*c-1)==i);
%             ii=min(ii);
%             kk=find(data_cas(:,2*c-1)==k);
%             kk=min(kk);
            sum_f=sum_f+A(kk,ii)*(cascade_time(i,c)-cascade_time(k,c));%sum_f+ A(data_cas(k,2*c-1),data_cas(i,2*c-1))*(data_cas(i, 2*c)-data_cas(k,2*c));
            AA=AA+A(kk,ii); %A(data_cas(k,2*c-1),data_cas(i,2*c-1));
        end
        if AA ~= 0 
            sum_f=sum_f-log(AA);
        end
        
%         fid=fopen('A_tp1.txt','r');
%         for iii=1:ii
%             A_tp1_i = fgetl(fid); 
%         end
%         fclose(fid);
        
        tt=find(I_cas(:,c)==0);
        for j=1:length(tt)
            jj=tt(j);
            sum_f=sum_f+A(ii,jj)*(T-cascade_time(i,c));%sum_f+sum(A(data_cas(i,2*c-1),tt))*(T-data_cas(i,2*c));
        end
        
%         clear A_tp1_k;
%         clear A_tp1_i;
    end
end




