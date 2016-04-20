classdef network < handle
    properties(SetAccess = 'private')
        V
        pos
        matrixL
        matrixD
        matrixQ
        P
        I
        r
    end
    
    methods
        function obj = network(pos,I,r)
            obj.V = size(pos,2);
            obj.pos = pos;
            obj.matrixL = 10*dist(pos);
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

        function q = getQ(obj,i,j)
            q = obj.matrixQ(i,j);
        end
        
        
        function calculateP(obj)
            temp = zeros(obj.V,obj.V);
            for i = 1:obj.V
                for j = 1:obj.V
                    if (i ~= j)
                        temp(i,i) = temp(i,i) + getD(obj,i,j)/getL(obj,i,j);
                        temp(i,j) = -1*getD(obj,i,j)/getL(obj,i,j);
                    end 
                end
            end
            z = zeros(obj.V-2,1);
            b = [obj.I;z;-1*obj.I];
            a = temp(:,1:obj.V-1)\b;
            obj.P = [a;0]; 
        end
        
        function calculateQ(obj)
            for i = 1:obj.V
                for j = 1:obj.V
                    if (i ~= j)
                        obj.matrixQ(i,j) = getD(obj,i,j)/getL(obj,i,j)*(obj.P(i) - obj.P(j));
                    end 
                end
            end 
        end
        
        function calculateD(obj)
            for i = 1:obj.V
                for j = 1:obj.V
                    if (i ~= j)
                        slope = abs(getQ(obj,i,j))^obj.r/(1+abs(getQ(obj,i,j))^obj.r) - getD(obj,i,j);
                        obj.matrixD(i,j) = getD(obj,i,j) + slope;
        %                 D(i,j) = 0.5*((Q(i,j)*(P(i) - P(j)))/(L(i,j)*(P(1) - P(4))) + D(i,j));
                    end 
                end
            end 
        end
    end
end
