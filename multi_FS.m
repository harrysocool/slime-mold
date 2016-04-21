close all
N = 14;
I = 4.5;
r = 1.4;
iteration = 2;
FS = 5;

pos = randtop(N,N);
se1 = randperm(N*N,FS);

n = network(pos,I,r);


for loop = 1:20
     se2 = randperm(FS,2);
     st = se1(se2(1));
     ed = se1(se2(2));
    for ite = 1:iteration
        calculateP(n,st,ed);
        calculateQ(n);
        calculateD(n,st,ed);

        plot(pos(1,:),pos(2,:),'o','MarkerFaceColor','r','MarkerEdgeColor','r');
        hold on;

        plot(pos(1,se1),pos(2,se1),'o','MarkerFaceColor','g','MarkerEdgeColor','g','MarkerSize',12);
        hold on;

        for i = 1:N*N
            for j = i+1:N*N
                if (getL(n,i,j) <= 15)
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
        if(ite ~= iteration)
           clf
        end
    end
end
title('Simulation Finished');

