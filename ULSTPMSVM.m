function [accuracy,ytest0,predicted_class,train_Time]=NonL_ULSTPMSVM(A,A_test,U,c,v,e,mew)
mew1=1/(2*mew*mew);
[m,n]=size(A);[m_test,n_test]=size(A_test);
x0=A(:,1:n-1);y0=A(:,n);
xtest0=A_test(:,1:n_test-1);ytest0=A_test(:,n_test);
%----------------Training-------------
A=x0(find(y0(:,1)>0),:);B=x0(find(y0(:,1)<=0),:);
C=[A;B];
m1=size(A,1);m2=size(B,1);m3=size(U,1);
m4=size(C,1);
e1=ones(m1,1);e2=ones(m2,1);eu=ones(m3,1);


K = zeros (m1,m4);

for i =1: m1
    for j =1: m4
        nom = norm( A(i ,:) - C(j ,:) );
        K(i,j)=exp(-mew1*nom*nom);

    end
end

H=[K e1];


K = zeros (m2,m4);
for i =1: m2
    for j =1: m4
        nom = norm( B(i ,:) - C(j ,:) );
        K(i,j)=exp(-mew1*nom*nom);
    end
end

G=[K e2];



K = zeros (m3,m4);
for i =1: m3
    for j =1: m4
        nom = norm( U(i ,:) - C(j ,:) );
        K(i,j)=exp(-mew1*nom*nom);
    end
end
O=[K eu];

tic
HTH=H'*H;
GTG=G'*G;
OTO=O'*O;

I=speye(size(HTH,1));
temp=(1-e)*c*(O'*eu);
u1=-(c*HTH+c*OTO+I)\(v*(G'*e2)+temp);
u2=(c*GTG+c*OTO+I)\(v*(H'*e1)+temp);

train_Time=toc;
%---------------Testing---------------
no_test=size(xtest0,1);
K = zeros(no_test,m4);
for i =1: no_test
    for j =1: m4
        nom = norm( xtest0(i ,:) - C(j ,:) );
        K(i,j )=exp(-mew1*nom*nom);
    end
end
K=[K ones(no_test,1)];
preY1=K*u1/norm(u1(1:size(u1,1)-1,:));
preY2=K*u2/norm(u2(1:size(u2,1)-1,:));
predicted_class=[];
for i=1:no_test
    if abs(preY1(i))<abs(preY2(i))
        predicted_class=[predicted_class;1];
    else
        predicted_class=[predicted_class;-1];
    end

end
err = sum(predicted_class ~= ytest0);
accuracy=(no_test-err)/(no_test)*100
return
end
