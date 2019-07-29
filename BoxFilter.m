function [Dxx,Dyy,Dxy] = BoxFilter(n)
    %Dxx
    x = 2*floor(n/6)+1;
    y = 4*floor(n/6)+1;
    Dxx=integralKernel([1,1,x,y; x+1,1,x,y; 2*x+1,1,x,y], [1, -2, 1]);
    %Dxx.Coefficients
    
    %Dyy
    x = 4*floor(n/6)+1;
    y = 2*floor(n/6)+1;
    Dyy=integralKernel([1,1,x,y; 1,y+1,x,y; 1,2*y+1,x,y], [1, -2, 1]);
    %Dyy.Coefficients
    
    %Dxy
    a = 2*floor(n/6)+1;
    Dxy=integralKernel([1,1,a,a; a+2,1,a,a; 1,a+2,a,a; a+2,a+2,a,a], [1, -1, -1, 1]);
    %Dxy.Coefficients
end