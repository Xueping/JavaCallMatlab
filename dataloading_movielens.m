clear;clc
load u1.base; %u_movielens.data;
%The full u data set, 100000 ratings by 943 users on 1682 items. Each user
%has rated at least 20 movies.  Users and items are numbered consecutively
%from 1.  The data is randomly ordered. This is a tab separated list of
%user id | item id | rating | timestamp. The time stamps are unix seconds since 1/1/1970 UTC   

data=u1;%u_movielens;
[dd,index]=sort(data(:,4),'descend');
data=data(index,:);

dd=data(:,4);
dd=dd';
dd=mapminmax(dd,0,1);
dd=dd';
data(:,4)=dd;

num_node=max(data(:,1));
num_item=max(data(:,2));
T_window=max(data(:,4));


cascade_id=zeros(5000,num_item);
cascade_time=zeros(5000,num_item);
cas_len=[];
for i=1:num_item
    index=find(data(:,2)==i);
    li=length(index);
    
    cas_len=[cas_len li];
    cascade_id(1:li,i)= data(index,1);
    cascade_time(1:li,i)= data(index,4);
end

longest_cas=max(cas_len);
cascade_id(longest_cas+1:end,:)=[];
cascade_time(longest_cas+1:end,:)=[];
cascade_time=cascade_time/T_window;%normalize

I_cas=zeros(num_node,num_item);
for c=1:num_item
    for j=1:cas_len(c)
        I_cas(cascade_id(j,c),c)=1; % 1:nodes appeared in the cascades; 0: nodes did not appear in the cascades, the time is T;
    end
end

I_rate=zeros(num_node,num_item);
data_rate=zeros(num_node,num_item);
[nd,md]=size(data);
for i=1:nd
    I_rate(data(i,1),data(i,2))=1;
    data_rate(data(i,1),data(i,2))=data(i,3);
end

n50=length(find(data_rate==5));
n40=length(find(data_rate==4));
n30=length(find(data_rate==3));
n20=length(find(data_rate==2));
n10=length(find(data_rate==1));

sparsity=(n50+n40+n30+n20+n10)/num_node/num_item;

data_rate=mapminmax(data_rate,0,1);

save Data_bag_u1base cascade_id cascade_time data_rate I_cas I_rate cas_len num_item num_node T_window sparsity; 