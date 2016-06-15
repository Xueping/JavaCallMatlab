%function [trainset testset]=split_trean_test(data, train_intervel, test_intervel)
clear;clc;

% test_intervel=3*30;%3 mouths;

load Data_bag_zomato.mat;
% the full Douban data, 100 movies; 249408 reviewers;

 data=zomato;
 [dd,index]=sort(data(:,4),'descend');
 data=data(index,:);
 clear index;
%  index=find(data(:,4)>485);
%  data(index,:)=[];
%  clear index;

t_1y=1*365; %1 year
T_window=max(data(:,4));
split_line_1y=T_window-t_1y;%the split line 

index=find(data(:,4)>split_line_1y);
test_set_1y=data(index,:);
clear index;

t_6m=6*30;
index=find(test_set_1y(:,4)<split_line_1y+t_6m);
test_set_6m=test_set_1y(index,:);
clear index;

t_3m=3*30;
index=find(test_set_1y(:,4)<split_line_1y+t_3m);
test_set_3m=test_set_1y(index,:);
clear index;

t_1m=1*30;
index=find(test_set_1y(:,4)<split_line_1y+t_1m+1);
test_set_1m=test_set_1y(index,:);
clear index;


%%%obtain the 4 train sets
index=find(data(:,4)<split_line_1y+1);
train_set_allleft=data(index,:);
clear index;

index=find(train_set_allleft(:,4)>split_line_1y-3*t_1y);
train_set_3y=train_set_allleft(index,:);
clear index;

index=find(train_set_allleft(:,4)>split_line_1y-2*t_1y);
train_set_2y=train_set_allleft(index,:);
clear index;

index=find(train_set_allleft(:,4)>split_line_1y-t_1y);
train_set_1y=train_set_allleft(index,:);
clear index;

save Data_bag_zomato_traintest train_set_allleft train_set_3y train_set_2y train_set_1y test_set_1y test_set_6m test_set_3m test_set_1m;


