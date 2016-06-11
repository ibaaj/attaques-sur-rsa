default(realprecision,9000);

coppersmith(P,N,X,m,t) = {
  resVec = MakeMultPoly(P,N,m,t);

  dres = length(resVec);

  B = matrix(dres,dres);


  \\ on refait une matrice avec les coefs
  for (i=1, dres,
    for (j=1, dres,
      B[j,i] = X^(j-1)*polcoeff(resVec[i], j-1)
  ));


  T = qflll(B,1); \\ LLL le tout

  B = B*T;

  \\ on refait un polynome

  polRes = 0;
  for (i=1, dres,
    polRes = polRes + x^(i-1) * B[i,1] / X^(i-1)
  );




  racines = polroots(polRes);
  nbracines = length(racines);

  res = [];

  for (i=1, nbracines,
    v = round(racines[i]); \\ pas real() mais round()
    if (conj(v)==v,
      res = concat(res, [v]);
    );
  );
  return(res);
}


MakeMultPoly(P,N,m,t) = {
  d =poldegree (P);
  result = [];

  \\ construction du vecteur des equations
  for (i=0, m-1,
    for (j=0, d-1,
      result = concat(result, [x^j * P^i *N^(m-i)]);
      );
  );
  for (i=0, t,
     result = concat(result, [P^m*x^i])
  );

  return(result);
}



p=nextprime(random(10^128));
q=nextprime(random(10^128));
N=p*q;

print("N=p*q="N);
print("p="p);
print("q="q);


e = 3;
print("e="e);

m = random (N); \\ le début du message
x0 = random (10^40); \\ le bout quon a pas




print("le début du message m="m);
print("le bout qu'on a pas x0="x0);

c = (m+x0)^e % N;

print("c=(m+x0)^e % N : "c);




P = (m+x)^e - c; \\ le poly
X=10^40;
m=1;
t=0;

print("le polynôme : P= (m+x)^e - c")


sol = coppersmith(P, N, X, m,t);
nbsol = length(sol);


{
for(i=1,nbsol,
  print("sol "i"=" sol[i]); \\ on retrouve x0
);
}

print("on retrouve x0");
