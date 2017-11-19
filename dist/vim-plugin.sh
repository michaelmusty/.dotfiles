#!/bin/sh
ver=$(awk -Fv 'NR<2&&$0=$NF' VERSION) || exit
mkdir -p -- vim/dist || exit
cd -- vim/dist || exit
for pn ; do
    dn=vim-$(printf '%s' "$pn"|sed 's/_/-/g')-$ver
    mkdir -p -- "$pn"
    for fn in ../*/"$pn".txt ../*/"$pn".vim ; do
        [ -e "$fn" ] || continue
        sdn=$fn
        sdn=${sdn#../}
        sdn=${sdn%/*}
        mkdir -p -- "$pn"/"$sdn"
        cp -- "$fn" "$pn"/"$sdn"
    done
    tar c "$pn" | gzip > "$dn".tar.gz || exit
    rm -r -- "$pn"
done
