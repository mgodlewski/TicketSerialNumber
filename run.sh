#!/bin/bash

modele_ticket=${1?Modèle de ticket}
nombre_ticket=${2?Nombre de ticket}

stamp_file=$(mktemp --suffix=ticket_stamp)

numero=1

while [ $numero -lt $nombre_ticket ]
do
  ./generateStamp.sh $numero > "$stamp_file"
  pdftk "$modele_ticket" multistamp $stamp_file output carnets_tombolat_$(printf %05d $numero).pdf
  numero=$(( $numero + 50))
done

