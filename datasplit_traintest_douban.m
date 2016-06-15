%function [trainset testset]=split_trean_test(data, train_intervel, test_intervel)
clear;clc;

% test_intervel=3*30;%3 mouths;

load douban100.txt;
% the full Douban data, 100 movies; 249408 reviewers;

 data=douban100;
 [dd,index]=sort(data(:,4),'descend');
 data=data(index,:);
 clear index;
 index=find(data(:,4)>485);
 data(index,:)=[];
 clear index;

t_3m=3*30; %days
T_window=485;
split_line_3m=T_window-t_3m;%the split line 

index=find(data(:,4)>split_line_3m);
test_set_3m=data(index,:);
clear index;

t_1m=1*30;
index=find(test_set_3m(:,4)<split_line_3m+t_1m);
test_set_1m=test_set_3m(index,:);
clear index;

t_3w=3*7;
index=find(test_set_3m(:,4)<split_line_3m+t_3w);
test_set_3w=test_set_3m(index,:);
clear index;

t_2w=2*7;
index=find(test_set_3m(:,4)<split_line_3m+t_2w);
test_set_2w=test_set_3m(index,:);
clear index;

t_1w=1*7;
index=find(test_set_3m(:,4)<split_line_3m+t_1w);
test_set_1w=test_set_3m(index,:);
clear index;

t_1d=1;
index=find(test_set_3m(:,4)<split_line_3m+t_1d+1);
test_set_1d=test_set_3m(index,:);
clear index;


%%%obtain the 4 train sets
index=find(data(:,4)<split_line_3m+1);
train_set_allleft=data(index,:);
clear index;

index=find(train_set_allleft(:,4)>split_line_3m-t_3m);
train_set_3m=train_set_allleft(index,:);
clear index;

index=find(train_set_allleft(:,4)>split_line_3m-t_1m);
train_set_1m=train_set_allleft(index,:);
clear index;

index=find(train_set_allleft(:,4)>split_line_3m-t_1w);
train_set_1w=train_set_allleft(index,:);
clear index;

index=find(train_set_allleft(:,4)>split_line_3m-t_2w);
train_set_2w=train_set_allleft(index,:);
clear index;

index=find(train_set_allleft(:,4)>split_line_3m-t_3w);
train_set_3w=train_set_allleft(index,:);
clear index;

t_3d=3;
index=find(train_set_allleft(:,4)>split_line_3m-t_3d);
train_set_3d=train_set_allleft(index,:);
clear index;





save Data_bag_douban_traintest train_set_allleft train_set_3m train_set_1m train_set_3w train_set_2w train_set_1w train_set_3d test_set_3m test_set_1m test_set_3w test_set_2w test_set_1w test_set_1d;


