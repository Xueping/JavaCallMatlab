clear; clc

filename_cas='movielist100.txt';
file_rate='resultRating_List100.txt';%'resultRating_List.txt';
f_ts=fopen(filename_cas,'r');

% num_node=30000;
num_item=100;
longest_cas=30000;



% data_cas=zeros(longest_cas,2*num_item);
cas_len=[];
count=0;
cascade_id=zeros(longest_cas,num_item);
cascade_time=zeros(longest_cas,num_item);
while ~feof(f_ts) 
    ts = fgetl(f_ts);
    count=count+1;
    cascade=load(ts);
     [cc,index]=sort(cascade(:,2),'descend');
     cascade=cascade(index,:);
    
    [nt,mt]=size(cascade);
    
    cascade_id(1:nt,count)=cascade(:,1);
    cascade_time(1:nt,count)=cascade(:,2);
    
%     data_cas(1:nt,2*count-1:2*count)=cascade;
    cas_len=[cas_len;nt];
    cascade=[];
end

% num_node=max(max(data_cas));
num_item=count;

num_node=max(max(cascade_id));
T_window=max(max(cascade_time));

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

% data_rate=ones(num_node,num_item);
% I_rate=data_rate;


data_r=load(file_rate);
I_rate=zeros(num_node,num_item);
data_rate=zeros(num_node,num_item);
[nr,mr]=size(data_r);
for i=1:nr
    I_rate(data_r(i,1),data_r(i,2))=1;
    data_rate(data_r(i,1),data_r(i,2))=data_r(i,3);
end

n50=length(find(data_rate==50));
n40=length(find(data_rate==40));
n30=length(find(data_rate==30));
n20=length(find(data_rate==20));
n10=length(find(data_rate==10));
% n0=length(find(data_rate==0));

sparsity=(n50+n40+n30+n20+n10)/num_node/num_item;

data_rate=mapminmax(data_rate,0,1);

save Data_bag_Douban100 cascade_id cascade_time data_rate I_cas I_rate cas_len num_item num_node T_window sparsity; 
% data_cas : all the cascade data
% save data_rate; % tha matrix R
% save I_cas; % 1: the related node time is T;
% save I_rate; % the matrix I in the paper
% save cas_len; % the length of every cascade data