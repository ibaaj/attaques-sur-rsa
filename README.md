
# Attaques sur RSA

## Wiener
exemple :

```
p = nextprime(random(10^100))
q = nextprime(random(10^100))
n = p*q
phin=(p-1)(q-1)
d=floor(0.1*n^(1/4))
while(gcd(d,phin)!=1,d=d+1)
E=lift(Mod(d,phin)^(-1))
wiener(E,n)
```

Efficace quand d < (1/3)*n^(1/4)



## de weger

```
phi(n) = e/(n + 1 +  -2*sqrt(n))
```

Efficace quand _p_ et _q_ sont proches.

## Coppersmith


* à partir de quelques bits de P (coppersmith_p.gp)
* à partir de quelques bits d'un message (coppersmith_message.gp)




## Attaque par factorisation (Msieve) via openSSL

2h pour N de taille 356 bits avec un ordinateur i7
Nécessite : [Msieve](http://github.com/radii/msieve) et [prim2pem](https://github.com/tomrittervg/prime2pem)


Ismail Baaj & J.Tourteaux
Juin 2015
Université Paris Diderot

## Attaques sur le padding avec la méthode de Coppersmith

I.Baaj & F.Guérin
Octobre 2016
Université Paris Diderot
