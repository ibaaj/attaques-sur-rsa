#!/bin/sh

# For stats ... echo "N,P,Q,E,D,tTotal,tMsieve,ValidMd5" >> stats.csv

start=$(($(gdate +%s%N)/1000));

echo "Paramètres : RSA $1 bits";

echo "1) générer la clé privée";
openssl genrsa -out privee.pem $1;

echo "La clé privée est : ";
cat privee.pem;

echo "2) générer la clé public depuis la clé privée";
openssl rsa -in privee.pem -pubout -out pub.pem;

echo "3) obtenir le couple n,e"
N=$(openssl rsa -in pub.pem -pubin -text -modulus | grep Modulus= | cut -d "=" -f 2);
E=$(openssl rsa -in pub.pem -pubin -text -modulus | grep "Exponent" | cut -d ":" -f 2 | sed 's/ (.*//');

Ndec=$(echo "ibase=16; $N"| bc | tr -d '\n\\');
echo "N en base 10:\n"$Ndec;


echo "Lancement de msieve....";
startMsieve=$(($(gdate +%s%N)/1000));
facteurs=($(./msieve -v -q $Ndec | awk -F":" '{print $2}' | tr '\n' ' '));
endMsieve=$(($(gdate +%s%N)/1000));
runtimeMsieve=$((endMsieve-startMsieve));
P=${facteurs[0]};
Q=${facteurs[1]};

echo "print(lift(Mod($E,(($P-1)*($Q-1)))^(-1))); quit;" >> GPtmpscript.gp
D=$(GP -q GPtmpscript.gp);
rm GPtmpscript.gp;
echo "Clee privée trouvée (decimal) : $D";

echo "$(python $(pwd)/prime2pem/prime2pem.py $P $Q $E)" >> PrivFound.pem;
echo "Génération du fichier de la clé privée : ";
cat PrivFound.pem;

md5priveefound=`md5 -q PrivFound.pem | awk '{ print $1 }'`;
echo "MD5 du fichier de la clé privée trouvée : " $md5priveefound;
md5privee=`md5 -q privee.pem | awk '{ print $1 }'`;
echo "MD5 de la clé privée générée par openssl : " $md5privee;

rm PrivFound.pem;



if [ "$md5priveefound" = "$md5privee" ]
  then
    validMD5="Oui"
  else
    validMD5="Non"
fi

end=$(($(gdate +%s%N)/1000));
runtimetotal=$((end-start));

echo "temps execution total:" $runtimetotal;
echo "temps execution MSieve:" $runtimeMsieve;
