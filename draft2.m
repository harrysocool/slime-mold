close all
N = 10;
I = 2;
r = 1.8;
iteration = 2;

pos = randtop(N,N);
plot(pos(1,:),pos(2,:),'o','MarkerFaceColor','r','MarkerEdgeColor','r');
hold on;
se1 = randperm(N*N,5);
plot(pos(1,se1),pos(2,se1),'o','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerSize',12);
hold on;
n = network(pos,I,r);
for loop = 1:20
    se2 = randperm(5,2);
    st = se1(se2(1));
    ed = se1(se2(2));
    for ite = 1:iteration
        calculateP(n,st,ed);
        calculateQ(n);
        calculateD(n);

        for i = 1:N*N
            for j = i+1:N*N
                if (getL(n,i,j) < 10)
                    if (getD(n,i,j) < 0.001)
                        w = 0.01;
                    else
                        w = 10*getD(n,i,j);
                    end
                    plot([pos(1,i),pos(1,j)],[pos(2,i),pos(2,j)],'Color','g','LineWidth',w);
                    hold on;
                end
            end
        end
        pause(0.01)
        refresh
    end
end
display('Simulation Finished')
%%
