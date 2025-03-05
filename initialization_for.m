
function [X]=initialization_for(N,dim,up,down)

if size(up,2)==1
    X=rand(N,dim).*(up-down)+down;
end
if size(up,2)>1
    for i = 1:N
        for j=1:dim
             high=up(j);
             low=down(j);
             X(i,j)=rand*(high-low)+low;
        end
    end
end