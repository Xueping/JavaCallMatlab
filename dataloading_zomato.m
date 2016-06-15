clear; clc

% load Data_zomato.txt
% user=Data_zomato(:,1);
% rest=Data_zomato(:,2);
% rate=Data_zomato(:,3);
% save data_zomato user rest rate

load data_zomato.mat

for i=1:length(rate)
    if rate(i)>10
        rate(i)=0;
    else if rate(i)>5
            rate(i)=5;
        else if rate(i)>4.5
                rate(i)=4.5;
            else if rate(i) >4
                    rate(i)=4;
                else if rate(i)>3.5
                        rate(i)=3.5;
                        else if rate(i)>3
                            rate(i)=3;
                            else if rate(i)>2.5
                                    rate(i)=2.5;
                                else if rate(i)>2
                                        rate(i)=2;
                                    else if rate(i)>1.5
                                            rate(i)=1.5;
                                        else if rate(i)>1
                                                rate(i)=1;
                                            else if rate(i)>0.5
                                                    rate(i)=0.5;
                                                else 
                                                    rate(i)=0;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                    end
                end
            end
        end
    end
end

n5=length(find(rate==5));
n45=length(find(rate==4.5));
n4=length(find(rate==4));
n35=length(find(rate==3.5));
n3=length(find(rate==3));
n25=length(find(rate==2.5));
n2=length(find(rate==2));
n15=length(find(rate==1.5));
n1=length(find(rate==1));
n_5=length(find(rate==0.5));
n0=length(find(rate==0));

dictionary=[];
for i=1:length(user)
    index=find(dictionary==user(i));
    if length(index)<1
        %fprintf(fid3,'%s\n',num2str(user));
        dictionary=[dictionary;user(i)];
        user1(i,1)=length(dictionary);
    else
        user1(i,1)=index;
    end
%     if rest(i)>1000
%         continue;
%         end
end

time=[];
time_c=[];

filename_read='Data_zomato.txt';
f_ts=fopen(filename_read,'r');
while ~feof(f_ts) 
    ts = fgetl(f_ts);
    l_ts=length(ts);
    time1=ts(l_ts-19+1:l_ts);
    time_c=[time_c;time1];
    time1=datenum(time1);
    time=[time;time1];
end
fclose(f_ts);

zomato=[user1 rest rate time];
tt=min(zomato(:,4));
zomato(:,4)=zomato(:,4)-tt;

save Data_bag_zomato zomato dictionary
    
 






% filename_read='Data_zomato.txt';
% %filename_cas='movielist100.txt';
% %file_rate='resultRating_List100.txt';%'resultRating_List.txt';
% f_ts=fopen(filename_read,'r');
% 
% fid=fopen('Data_zomato_new1_good.txt','wt');
% fid2=fopen('Data_zomato_new1_skip.txt','wt');
% fid3=fopen('dict_zomato.txt','wt');
% 
% 
% data=[];
% dictionary=[];
% user_id=0;
% user_sum=[];
% left=[];
% skip=0;
% count=0;
% while ~feof(f_ts) 
%     count=count+1;
%     ts = fgetl(f_ts);
%     user=ts(1:8);
%     user=str2num(user);
%     if length(user)~=1
%         fprintf(fid2,'%s\n',ts);
%         skip=skip+1;
%         continue;
%     end
%     
%     if user<10^7
%         fprintf(fid2,'%s\n',ts);
%         skip=skip+1;
%         continue;
%     end
%     
%     index=find(dictionary==user);
%     if length(index)<1
%         fprintf(fid3,'%s\n',num2str(user));
%         dictionary=[dictionary;user];
%         user_id=length(dictionary);
%     else
%         user_id=index;
%     end
%     
%     user_sum=[user_sum;user_id];
%     
%  
%     fprintf(fid,'%s\n',ts);
% %     ts(1:8)=[];
% %     left=[left;ts];
%     
%     
% %     restarant=ts(9:10);
% %     restarant=str2num(restarant);
% %     
% %     rate=ts(12:14);
% %     rate=str2num(rate);
% %     
% %     time=ts(15:end);
% %     time=datenum(time);
% % 
% %     data=[data;[userID restarant rate time]];
% end
% 
% 
% 
% fclose(f_ts);
% fclose(fid);
% fclose(fid2);
% fclose(fid3);
