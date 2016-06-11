

allocatemem(512000000);
default(realprecision, 9000);


wiener(e,n) = {
  print("Inputs:");
  print("e:" e);
  print("n:" n);
  print("--------------------------");

  x = e/n;
  \\x = e/(n + 1   -2*sqrt(n));
  c = contfrac(x);
  i = 1;

  convergents = contfracpnqn(c, i);

  while(convergents[1,i]!=e,

    convergents = contfracpnqn(c, i);
    k = convergents[1,i];
    d = convergents[2,i];
    i++;

    if(k > 0,
        phi = ((e*d)-1)/k;
        x = n - phi + 1;


        p = ( x + sqrt( (x^2) - (4*n) ) ) / 2;
        q = ( x - sqrt( (x^2) - (4*n) ) ) / 2;


        if(type(p)=="t_REAL"&&truncate(p)*truncate(q)==n&&p>1&&q>1,

          print("Couple (p,q) trouvé via la méthode de Wiener:");
          p_ = floor(p);
          q_ = floor(q);
          print("p:"p_);
          print("q:"q_);

          return([p,q]);
        );
    );
  );
}
