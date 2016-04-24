close all
N = 20;
I = 2.5;
r = 1.8;
st = 1;
ed = N*N;
d = 1;

pos = randtop(N,N);
n = network(pos,I,r);

while (1)
    d1 = n.matrixD;
    calculateP(n,st,ed);
    calculateQ(n);
    calculateD(n,st,ed);
    
    plot(pos(1,:),pos(2,:),'o','MarkerFaceColor','r','MarkerEdgeColor','r');
    hold on;

    plot(pos(1,[st,ed]),pos(2,[st,ed]),'o','MarkerFaceColor','g','MarkerEdgeColor','g','MarkerSize',12);
    hold on;

    line_x = zeros(0);
    line_y = zeros(0);
    w = cell(0);
    for i = 1:N*N
        for j = i+1:N*N
            if (getL(n,i,j) <= 15)
                if (getD(n,i,j) < 0.01)
                    w(size(w,1)+1,1) = {0.01};
                else
                    w(size(w,1)+1,1) = {10*getD(n,i,j)};
                end
                line_x(:,size(line_x,2)+1) = [pos(1,i);pos(1,j)];
                line_y(:,size(line_y,2)+1) = [pos(2,i);pos(2,j)];
            end
        end
    end
    h = plot(line_x,line_y);
    hline = findobj(h, 'type', 'line');
    for z = 1:length(hline)
        set(hline(z),'Color','b','LineWidth',w{z});
    end
    
    if(d<0.01)
        break
    end
    pause(0.1)
    clf 
    
    d2 = n.matrixD;
    d = abs(sum(sum((d2 - d1))));
    display(num2str(d));
end

title('Simulation Finished');
