clc;
clear all;
close all;
file1 = fopen('Result.txt','a+');
max_trial =10;
          
for load_file = 1:2
    %% initializing variables
    no_part = 5.;
    %% to load file
    switch load_file

       case 1
            file = 'ecoli-0-1_vs_5';
            test_start =121;
            cvs1=10;
            vs1=100;
            eps1=0.1;
            mus=32;
              

        otherwise
            continue;
    end
% %parameters 
%         cvs1=[10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2,10^3,10^4,10^5];
%        mus=[2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5];

         
         
%Data file call from folder   
filename = strcat('./newd/',file,'.txt');
    A = load(filename);
    [m,n] = size(A);
%define the class level +1 or -1      
    for i=1:m
        if A(i,n)==0
            A(i,n)=-1;
        end
    end
        test_start=m/2;
    test = A(test_start:m,:);
    train = A(1:test_start-1,:);

    [no_input,no_col] = size(train);
  
    x1 = train(:,1:no_col-1);
    y1 = train(:,no_col);
	    
    [no_test,no_col] = size(test);
    xtest0 = test(:,1:no_col-1);
    ytest0 = test(:,no_col);

%Combining all the column in one variable
    A=[x1 y1];    %training data
    A_test=[xtest0,ytest0];    %testing data
    
 %%%%%%%%%%%%%%Universum generation    
     [no_input,no_col]=size(A);
  obs = A(:,no_col);   
    C=A;
    A = [];
 B = [];
 u=ceil(0.2*(test_start-1));
for i = 1:no_input
    if(obs(i) == 1)
        A = [A;C(i,1:no_col-1)];
    else
        B = [B;C(i,1:no_col-1)];
    end;
end;

sb1=size(A,1);
sb=size(B,1);
ptb1=sb1/u;
ptb=sb/u;
Au=A(1:ptb1:sb1,:);
Bu=B(1:ptb:sb,:);
di=size(Au,1)-size(Bu,1);
if(di>0)
Bu=[Bu ;Bu(1:abs(di),:)];
elseif(di<0)
Au=[Au ;Au(1:abs(di),:)];
end   
 U=(Au+Bu)/2;   
   A=C;
    
       
    
 %% initializing crossvalidation variables

    [lengthA,n] = size(A);
    min_err = -10^-10.;


no_input=no_test;
i=1;
   for C1 = 1:length(cvs1)
            c = cvs1(C1)
%              for C0 = 1:length(cvs0)
%             c0 = cvs0(C0)
		for vi = 1:length(vs1)
            v = vs1(vi)
           for mv = 1:length(mus)
                    mu = mus(mv)
                     for e1 = 1:length(eps1)
						e = eps1(e1)
%                   
                  [accuracy,yt,yp,time] = ULSTPMSVM(A,A_test,U,c,v,e,mu);
%               
			min_c1 = c;
			min_v=v;
			min_e=e;
			min_mu=mu;
           fprintf(file1,'Stat %s\t%g\t%g\t%g\t%g\t%g\t%g\t%g\t%g\tu=%g\n',file,size(A,1),size(A_test,1),accuracy,min_c1,min_v,min_e,min_mu,time,u);    
					end
 
           end
        end
    end
  end
       
 