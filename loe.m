function result = loe(I, Ie);

[M N n] = size (I);

L = max(I,[],3);
Le = max(Ie,[],3);

r = 50 / min (M,N);
Md = round(M*r);
Nd = round(N*r);
%Md = 100;
%Nd = 100;
Ld =imresize(L,[Md Nd]);
Led =imresize(Le,[Md Nd]);

RD = zeros (Md,Nd);

for x = 1:Md
    for y = 1:Nd
        for i = 1:Md
            for j = 1:Nd
                E(i,j) = xor((Ld(x,y)>=Ld(i,j)),(Led(x,y)>=Led(i,j)));
            end
        end
        RD(x,y) = sum(E(:));

    end
end
result = sum(RD(:))/(Md*Nd);