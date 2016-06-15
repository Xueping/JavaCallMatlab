% infer the impact network
function sum_f=calculate_f(A,T,data_cas,cas_len,I_cas, num_item)

sum_f=0;
for c=1:num_item
    for i=1:cas_len(c)
        AA=0;
        for k=i+1:cas_len(c)
            sum_f=sum_f+ A(k,i)*(data_cas(i, 2*c)-data_cas(k,2*c));
            AA=AA+A(k,i);
        end
        if AA ~= 0 
            sum_f=sum_f-log(AA);
        end

        tt=find(I_cas(:,c)==1);
        sum_f=sum_f+sum(A(c,tt))*(T-data_cas(i,2*c));
    end
end




