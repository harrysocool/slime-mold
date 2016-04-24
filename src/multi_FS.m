close all
N = 20;
I = 5.0;
r = 2.2;
iteration = 2;
FS = 10;

pos = randtop(N,N);
FS_idx = randperm(N*N,FS);

n = network(pos,I,r);
d = 1;


while (d>0.01)
    for st_idx = 1:FS
      st = FS_idx(st_idx);
      temp_idx = FS_idx(FS_idx~=st);
      for ed_idx = 1:FS/2
        ed = temp_idx(ed_idx);
        for ite = 1:iteration
            d1 = n.matrixD;
            calculateP(n,st,ed);
            calculateQ(n);
            calculateD(n,st,ed);

            plot(pos(1,:),pos(2,:),'o','MarkerFaceColor','r','MarkerEdgeColor','r');
            hold on;

            plot(pos(1,FS_idx),pos(2,FS_idx),'o','MarkerFaceColor','g','MarkerEdgeColor','g','MarkerSize',12);
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
            d2 = n.matrixD;
            d = abs(sum(sum(d2 - d1)));
            display([num2str(d),' ',num2str(st_idx),' ',num2str(ed_idx)]);
        end
      end
    end
end
title('Simulation Finished');

