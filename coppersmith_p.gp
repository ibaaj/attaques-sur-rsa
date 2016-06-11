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


print("Génération de RSA");

p=nextprime(random(10^128));
q=nextprime(random(10^128));
N=p*q;

print("N=p*q="N);
print("p="p);
print("q="q);

\\ on forme un nombre p0 de la taille de p
p0 = round(p/10^40)*10^40;

print("quelques bits de p " p0);


\\ on définit le polynôme
P=x+p0;

print("polynôme P=x+p0 \n");

\\ la borne
X = 10^40;

\\ les paramètres
m=1;
t=2;
r = coppersmith(P, N, X, m, t);

{
for(i=1,length(r),

  v = N/(p0 + r[i]);
  print("solution : "v);

);
}

print("on retrouve la factorisation");
