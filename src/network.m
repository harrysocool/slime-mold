classdef network < handle
    properties(SetAccess = 'private')
        V
        pos
        matrixL
        matrixD
        matrixQ
        matrixP
        P
        I
        r
    end
    
    methods
        function obj = network(pos,I,r)
            obj.V = size(pos,2);
            obj.pos = pos;
            obj.matrixL = 10*dist(pos);
            
            obj.matrixL(obj.matrixL > 11) = Inf;
            obj.matrixL(obj.matrixL == 0) = Inf;
            
            obj.matrixQ = zeros(obj.V,obj.V);
            obj.matrixD = ones(obj.V,obj.V);
            obj.I = I;
            obj.r = r;
        end
    end
    
    methods       
        function l = getL(obj,i,j)
            l = obj.matrixL(i,j);
        end
        
        function d = getD(obj,i,j)
            d = obj.matrixD(i,j);
        end  
        
        function calculateP(obj,st,ed)
            temp = zeros(obj.V,obj.V);
            for i = 1:obj.V
                for j = 1:obj.V
                    if (i ~= j)
                        temp(i,i) = temp(i,i) + getD(obj,i,j)/getL(obj,i,j);
                        temp(i,j) = -1*getD(obj,i,j)/getL(obj,i,j);
                    end 
                end
            end
            b = zeros(obj.V,1);
            b(st) = obj.I;
            b(ed) = -1*obj.I;
            temp(:,ed) = [];
            a = temp\b;
            warning('off')
            if(ed ~= 1 && ed ~= obj.V)
                a = [a(1:ed-1);0;a(ed:obj.V-1)];
            elseif(ed == 1)
                a = [0;a];
            elseif(ed == obj.V)
                a = [a;0];
            end
            obj.P = a; 
            diffP(obj);
        end
        
        function diffP(obj)
            B = repmat(obj.P',obj.V,1);
            obj.matrixP = B - B';            
        end        
        
        function calculateQ(obj)
            obj.matrixQ = obj.matrixD./obj.matrixL.*obj.matrixP;
        end
        
        function calculateD(obj,st,ed)
            obj.matrixD = 0.5*abs(obj.matrixQ).^obj.r./(1+abs(obj.matrixQ).^obj.r) + 0.5*obj.matrixD;
%            obj.matrixD = 0.5*((obj.matrixQ.*obj.matrixP)./(obj.matrixL.*obj.matrixP(st,ed)) + obj.matrixD);
        end
    end
end
