%function [trainset testset]=split_trean_test(data, train_intervel, test_intervel)

train_intervel = 1;%day;
test_intervel=3*30*24*60*60;%3 mouths;

load u_movielens.data;
%The full u data set, 100000 ratings by 943 users on 1682 items. Each user
%has rated at least 20 movies.  Users and items are numbered consecutively
%from 1.  The data is randomly ordered. This is a tab separated list of
%user id | item id | rating | timestamp. The time stamps are unix seconds since 1/1/1970 UTC   

data=u_movielens;
[dd,index]=sort(data(:,4),'descend');
data=data(index,:);

t_3m=3*30*24*60*60;
T_max=max(data(:,4));
split_line_3m=T_max-t_3m;%the split line 

%%%obtain the 4 test sets
index=find(data(:,4)>split_line_3m);
test_set_3m=data(index,:);

t_1m=1*30*24*60*60;
index=find(test_set_3m(:,4)<split_line_3m+t_1m);
test_set_1m=test_set_3m(index,:);

t_1w=1*7*24*60*60;
index=find(test_set_3m(:,4)<split_line_3m+t_1w);
test_set_1w=test_set_3m(index,:);

t_1d=1*24*60*60;
index=find(test_set_3m(:,4)<split_line_3m+t_1d);
test_set_1d=test_set_3m(index,:);


%%%obtain the 4 train sets
index=find(data(:,4)<split_line_3m+1);
train_set_allleft=data(index,:);

index=find(train_set_allleft(:,4)>split_line_3m-t_3m);
train_set_3m=train_set_allleft(index,:);

index=find(train_set_allleft(:,4)>split_line_3m-t_1m);
train_set_1m=train_set_allleft(index,:);

index=find(train_set_allleft(:,4)>split_line_3m-t_1w);
train_set_1w=train_set_allleft(index,:);

save Data_bag_movielens_traintest train_set_allleft train_set_3m train_set_1m train_set_1w test_set_3m test_set_1m test_set_1w test_set_1d;


