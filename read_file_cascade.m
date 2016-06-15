function [I_cas, Data]=read_file_cascade(filename,num_node)
%kind is either 1 for cascade data or 0 for rating data
Data=[];
f_ts = fopen(filename, 'r');
I_cas=ones(num_node,1);
while ~feof(f_ts) 
    ts = fgetl(f_ts);
    ts=str2num(ts);
    Data=[Data;ts];
    I_cas(ts(1,1),1)=0;
end