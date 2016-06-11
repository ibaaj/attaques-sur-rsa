default(realprecision,9000)
default(parisize,"200M")
setrand(1);
p=nextprime(random(2^15));
q=nextprime(random(2^15));
N=p*q;
print(binary(length(N)))
print("N=p*q="N);
P = random(N);    \\ le padding
print("padding="P)
e = 3;            \\ expo public
print("expo="e)
X = floor(N^(1/3)); \\ N^(1/e - epsilon)
print("X="X)
x0 = random(X);   \\ le message inconnu
print("X0="x0)
C = lift( Mod((x0 + P)^e,N) ); \\ le chiffré
print("C="C)
print("coppersmith........")
print(zncoppersmith((P + x)^3 - C, N, X))
print(" = X0 ")
