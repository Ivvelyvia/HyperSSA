function [Best_score , Best_pos,Convergence_curve ] =HyperSSA(SearchAgents, Max_iter,lb,ub,dim,fobj  )

 ita1 = 0.35;  
 ita2 = 0.15; 

 lb= (lb).*ones( 1,dim );    
 ub= (ub).*ones( 1,dim );    


%Initialization
for i = 1 : SearchAgents
        x( i, : ) = lb + (ub - lb) .* rand( 1, dim );  
    fit( i ) = fobj( x( i, : ) );                       
end
pFit = fit;                      
pX = x;                            
[ Best_score, bestI ] = min( fit );      
Best_pos = x( bestI, : );             
 
 
for t = 1 : Max_iter    
  
  P_percent=(1-(t/Max_iter)^ita1)^(1/ita2);
  
  pNum = round( SearchAgents *  P_percent );

  [, sortIndex] = sort(fit);
    bestX2=pX(sortIndex(2),:);
    bestX3=pX(sortIndex(3),:);

    [pX,Best_score,Best_pos]=DE(pX,Best_score,Best_pos,lb,ub,fobj); 
    
    
    
      
  [ ans, sortIndex ] = sort( pFit );
     
  [fmax,B]=max( pFit );
   worse= x(B,:);  
         
   r2=rand(1);
if(r2<0.8)
    f=fit;
    
    for i = 1 : pNum                                                   
       
       r1=rand(1);

       x( sortIndex( i ), : ) = rand*pX( sortIndex( i ), : )*exp(-rand*(i)/(r1*Max_iter));
        
       x( sortIndex( i ), : ) = newBound(x( sortIndex( i ), : ), lb, ub,Best_pos,bestX2,bestX3);

       fit( sortIndex( i ) ) = fobj( x( sortIndex( i ), : ) );   
    end
  else
  for i = 1 : pNum   
          
  x( sortIndex( i ), : ) = pX( sortIndex( i ), : )+randn(1)*ones(1,dim);
  
  x( sortIndex( i ), : ) = newBound(x( sortIndex( i ), : ), lb, ub,Best_pos,bestX2,bestX3);

  fit( sortIndex( i ) ) = fobj( x( sortIndex( i ), : ) );
     
  end
      
end
 
 
 [ ~, bestII ] = min( fit );      
  bestXX = x( bestII, : );            
   for i = ( pNum + 1 ) : SearchAgents                     
     
         A=floor(rand(1,dim)*2)*2-1;
         
          if( i>(SearchAgents/2))
           x( sortIndex(i ), : )=randn(1)*exp((worse-pX( sortIndex( i ), : ))/(i)^2);
          else
           x( sortIndex( i ), : )=bestXX+(abs(( pX( sortIndex( i ), : )-bestXX)))*(A'*(A*A')^(-1))*ones(1,dim);  
         end  
      
         x( sortIndex( i ), : ) = newBound(x( sortIndex( i ), : ), lb, ub,Best_pos,bestX2,bestX3);

        fit( sortIndex( i ) ) = fobj( x( sortIndex( i ), : ) );
        
   end
  if          fit( sortIndex( i ) )>pFit(i)

              x( sortIndex( i ), : )=pX( sortIndex( i ), : );
  end

  lb=randperm(numel(sortIndex));
  b=sortIndex(lb(1:20));


    for j =  1  : length(b)      
    if( pFit( sortIndex( b(j) ) )>(Best_score) )
       
        x( sortIndex( b(j) ), : )=Best_pos+(randn(1,dim)).*(abs(( pX( sortIndex( b(j) ), : ) -Best_pos)));
       
    else
      
        x( sortIndex( b(j) ), : ) =pX( sortIndex( b(j) ), : )+(2*rand(1)-1)*(abs(pX( sortIndex( b(j) ), : )-worse))/ ( pFit( sortIndex( b(j) ) )-fmax+1e-50);
          end
     
        x( sortIndex( j ), : ) = newBound(x( sortIndex( j ), : ), lb, ub,Best_pos,bestX2,bestX3);
       
       fit( sortIndex( b(j) ) ) = fobj( x( sortIndex( b(j) ), : ) );

         
    end

    
    for i = 1 : SearchAgents 
        if ( fit( i ) < pFit( i ) )
            pFit( i ) = fit( i );
            pX( i, : ) = x( i, : );
        end
        
        if( pFit( i ) < Best_score )
           Best_score= pFit( i );
           Best_pos = pX( i, : );
         
            
        end
    end
  
    Convergence_curve(t)=Best_score;
  
end

end

function s = Bounds( s, Lb, Ub)
  
  temp = s;
  I = temp < Lb;
  temp(I) = Lb(I);
  
   
  J = temp > Ub;
  temp(J) = Ub(J);
  
  s = temp;
end

function [Positions,Leader_score,Leader_pos]=DE(Positions,Leader_score,Leader_pos,lb,ub,fobj)
F=0.7;
CR=0.9; 
DEMax_iter=15;
DEPositions=zeros(size(Positions));
t=0;% Loop counter
while t<DEMax_iter
    for i=1:size(Positions,1)           
            kkk=randperm(size(Positions,1));
            kkk(i==kkk)=[];
            jrand=randi(size(Positions,2));  
            for j=1:size(Positions,2)        
                  if (rand<=CR)||(jrand==j)
                     DEPositions(i,j)=Positions(kkk(1),j)+F*(Positions(kkk(2),j)-Positions(kkk(3),j));
                  else
                   DEPositions(i,j)=Positions(i,j);             
                  end
            end           
                  
             Flag4ub=DEPositions(i,:)>ub; Flag4lb=DEPositions(i,:)<lb;             
             DEPositions(i,:)=(DEPositions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;        
             if fobj(DEPositions(i,:))<fobj(Positions(i,:))
                   Positions(i,:)=DEPositions(i,:);    
                   if fobj(Positions(i,:))<Leader_score
                        Leader_score=fobj(Positions(i,:));
                        Leader_pos=Positions(i,:);
                   end 
             end               
    end     
t=t+1; 

end
end






