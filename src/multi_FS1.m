close all
N = 20;
I = 5.0;
r = 1.8;
iteration = 2;
FS = 5;

pos = randtop(N,N);
FS_idx = randperm(N*N,FS);

n = network(pos,I,r);
d = 200;


while (d>100)
    temp_idx = randperm(FS,2);
    st_idx = temp_idx(1);
    ed_idx = temp_idx(2);
    st = FS_idx(st_idx);
    ed = FS_idx(ed_idx);
    for ite = 1:iteration
        d1 = n.matrixD;
        calculateP(n,st,ed);
        calculateQ(n);
        calculateD(n,st,ed);

        plot(pos(1,:),pos(2,:),'o','MarkerFaceColor','r','MarkerEdgeColor','r');
        hold on;

        plot(pos(1,FS_idx),pos(2,FS_idx),'o','MarkerFaceColor','g','MarkerEdgeColor','g','MarkerSize',12);
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
        pause(0.1)
        if(ite ~= iteration)
           clf
        end
        d2 = n.matrixD;
        d = abs(sum(sum((d2 - d1)/d1)));
        display([num2str(d),' ',num2str(st_idx),' ',num2str(ed_idx)]);
    end
end
title('Simulation Finished');

