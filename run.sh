#!/bin/bash

modele_ticket=${1?Modèle de ticket}

stamp_file=$(mktemp --suffix=ticket_stamp)

numeroCarnet=9991

./generateStamp.sh ${numeroCarnet}01 $(( $numeroCarnet +1 ))01  $(( $numeroCarnet + 2 ))01  $(( $numeroCarnet + 3 ))01  $(( $numeroCarnet + 4 ))01 > $stamp_file

pdftk "$modele_ticket" multistamp $stamp_file output ticket_01.pdf

