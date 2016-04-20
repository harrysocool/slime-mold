N = 10;
I = 2;
r = 1.8;
iteration = 10;

pos = randtop(N,N);
n = network(pos,I,r);

for ite = 1:iteration
    calculateP(n);
    calculateQ(n);
    calculateD(n);
    
%     for i = 1:(NodeAmount-1)
%         for j = (i+1):NodeAmount
%             if isinf(EdgeCost(i,j)) == 0
%                 plot([Sxy(2,i),Sxy(2,j)],[Sxy(3,i),Sxy(3,j)]);
%                 hold on;
%             end
%         end
%     end
    plot(pos(1,:),pos(2,:),'o','MarkerFaceColor','r','MarkerEdgeColor','r');
    hold on;
    for i = 1:N*N
        for j = i+1:N*N
            if (getL(n,i,j) < 10)
                if (getD(n,i,j) < 0.01)
                    w = 0.1;
                else
                    w = 10*getD(n,i,j);
                end
                plot([pos(1,i),pos(1,j)],[pos(2,i),pos(2,j)],'Color','g','LineWidth',w);
                hold on;
            end
        end
    end
    pause(0.2)
    refresh
end

%%
