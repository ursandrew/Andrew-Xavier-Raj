

function [lb,ub,dim,fobj] = Get_Functions_details(F)


switch F
    case 'F1'
        fobj = @F1;
        lb=[0  -1  -1     0    -1     0            0   -1   -1     0    -1    0            0  -1   -1    0    -1   0 ];
        ub=[1   1   1     1     1     1            1    1    1     1     1    1            1   1    1    1     1    1];
        dim=18;
        
    case 'F2'
        fobj = @F2;
        lb=-10;
        ub=10;
        dim=10;
        
   
        
    case 'F3'
        fobj = @F3;
        lb=-30;
        ub=30;
        dim=10;
        
   
        
    case 'F4'
        fobj = @F4;
        lb=-5.12;
        ub=5.12;
        dim=10;
        
        
    case 'F5'
        fobj = @F5;
        lb=-600;
        ub=600;
        dim=10;
        
        
    case 'F6'
        fobj = @F6;
        lb=-5;
        ub=5;
        dim=4;
                 
end

end

% F1

function o = F1(x)
k1=x(1,1)
kp=x(1,2)
kd=x(1,3)
mu=x(1,4)
ki=x(1,5)
lam=x(1,6)
k2=x(1,7)
kp1=x(1,8)
kd1=x(1,9)
mu1=x(1,10)
ki1=x(1,11)
lam1=x(1,12)
k3=x(1,13)
kp2=x(1,14)
kd2=x(1,15)
mu2=x(1,16)
ki2=x(1,17)
lam2=x(1,18)
opt=simset('solver','VariableStepAuto','SrcWorkspace','Current')
[tout,xout,yout]=sim('JOURNAL_3_DEREGULATED',[0 50],opt)
o=mean(e)
k1
kp
kd
mu
ki
lam
k2
kp1
kd1
mu1
ki1
lam1
k3
kp2
kd2
mu2
ki2
lam2
end

% F2

function o = F2(x)
o=sum(x.^2);
end


% F5

function o = F3(x)
dim=size(x,2);
o=sum(100*(x(2:dim)-(x(1:dim-1).^2)).^2+(x(1:dim-1)-1).^2);
end


% F9

function o = F4(x)
dim=size(x,2);
o=sum(x.^2-10*cos(2*pi.*x))+10*dim;
end


% F11

function o = F5(x)
dim=size(x,2);
o=sum(x.^2)/4000-prod(cos(x./sqrt([1:dim])))+1;
end

% F15
function o = F6(x)
aK=[.1957 .1947 .1735 .16 .0844 .0627 .0456 .0342 .0323 .0235 .0246];
bK=[.25 .5 1 2 4 6 8 10 12 14 16];bK=1./bK;
o=sum((aK-((x(1).*(bK.^2+x(2).*bK))./(bK.^2+x(3).*bK+x(4)))).^2);
end

