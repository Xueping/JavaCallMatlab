function Data=read_file_rate(filename)
%kind is either 1 for cascade data or 0 for rating data
Data=[];
f_ts = fopen(filename, 'r');

while ~feof(f_ts) 
    ts = fgetl(f_ts);
    ts=str2num(ts);
    Data=[Data;ts];
end