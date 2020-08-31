#!/bin/bash

domain=$1
wordlist="/home/ethicalman/tools/SecLists/Discovery/DNS/deepmagic.com-prefixes-top500.txt"
resolvers="/home/ethicalman/tools/massdns/lists"

echo " [*]Time to Chill... "

sub_enum(){

mkdir -p $domain/subdomain

sublist3r -d $domain -o $domain/subdomain/sublist3r.txt
subfinder -d $domain -o $domain/subdomain/subfinder.txt
assetfinder -subs-only $domain | tee $domain/subdomain/assetfinder.txt
#shuffledns -d $domain -w $wordlist -r $resolvers -o $domain/subdomain/shuffledns.txt

cat $domain/subdomain/*txt > $domain/subdomain/all.txt

}
sub_enum
resolving_domains(){
#shuffledns -d $domain -list $domain/subdomain/all.txt -o $domain/subdomain/domain.txt
}
resolving_domains

http_prob(){
cat $domain/subdomain/all.txt | httpx | tee $domain/subdomain/last.txt
}
http_prob

sort_domains(){
sort $domain/subdomain/last.txt | uniq | tee $domain/subdomain/final.txt
}
sort_domains
