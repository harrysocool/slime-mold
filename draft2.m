close all
N = 20;
I = 2.0;
r = 0.8;
iteration = 5;
FS = 4;

pos = randtop(N,N);
plot(pos(1,:),pos(2,:),'o','MarkerFaceColor','r','MarkerEdgeColor','r');
hold on;

se1 = randperm(N*N,FS);
plot(pos(1,se1),pos(2,se1),'o','MarkerFaceColor','g','MarkerEdgeColor','g','MarkerSize',12);
hold on;

n = network(pos,I,r);

for ii = 1:1
%     st = se1(ii);
    for loop = 1:15
         se2 = randperm(FS,2);
         st = se1(se2(1));
         ed = se1(se2(2));
        for ite = 1:iteration
            calculateP(n,st,ed);
            calculateQ(n);
            calculateD(n);

            for i = 1:N*N
                for j = i+1:N*N
                    if (getD(n,i,j) ~= 0)
                        if (getD(n,i,j) < 0.01)
                            w = 0.01;
                        else
                            w = 10*getD(n,i,j);
                        end
                        plot([pos(1,i),pos(1,j)],[pos(2,i),pos(2,j)],'Color','b','LineWidth',w);
                        hold on;
                    end
                end
            end
            pause(0.1)
            refresh
        end
    end
end
title('Simulation Finished');
%%
