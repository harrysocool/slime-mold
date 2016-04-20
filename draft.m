clear all;
V = 4;
L = [Inf,4,12,Inf;...
     4,Inf,4,15;...
     12,4,Inf,5;...
     Inf,15,5,Inf];
% P = zeros(1,4);
D = ones(4,4);
Q = zeros(4,4);
count = 1;
I = 2;
r = 1.8;

for loop = 1:6
    %% Calculate P
    temp = zeros(V,V);
    for i = 1:V
        for j = 1:V
            if (i ~= j)
                temp(i,i) = temp(i,i) + D(i,j)/L(i,j);
                temp(i,j) = -1*D(i,j)/L(i,j);
            end 
        end
    end

    b = [I;0;0;-1*I];
    a = temp(:,1:3)\b;
    P = [a;0];  
 
    %% Calculate Q
    for i = 1:V
        for j = 1:V
            if (i ~= j)
                Q(i,j) = D(i,j)/L(i,j)*(P(i) - P(j));
            end 
        end
    end

    %% Calculate next D
    for i = 1:V
        for j = 1:V
            if (i ~= j)
                slope = abs(Q(i,j))^r/(1+abs(Q(i,j))^r) - D(i,j);
                D(i,j) = D(i,j) + slope;
%                 D(i,j) = 0.5*((Q(i,j)*(P(i) - P(j)))/(L(i,j)*(P(1) - P(4))) + D(i,j));
%                 D(i,j) = abs(Q(i,j))^r/(1+abs(Q(i,j))^r) + exp(-D(i,j));
            end 
        end
    end

    data(count,:) = [D(1,2),D(2,3),D(3,4),D(1,3),D(2,4)];
    count = count + 1;
end
%%
plot(data);

%%
% pos = randtop(2,2);
% plotsom(pos)