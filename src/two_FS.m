close all
N = 15;
I = 2.5;
r = 1.8;
iteration = 40;
st = 1;
ed = N*N;

pos = randtop(N,N);
n = network(pos,I,r);

for ite = 1:iteration
    d1 = n.matrixD;
    calculateP(n,st,ed);
    calculateQ(n);
    calculateD(n,st,ed);
    
    h = figure(1);
    plot(pos(1,:),pos(2,:),'o','MarkerFaceColor','r','MarkerEdgeColor','r');
    hold on;

    plot(pos(1,[st,ed]),pos(2,[st,ed]),'o','MarkerFaceColor','g','MarkerEdgeColor','g','MarkerSize',12);
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
    pause(0.01)
    if(ite ~= iteration)
       clf 
    end
    d2 = n.matrixD;
    d = sum(sum(d2 - d1));
    display(d);
end

title('Simulation Finished');
