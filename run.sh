#!/bin/bash

modele_carnet=${1?Modèle de Carnet}
nombre_ticket=${2?Nombre de ticket}

stamp_file=$(mktemp --suffix=ticket_stamp)

numero=1
tickets_par_modele=50

while [ $numero -lt $nombre_ticket ]
do
  echo -n "Generation Carnets contenant tickets $numero à $(($numero + $tickets_par_modele)) ..."
  ./generateStamp.sh $numero > "$stamp_file"
  pdftk "$modele_carnet" multistamp $stamp_file output carnets_tombolat_$(printf %05d $numero).pdf
  echo " carnets_tombolat_$(printf %05d $numero).pdf"
  numero=$(( $numero + $tickets_par_modele))
done

