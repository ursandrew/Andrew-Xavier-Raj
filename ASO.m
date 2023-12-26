
function [X_Best,Fit_XBest,Functon_Best,Atom_Pop]=ASO(Atom_Num,Max_Iteration,Low,Up,Dim,fobj)

alpha=7;
beta=0.1;
global Positions
% Dim: Dimension of search space.
% Atom_Pop: Population (position) of atoms.
% Atom_V:  Velocity of atoms.
% Acc: Acceleration of atoms.
% M: Mass of atoms. 
% Atom_Num: Number of atom population.
% Fitness: Fitness of atoms.
% Max_Iteration: Maximum of iterations.
% X_Best: Best solution (position) found so far. 
% Fit_XBest: Best result corresponding to X_Best. 
% Functon_Best: The fitness over iterations. 
% Low: The low bound of search space.
% Up: The up bound of search space.
% alpha: Depth weight.
% beta: Multiplier weight

   Iteration=1;
 
   % Randomly initialize positions and velocities of atoms.
     if size(Up,2)==1
         Atom_Pop=rand(Atom_Num,Dim).*(Up-Low)+Low;
         Atom_V=rand(Atom_Num,Dim).*(Up-Low)+Low;
     end
   
     if size(Up,2)>1
        for i=1:Dim
           Atom_Pop(:,i)=rand(Atom_Num,1).*(Up(i)-Low(i))+Low(i);
           Atom_V(:,i)=rand(Atom_Num,1).*(Up(i)-Low(i))+Low(i);
        end
     end

 % Compute function fitness of atoms.
     for i=1:Atom_Num
       Fitness(i)= fobj(Atom_Pop(i,:));
     end
       Functon_Best=zeros(Max_Iteration,1);
       [Max_Fitness,Index]=min(Fitness);
       Functon_Best(1)=Fitness(Index);
       X_Best=Atom_Pop(Index,:);
     
 % Calculate acceleration.
 Atom_Acc=Acceleration(Atom_Pop,Fitness,Iteration,Max_Iteration,Dim,Atom_Num,X_Best,alpha,beta);


 % Iteration
 for Iteration=2:Max_Iteration 
           Functon_Best(Iteration)=Functon_Best(Iteration-1);
           Atom_V=rand(Atom_Num,Dim).*Atom_V+Atom_Acc;
           Atom_Pop=Atom_Pop+Atom_V;     
    
    
         for i=1:Atom_Num
       % Relocate atom out of range.  
           TU= Atom_Pop(i,:)>Up;
           TL= Atom_Pop(i,:)<Low;
           Atom_Pop(i,:)=(Atom_Pop(i,:).*(~(TU+TL)))+((rand(1,Dim).*(Up-Low)+Low).*(TU+TL));
           %Evaluate atom. 
           Fitness(i)= fobj(Atom_Pop(i,:));
         end
        [Max_Fitness,Index]=min(Fitness);      
     
        if Max_Fitness<Functon_Best(Iteration)
             Functon_Best(Iteration)=Max_Fitness;
             X_Best=Atom_Pop(Index,:);
          else
            r=fix(rand*Atom_Num)+1;
             Atom_Pop(r,:)=X_Best;
        end
     
      % Calculate acceleration.
       Atom_Acc=Acceleration(Atom_Pop,Fitness,Iteration,Max_Iteration,Dim,Atom_Num,X_Best,alpha,beta);
 end

Fit_XBest=Functon_Best(Iteration); 

