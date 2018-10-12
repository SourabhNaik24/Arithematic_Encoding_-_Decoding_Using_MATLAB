% DATE: 18/09/2018
% ARITHMETIC CODING
% EXPERIMENT NUMBER 4

clc;
clear all;
% Encoding
format long;
x='BILL GATES';
display(x);
len=length(x);
display(len);
u=unique(x);
display(u);
lenChar=length(u);
display(lenChar);
%general lookup table
z=zeros(1,lenChar);
p=zeros(1,lenChar);
for i=1:lenChar
    z(i)=length(findstr(x,u(i)));
    p(i)=z(i)/len;
end
display(z);
display(p);
cpr=cumsum(p);
newcpr=[0 cpr];
display(cpr);
display(newcpr);
for i=1:lenChar
    interval(i,1)=newcpr(i);
    interval(i,2)=cpr(i);
end
display(interval);
% Encoder Table
low=0;
high=1;
for i=1:len
    for j=1:lenChar
        if x(i)==u(j);
            pos=j;
            j=j+1; 
            display(pos);
            range=high-low;
            high=low+(range.*interval(pos,2));
            low=low+(range.*interval(pos,1))
            i=i+1;
            break
        end
    end
end
tag=low

% Decoding
for i=1:len
    for j=1:lenChar
        str='';
        if tag>interval(j,1) && tag<interval(j,2)
            pos=j;
            j=j+1;
            decodedstr=u(pos);
            str=strcat(str,decodedstr);
            break
            tag=(tag-interval(pos,1))/p(j)
        end
    end
end
disp(str)
tag=(tag-interval(pos,1))/p(j)


